part of 'rating_tv_serie_cubit.dart';

class RatingTVSerieState {
  final bool isSubmitting;
  final bool isRated;
  final double userRating;
  final String? errorMessage;
  final String? successMessage;

  const RatingTVSerieState({
    this.isSubmitting = false,
    this.isRated = false,
    this.userRating = 0.0,
    this.errorMessage,
    this.successMessage,
  });

  // The helper method to update specific fields without losing others
  RatingTVSerieState copyWith({
    bool? isSubmitting,
    bool? isRated,
    double? userRating,
    String? errorMessage,
    String? successMessage,
  }) {
    return RatingTVSerieState(
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isRated: isRated ?? this.isRated,
      userRating: userRating ?? this.userRating,
      errorMessage: errorMessage, // We usually want to clear error on next update
      successMessage: successMessage,
    );
  }

  @override
  List<Object?> get props => [isSubmitting, isRated, userRating, errorMessage, successMessage];
}
