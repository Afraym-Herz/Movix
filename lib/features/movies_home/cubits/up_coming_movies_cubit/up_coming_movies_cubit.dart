import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movix/core/repositories/movie_repository.dart';
import 'package:movix/features/movies_home/cubits/up_coming_movies_cubit/up_coming_movies_states.dart';

class UpComingMoviesCubit extends Cubit<UpComingMoviesStates> {
  final MovieRepository _movieRepository;

  UpComingMoviesCubit(this._movieRepository) : super(const UpComingMoviesStates());

  int _upComingCurrentPage = 1;

  void reset() {
    _upComingCurrentPage = 1;
    emit(const UpComingMoviesStates());
  }

  Future<void> fetchUpComingMovies({bool refresh = false}) async {
    if (state.upComingIsLoading) return;

    if (refresh) {
      _upComingCurrentPage = 1;
      emit(const UpComingMoviesStates(upComingIsLoading: true));
    } else {
      if (state.upComingHasReachedMax) return;
      if (isClosed) return;
      emit(state.copyWith(upComingIsLoading: true));
    }

    final response = await _movieRepository.getUpComingMovies(
      page: _upComingCurrentPage,
    );
    response.fold((l) => emit(state.copyWith(errorMessage: l.message)), (r) {
      final upComingMovies =
          refresh ? r.results : [...state.upComingMovies, ...r.results];
      emit(
        state.copyWith(
          upComingMovies: upComingMovies,
          upComingIsLoading: false,
          upComingHasReachedMax: _upComingCurrentPage >= r.totalPages,
          errorMessage: null,
        ),
      );
      _upComingCurrentPage++;
    });
  }
}
