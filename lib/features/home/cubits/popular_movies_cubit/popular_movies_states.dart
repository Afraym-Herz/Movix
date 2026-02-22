
import 'package:movix/features/home/models/movie.dart';

class PopularMoviesStates {
  final List<Movie> popularMovies;
  final bool popularHasReachedMax;
  final bool popularIsLoading;
  final String? errorMessage;

  const PopularMoviesStates({
    this.popularMovies = const [],
    this.popularHasReachedMax = false,
    this.popularIsLoading = false,
    this.errorMessage,
  });

  PopularMoviesStates copyWith({
    List<Movie>? popularMovies,
    
   
    bool? popularHasReachedMax,
    
    bool? popularIsLoading,
    String? errorMessage,
  }) {
    return PopularMoviesStates(
      popularMovies: popularMovies ?? this.popularMovies,
      popularHasReachedMax: popularHasReachedMax ?? this.popularHasReachedMax,
      popularIsLoading: popularIsLoading ?? this.popularIsLoading,
      errorMessage: errorMessage,
    );
  }

  @override
  String toString() {
    return 'PopularMoviesStates(popularMovies: ${popularMovies.length}, '
        'popularIsLoading: $popularIsLoading, '
        'popularHasReachedMax: $popularHasReachedMax, '
        'errorMessage: $errorMessage)';
  }
}
