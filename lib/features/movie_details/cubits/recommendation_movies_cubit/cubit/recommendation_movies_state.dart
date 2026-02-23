
import 'package:movix/features/home/models/movie.dart';

class RecommendationMoviesState {
  final List<Movie> recommendedMovies;
  final bool recommendedHasReachedMax;
  final bool recommendedIsLoading;
  final String? errorMessage;

  const RecommendationMoviesState({
    this.recommendedMovies = const [],
    this.recommendedHasReachedMax = false,
    this.recommendedIsLoading = false,
    this.errorMessage,
  });

  RecommendationMoviesState copyWith({
    List<Movie>? recommendedMovies,
    
    bool? recommendedHasReachedMax,
    
    bool? recommendedIsLoading,
    String? errorMessage,
  }) {
    return RecommendationMoviesState(
      recommendedMovies: recommendedMovies ?? this.recommendedMovies,
      recommendedHasReachedMax: recommendedHasReachedMax ?? this.recommendedHasReachedMax,
      recommendedIsLoading: recommendedIsLoading ?? this.recommendedIsLoading,
      errorMessage: errorMessage,
    );
  }

  @override
  String toString() {
    return 'RecommendationMoviesState(recommendedMovies: ${recommendedMovies.length}, '
        'recommendedIsLoading: $recommendedIsLoading, '
        'recommendedHasReachedMax: $recommendedHasReachedMax, '
        'errorMessage: $errorMessage)';
  }
}

