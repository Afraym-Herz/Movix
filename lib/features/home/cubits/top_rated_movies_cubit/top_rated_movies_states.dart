
import 'package:movix/features/home/models/movie.dart';

class TopRatedMoviesStates {
  final List<Movie> topRatedMovies;
  final bool topRatedHasReachedMax;
  final bool topRatedIsLoading;
  final String? errorMessage;

  const TopRatedMoviesStates({
    this.topRatedMovies = const [],
    this.topRatedHasReachedMax = false,
    this.topRatedIsLoading = false,
    this.errorMessage,
  });

  TopRatedMoviesStates copyWith({
    List<Movie>? topRatedMovies,
    
   
    bool? topRatedHasReachedMax,
    
    bool? topRatedIsLoading,
    String? errorMessage,
  }) {
    return TopRatedMoviesStates(
      topRatedMovies: topRatedMovies ?? this.topRatedMovies,
      topRatedHasReachedMax: topRatedHasReachedMax ?? this.topRatedHasReachedMax,
      topRatedIsLoading: topRatedIsLoading ?? this.topRatedIsLoading,
      errorMessage: errorMessage,
    );
  }

  @override
  String toString() {
    return 'TopRatedMoviesStates(topRatedMovies: ${topRatedMovies.length}, '
        'topRatedIsLoading: $topRatedIsLoading, '
        'topRatedHasReachedMax: $topRatedHasReachedMax, '
        'errorMessage: $errorMessage)';
  }
}
