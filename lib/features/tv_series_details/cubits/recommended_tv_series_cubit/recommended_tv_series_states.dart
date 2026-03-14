import 'package:movix/core/models/show_model.dart';

class RecommendedTVSeriesStates {
  final List<ShowModel> recommendedTVSeries;
  final bool recommendedIsLoading;
  final bool recommendedHasReachedMax;
  final String? errorMessage;

  const RecommendedTVSeriesStates({
    this.recommendedTVSeries = const [],
    this.recommendedIsLoading = false,
    this.recommendedHasReachedMax = false,
    this.errorMessage,
  });

  RecommendedTVSeriesStates copyWith({
    List<ShowModel>? recommendedTVSeries,
    bool? recommendedIsLoading,
    bool? recommendedHasReachedMax,
    String? errorMessage,
  }) {
    return RecommendedTVSeriesStates(
      recommendedTVSeries: recommendedTVSeries ?? this.recommendedTVSeries,
      recommendedIsLoading: recommendedIsLoading ?? this.recommendedIsLoading,
      recommendedHasReachedMax:
          recommendedHasReachedMax ?? this.recommendedHasReachedMax,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

