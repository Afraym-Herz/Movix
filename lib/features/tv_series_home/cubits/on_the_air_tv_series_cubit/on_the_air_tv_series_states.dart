import 'package:movix/core/models/tv_series_model.dart';

class OnTheAirTvSeriesStates {
  final List<TVSeriesModel> onTheAirTVSeries;
  final bool onTheAirHasReachedMax;
  final bool onTheAirIsLoading;
  final String? errorMessage;

  const OnTheAirTvSeriesStates({
    this.onTheAirTVSeries = const [],
    this.onTheAirHasReachedMax = false,
    this.onTheAirIsLoading = false,
    this.errorMessage,
  });

  OnTheAirTvSeriesStates copyWith({
    List<TVSeriesModel>? onTheAirTVSeries,
    
   
    bool? onTheAirHasReachedMax,
    
    bool? onTheAirIsLoading,
    String? errorMessage,
  }) {
    return OnTheAirTvSeriesStates(
      onTheAirTVSeries: onTheAirTVSeries ?? this.onTheAirTVSeries,
      onTheAirHasReachedMax: onTheAirHasReachedMax ?? this.onTheAirHasReachedMax,
      onTheAirIsLoading: onTheAirIsLoading ?? this.onTheAirIsLoading,
      errorMessage: errorMessage,
    );
  }

  @override
  String toString() {
    return 'OnTheAirTvSeriesStates(onTheAirTVSeries: ${onTheAirTVSeries.length}, '
        'onTheAirIsLoading: $onTheAirIsLoading, '
        'onTheAirHasReachedMax: $onTheAirHasReachedMax, '
        'errorMessage: $errorMessage)';
  }
}
