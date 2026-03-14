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
    emit(const RecommendationMoviesState());
  }

  Future<void> fetchRecommendedMovies({
    required int movieId,
    bool refresh = false,
  }) async {
    log(movieId.toString());
    if (state.recommendedIsLoading) return;
    log(movieId.toString());
    if (refresh) {
      _recommendedCurrentPage = 1;
      emit(const RecommendationMoviesState(recommendedIsLoading: true));
    } else {
      if (state.recommendedHasReachedMax) return;
      if (isClosed) return;
      emit(state.copyWith(recommendedIsLoading: true));
    }

    final response = await _moviesRepository.getRecommendedMovies(
      movieId: movieId,
      page: _recommendedCurrentPage,
    );
    
    response.fold(
      (l) => emit(
        state.copyWith(
          recommendedIsLoading: false,
          recommendedHasReachedMax: true,
          errorMessage: l.message,
        ),
      ),
      (r) =>emit(
        state.copyWith(
          recommendedMovies: refresh
              ? r.movies
              : [...state.recommendedMovies, ...r.movies],
          recommendedIsLoading: false,
          recommendedHasReachedMax: _recommendedCurrentPage >= r.totalPages,
          errorMessage: null,
        ),
      ), 
    );
  }
}
