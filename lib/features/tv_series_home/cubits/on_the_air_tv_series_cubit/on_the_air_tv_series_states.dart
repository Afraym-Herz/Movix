import 'package:movix/core/models/show_model.dart';

class OnTheAirTVSeriesStates {
  final List<ShowModel> onTheAirTVSeries;
  final bool onTheAirHasReachedMax;
  final bool onTheAirIsLoading;
  final String? errorMessage;

  const OnTheAirTVSeriesStates({
    this.onTheAirTVSeries = const [],
    this.onTheAirHasReachedMax = false,
    this.onTheAirIsLoading = false,
    this.errorMessage,
  });

  OnTheAirTVSeriesStates copyWith({
    List<ShowModel>? onTheAirTVSeries,
    
   
    bool? onTheAirHasReachedMax,
    
    bool? onTheAirIsLoading,
    String? errorMessage,
  }) {
    return OnTheAirTVSeriesStates(
      onTheAirTVSeries: onTheAirTVSeries ?? this.onTheAirTVSeries,
      onTheAirHasReachedMax: onTheAirHasReachedMax ?? this.onTheAirHasReachedMax,
      onTheAirIsLoading: onTheAirIsLoading ?? this.onTheAirIsLoading,
      errorMessage: errorMessage,
    );
  }

  @override
  String toString() {
    return 'OnTheAirTVSeriesStates(onTheAirTVSeries: ${onTheAirTVSeries.length}, '
        'onTheAirIsLoading: $onTheAirIsLoading, '
        'onTheAirHasReachedMax: $onTheAirHasReachedMax, '
        'errorMessage: $errorMessage)';
  }
}
