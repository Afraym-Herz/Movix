import 'package:movix/core/models/show_model.dart';

class TopRatedTVSeriesStates {
  final List<ShowModel> topRatedTVSeries;
  final bool topRatedHasReachedMax;
  final bool topRatedIsLoading;
  final String? errorMessage;

  const TopRatedTVSeriesStates({
    this.topRatedTVSeries = const [],
    this.topRatedHasReachedMax = false,
    this.topRatedIsLoading = false,
    this.errorMessage,
  });

  TopRatedTVSeriesStates copyWith({
    List<ShowModel>? topRatedTVSeries,
    bool? topRatedHasReachedMax,
    bool? topRatedIsLoading,
    String? errorMessage,
  }) {
    return TopRatedTVSeriesStates(
      topRatedTVSeries: topRatedTVSeries ?? this.topRatedTVSeries,
      topRatedHasReachedMax: topRatedHasReachedMax ?? this.topRatedHasReachedMax,
      topRatedIsLoading: topRatedIsLoading ?? this.topRatedIsLoading,
      errorMessage: errorMessage,
    );
  }

  @override
  String toString() {
    return 'TopRatedTVSeriesStates(topRatedTVSeries: ${topRatedTVSeries.length}, '
        'topRatedIsLoading: $topRatedIsLoading, '
        'topRatedHasReachedMax: $topRatedHasReachedMax, '
        'errorMessage: $errorMessage)';
  }
}
