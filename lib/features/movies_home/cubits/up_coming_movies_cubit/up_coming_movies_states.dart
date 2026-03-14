import 'package:movix/core/models/show_model.dart';

class UpComingMoviesStates {
  final List<ShowModel> upComingMovies;
  final bool upComingHasReachedMax;
  final bool upComingIsLoading;
  final String? errorMessage;

  const UpComingMoviesStates({
    this.upComingMovies = const [],
    this.upComingHasReachedMax = false,
    this.upComingIsLoading = false,
    this.errorMessage,
  });

  UpComingMoviesStates copyWith({
    List<ShowModel>? upComingMovies,
    bool? upComingHasReachedMax,
    bool? upComingIsLoading,
    String? errorMessage,
  }) {
    return UpComingMoviesStates(
      upComingMovies: upComingMovies ?? this.upComingMovies,
      upComingHasReachedMax:
          upComingHasReachedMax ?? this.upComingHasReachedMax,
      upComingIsLoading: upComingIsLoading ?? this.upComingIsLoading,
      errorMessage: errorMessage,
    );
  }

  @override
  String toString() {
    return 'UpComingMoviesStates(upComingMovies: ${upComingMovies.length}, '
        'upComingIsLoading: $upComingIsLoading, '
        'upComingHasReachedMax: $upComingHasReachedMax, '
        'errorMessage: $errorMessage)';
  }
}
