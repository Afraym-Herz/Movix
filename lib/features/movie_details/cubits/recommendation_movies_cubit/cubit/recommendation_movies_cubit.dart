import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movix/core/repositories/movie_repository.dart';
import 'package:movix/features/movie_details/cubits/recommendation_movies_cubit/cubit/recommendation_movies_state.dart';

class RecommendationMoviesCubit extends Cubit<RecommendationMoviesState> {
  final MovieRepository _moviesRepository;

  RecommendationMoviesCubit(this._moviesRepository)
    : super(const RecommendationMoviesState());

  int _recommendedCurrentPage = 1;

  void reset() {
    _recommendedCurrentPage = 1;
    emit(const RecommendationMoviesState( ));
  }

  Future<void> fetchRecommendedMovies({
    required int movieId,
    bool refresh = false,
  }) async {
    if (state.recommendedIsLoading) return;

    if (refresh) {
      _recommendedCurrentPage = 1;
      emit(const RecommendationMoviesState(recommendedIsLoading: true));
    } else {
      if (state.recommendedHasReachedMax) return;
      if (isClosed) return;
      emit(state.copyWith(recommendedIsLoading: true));
    }

    try {
      final response = await _moviesRepository.getRecommendedMovies(
        movieId: movieId,
        page: _recommendedCurrentPage,
      );

      final recommendedMovies = refresh
          ? response.results
          : [...state.recommendedMovies, ...response.results];

      emit(
        state.copyWith(
          recommendedMovies: recommendedMovies,
          recommendedIsLoading: false,
          recommendedHasReachedMax:
          _recommendedCurrentPage >= response.totalPages,
          errorMessage: null,
        ),
      );

      _recommendedCurrentPage++;
    } catch (e) {
      log('Error fetching recommended movies: $e');
      emit(
        state.copyWith(recommendedIsLoading: false, errorMessage: e.toString()),
      );
    }
  }
}
