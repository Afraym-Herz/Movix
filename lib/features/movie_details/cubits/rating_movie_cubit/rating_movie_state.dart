part of 'rating_movie_cubit.dart';

class RatingMovieState {
  final bool isSubmitting;
  final bool isRated;
  final double userRating;
  final String? errorMessage;
  final String? successMessage;

  const RatingMovieState._({
    this.isSubmitting = false,
    this.isRated = false,
    this.userRating = 0.0,
    this.errorMessage,
    this.successMessage,
  });

  const RatingMovieState.initial() : this._();

  const RatingMovieState.submitting(double rating)
    : this._(isSubmitting: true, userRating: rating);

  const RatingMovieState.success(double rating, String message)
    : this._(isRated: true, userRating: rating, successMessage: message);

  const RatingMovieState.error(String errorMessage, double currentRating)
    : this._(errorMessage: errorMessage, userRating: currentRating);

    const RatingMovieState.clearMessages(double rating)
      : this._(userRating: rating);

  RatingMovieState copyWith({
    bool? isSubmitting,
    bool? isRated,
    double? userRating,
    String? errorMessage,
    String? successMessage,
  }) {
    return RatingMovieState._(
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isRated: isRated ?? this.isRated,
      userRating: userRating ?? this.userRating,
      errorMessage: errorMessage,
      successMessage: successMessage,
    );
  }
const RatingMovieState.reset() : this._();
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is RatingMovieState &&
        other.isSubmitting == isSubmitting &&
        other.isRated == isRated &&
        other.userRating == userRating &&
        other.errorMessage == errorMessage &&
        other.successMessage == successMessage;
  }

  @override
  int get hashCode {
    return isSubmitting.hashCode ^
        isRated.hashCode ^
        userRating.hashCode ^
        errorMessage.hashCode ^
        successMessage.hashCode;
  }

  @override
  String toString() {
    return 'RatingMovieState(isSubmitting: $isSubmitting, isRated: $isRated, '
        'userRating: $userRating, errorMessage: $errorMessage, '
        'successMessage: $successMessage)';
  }
}
