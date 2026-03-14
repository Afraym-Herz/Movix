import 'package:movix/features/tv_series_details/models/tv_series_details_model.dart';

class TVSeriesDetailsStates {
  final TVSeriesDetailsModel? tvSeriesDetails;
  final bool isLoading;
  final String? errorMessage;

  const TVSeriesDetailsStates({
    this.tvSeriesDetails,
    this.isLoading = false,
    this.errorMessage,
  });

  const TVSeriesDetailsStates.initial() : this();

  const TVSeriesDetailsStates.loading() : this(isLoading: true);

  const TVSeriesDetailsStates.loaded(TVSeriesDetailsModel details)
      : this(tvSeriesDetails: details, isLoading: false);

  const TVSeriesDetailsStates.error(String message)
      : this(errorMessage: message, isLoading: false);
}

