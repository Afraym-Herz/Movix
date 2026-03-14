import 'package:movix/core/models/show_model.dart';

class NowPlayingMoviesStates {
  final List<ShowModel> nowPlayingMovies;
  final bool nowPlayingHasReachedMax;
  final bool nowPlayingIsLoading;
  final String? errorMessage;

  const NowPlayingMoviesStates({
    this.nowPlayingMovies = const [],
    this.nowPlayingHasReachedMax = false,
    this.nowPlayingIsLoading = false,
    this.errorMessage,
  });

  NowPlayingMoviesStates copyWith({
    List<ShowModel>? nowPlayingMovies,
    bool? nowPlayingHasReachedMax,
    bool? nowPlayingIsLoading,
    String? errorMessage,
  }) {
    return NowPlayingMoviesStates(
      nowPlayingMovies: nowPlayingMovies ?? this.nowPlayingMovies,
      nowPlayingHasReachedMax:
          nowPlayingHasReachedMax ?? this.nowPlayingHasReachedMax,
      nowPlayingIsLoading: nowPlayingIsLoading ?? this.nowPlayingIsLoading,
      errorMessage: errorMessage,
    );
  }

  @override
  String toString() {
    return 'NowPlayingMoviesStates(nowPlayingMovies: ${nowPlayingMovies.length}, '
        'nowPlayingIsLoading: $nowPlayingIsLoading, '
        'nowPlayingHasReachedMax: $nowPlayingHasReachedMax, '
        'errorMessage: $errorMessage)';
  }
}
