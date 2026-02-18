part of 'movie_cubit.dart';

class MovieState {
  final List<Movie> movies;
  final bool isLoading;
  final bool hasReachedMax;
  final String? errorMessage;

  const MovieState({
    this.movies = const [],
    this.isLoading = false,
    this.hasReachedMax = false,
    this.errorMessage,
  });

  MovieState copyWith({
    List<Movie>? movies,
    bool? isLoading,
    bool? hasReachedMax,
    String? errorMessage,
  }) {
    return MovieState(
      movies: movies ?? this.movies,
      isLoading: isLoading ?? this.isLoading,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      errorMessage: errorMessage,
    );
  }

  @override
  String toString() {
    return 'MovieState(movies: ${movies.length}, '
        'isLoading: $isLoading, '
        'hasReachedMax: $hasReachedMax, '
        'errorMessage: $errorMessage)';
  }
}
