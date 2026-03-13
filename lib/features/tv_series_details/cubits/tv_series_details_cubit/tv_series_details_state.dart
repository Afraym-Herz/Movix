
import 'package:movix/features/tv_series_details/models/tv_series_details_model.dart';

class TVSeriesDetailsState {
  final TVSeriesDetailsModel? tvSeriesDetails;
  final bool isLoading;
  final String? errorMessage;

  const TVSeriesDetailsState({
    this.tvSeriesDetails,
    this.isLoading = false,
    this.errorMessage,
  });

  const TVSeriesDetailsState.initial() : this();

  const TVSeriesDetailsState.loading() : this(isLoading: true);

  const TVSeriesDetailsState.loaded(TVSeriesDetailsModel details)
      : this(tvSeriesDetails: details, isLoading: false);

  const TVSeriesDetailsState.error(String message)
      : this(errorMessage: message, isLoading: false);
}
