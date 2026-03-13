
import 'package:movix/core/models/show_model.dart';

class TopRatedMoviesStates {
  final List<ShowModel> topRatedMovies;
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
    List<ShowModel>? topRatedMovies,
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
