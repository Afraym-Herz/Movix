
import 'package:movix/features/home/models/movie.dart';

class TrendingMoviesStates {
  final List<Movie> trendingMovies;
  final bool trendingHasReachedMax;
  final bool trendingIsLoading;
  final String? errorMessage;

  const TrendingMoviesStates({
    this.trendingMovies = const [],
    this.trendingHasReachedMax = false,
    this.trendingIsLoading = false,
    this.errorMessage,
  });

  TrendingMoviesStates copyWith({
    List<Movie>? trendingMovies,
    
   
    bool? trendingHasReachedMax,
    
    bool? trendingIsLoading,
    String? errorMessage,
  }) {
    return TrendingMoviesStates(
      trendingMovies: trendingMovies ?? this.trendingMovies,
      trendingHasReachedMax: trendingHasReachedMax ?? this.trendingHasReachedMax,
      trendingIsLoading: trendingIsLoading ?? this.trendingIsLoading,
      errorMessage: errorMessage,
    );
  }

  @override
  String toString() {
    return 'TrendingMoviesStates(trendingMovies: ${trendingMovies.length}, '
        'trendingIsLoading: $trendingIsLoading, '
        'trendingHasReachedMax: $trendingHasReachedMax, '
        'errorMessage: $errorMessage)';
  }
}
