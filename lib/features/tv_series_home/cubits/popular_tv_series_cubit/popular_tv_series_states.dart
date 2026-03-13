import 'package:movix/core/models/show_model.dart';

class PopularTVSeriesStates {
  final List<ShowModel> popularTVSeries;
  final bool popularHasReachedMax;
  final bool popularIsLoading;
  final String? errorMessage;

  const PopularTVSeriesStates({
    this.popularTVSeries = const [],
    this.popularHasReachedMax = false,
    this.popularIsLoading = false,
    this.errorMessage,
  });

  PopularTVSeriesStates copyWith({
    List<ShowModel>? popularTVSeries,
    
   
    bool? popularHasReachedMax,
    
    bool? popularIsLoading,
    String? errorMessage,
  }) {
    return PopularTVSeriesStates(
      popularTVSeries: popularTVSeries ?? this.popularTVSeries,
      popularHasReachedMax: popularHasReachedMax ?? this.popularHasReachedMax,
      popularIsLoading: popularIsLoading ?? this.popularIsLoading,
      errorMessage: errorMessage,
    );
  }

  @override
  String toString() {
    return 'PopularTVSeriesStates(popularTVSeries: ${popularTVSeries.length}, '
        'popularIsLoading: $popularIsLoading, '
        'popularHasReachedMax: $popularHasReachedMax, '
        'errorMessage: $errorMessage)';
  }
}
