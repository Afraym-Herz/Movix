import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movix/features/movies_home/cubits/top_rated_movies_cubit/top_rated_movies_states.dart';
import 'package:movix/core/repositories/movie_repository.dart';

class TopRatedMoviesCubit extends Cubit<TopRatedMoviesStates> {
  final MovieRepository _movieRepository;

  TopRatedMoviesCubit(this._movieRepository) : super(const TopRatedMoviesStates());

  int _topRatedCurrentPage = 1;

  void reset() {
    _topRatedCurrentPage = 1;
    emit(const TopRatedMoviesStates());
  }

  Future<void> fetchTopRatedMovies({bool refresh = false}) async {
    if (state.topRatedIsLoading) return;

    if (refresh) {
      _topRatedCurrentPage = 1;
      emit(const TopRatedMoviesStates(topRatedIsLoading: true));
    } else {
      if (state.topRatedHasReachedMax) return;
      if (isClosed) return;
      emit(state.copyWith(topRatedIsLoading: true));
    }

    final response = await _movieRepository.getTopRatedMovies(page: _topRatedCurrentPage);
    response.fold(
      (failure) => emit(state.copyWith(topRatedIsLoading: false, errorMessage: failure.message)),
      (data) {
        final topRatedMovies = refresh
            ? data.results
            : [...state.topRatedMovies, ...data.results];
        emit(
          state.copyWith(
            topRatedMovies: topRatedMovies,
            topRatedIsLoading: false,
            topRatedHasReachedMax: _topRatedCurrentPage >= data.totalPages,
            errorMessage: null,
          ),
        );
        _topRatedCurrentPage++;
      },
    );
  }
}
