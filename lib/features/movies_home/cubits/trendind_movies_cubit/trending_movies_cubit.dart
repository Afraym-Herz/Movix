import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movix/core/repositories/movie_repository.dart';
import 'package:movix/features/movies_home/cubits/trendind_movies_cubit/trending_movies_states.dart';

class TrendingMoviesCubit extends Cubit<TrendingMoviesStates> {
  final MovieRepository _movieRepository;

  TrendingMoviesCubit(this._movieRepository) : super(const TrendingMoviesStates());

  int _trendingCurrentPage = 1;

  void reset() {
    _trendingCurrentPage = 1;
    emit(const TrendingMoviesStates());
  }

  Future<void> fetchTrendingMovies({bool refresh = false}) async {
    if (state.trendingIsLoading) return;

    if (refresh) {
      _trendingCurrentPage = 1;
      emit(const TrendingMoviesStates(trendingIsLoading: true));
    } else {
      if (state.trendingHasReachedMax) return;
      if (isClosed) return;
      emit(state.copyWith(trendingIsLoading: true));
    }

    final response = await _movieRepository.getTrendingMovies(
      page: _trendingCurrentPage,
    );
    response.fold((l) => emit(state.copyWith(errorMessage: l.message)), (r) {
      final trendingMovies =
          refresh ? r.results : [...state.trendingMovies, ...r.results];
      emit(
        state.copyWith(
          trendingMovies: trendingMovies,
          trendingIsLoading: false,
          trendingHasReachedMax: _trendingCurrentPage >= r.totalPages,
          errorMessage: null,
        ),
      );
      _trendingCurrentPage++;
    });
  }
}
