import 'package:movix/core/models/show_model.dart';

class AiringTodayTVSeriesStates {
  final List<ShowModel> airingTodayTVSeries;
  final bool airingTodayHasReachedMax;
  final bool airingTodayIsLoading;
  final String? errorMessage;

  const AiringTodayTVSeriesStates({
    this.airingTodayTVSeries = const [],
    this.airingTodayHasReachedMax = false,
    this.airingTodayIsLoading = false,
    this.errorMessage,
  });

  AiringTodayTVSeriesStates copyWith({
    List<ShowModel>? airingTodayTVSeries,
    
    bool? airingTodayHasReachedMax,
    
    bool? airingTodayIsLoading,
    
    String? errorMessage,
  }) {
    return AiringTodayTVSeriesStates(
      airingTodayTVSeries: airingTodayTVSeries ?? this.airingTodayTVSeries,
      airingTodayHasReachedMax: airingTodayHasReachedMax ?? this.airingTodayHasReachedMax,
      airingTodayIsLoading: airingTodayIsLoading ?? this.airingTodayIsLoading,
      errorMessage: errorMessage,
    );
  }

  @override
  String toString() {
    return 'airingTodayTVSeriesStates(airingTodayTVSeries: ${airingTodayTVSeries.length}, '
        'airingTodayIsLoading: $airingTodayIsLoading, '
        'airingTodayHasReachedMax: $airingTodayHasReachedMax, '
        'errorMessage: $errorMessage)';
  }
}
