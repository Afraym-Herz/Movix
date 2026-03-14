import 'package:movix/core/models/show_model.dart';

class TrendingMoviesStates {
  final List<ShowModel> trendingMovies;
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
    List<ShowModel>? trendingMovies,
    bool? trendingHasReachedMax,
    bool? trendingIsLoading,
    String? errorMessage,
  }) {
    return TrendingMoviesStates(
      trendingMovies: trendingMovies ?? this.trendingMovies,
      trendingHasReachedMax:
          trendingHasReachedMax ?? this.trendingHasReachedMax,
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
