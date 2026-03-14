part of 'rating_tv_series_cubit.dart';

class RatingTVSeriesStates {
  final bool isSubmitting;
  final bool isRated;
  final double userRating;
  final String? errorMessage;
  final String? successMessage;

  const RatingTVSeriesStates({
    this.isSubmitting = false,
    this.isRated = false,
    this.userRating = 0.0,
    this.errorMessage,
    this.successMessage,
  });

  RatingTVSeriesStates copyWith({
    bool? isSubmitting,
    bool? isRated,
    double? userRating,
    String? errorMessage,
    String? successMessage,
  }) {
    return RatingTVSeriesStates(
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isRated: isRated ?? this.isRated,
      userRating: userRating ?? this.userRating,
      errorMessage: errorMessage,
      successMessage: successMessage,
    );
  }

  List<Object?> get props => [isSubmitting, isRated, userRating, errorMessage, successMessage];
}

