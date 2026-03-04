import 'package:movix/core/models/tv_series_model.dart';

class LatestTVSeriesStates {
  final List<TVSeriesModel> latestTVSeries;
  final bool latestTVSeriesHasReachedMax;
  final bool latestTVSeriesIsLoading;
  final String? errorMessage;

  const LatestTVSeriesStates({
    this.latestTVSeries = const [],
    this.latestTVSeriesHasReachedMax = false,
    this.latestTVSeriesIsLoading = false,
    this.errorMessage,
  });

  LatestTVSeriesStates copyWith({
    List<TVSeriesModel>? latestTVSeries,
    
   
    bool? latestTVSeriesHasReachedMax,
    
    bool? latestTVSeriesIsLoading,
    String? errorMessage,
  }) {
    return LatestTVSeriesStates(
      latestTVSeries: latestTVSeries ?? this.latestTVSeries,
      latestTVSeriesHasReachedMax: latestTVSeriesHasReachedMax ?? this.latestTVSeriesHasReachedMax,
      latestTVSeriesIsLoading: latestTVSeriesIsLoading ?? this.latestTVSeriesIsLoading,
      errorMessage: errorMessage,
    );
  }

  @override
  String toString() {
    return 'latestTVSeriesStates(latestTVSeries: ${latestTVSeries.length}, '
        'latestTVSeriesIsLoading: $latestTVSeriesIsLoading, '
        'latestTVSeriesHasReachedMax: $latestTVSeriesHasReachedMax, '
        'errorMessage: $errorMessage)';
  }
}
