part of 'movie_details_cubit.dart';

class MovieDetailsState {
  final bool isLoading;
  final MovieDetailsModel? movieDetails;
  final String? errorMessage;

  const MovieDetailsState._({
    this.isLoading = false,
    this.movieDetails,
    this.errorMessage,
  });

  const MovieDetailsState.initial() : this._();

  const MovieDetailsState.loading() : this._(isLoading: true);

  const MovieDetailsState.loaded(MovieDetailsModel movieDetails)
      : this._(movieDetails: movieDetails);

  const MovieDetailsState.error(String errorMessage)
      : this._(errorMessage: errorMessage);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is MovieDetailsState &&
        other.isLoading == isLoading &&
        other.movieDetails == movieDetails &&
        other.errorMessage == errorMessage;
  }

  @override
  int get hashCode {
    return isLoading.hashCode ^
        movieDetails.hashCode ^
        errorMessage.hashCode;
  }

  @override
  String toString() {
    return 'MovieDetailsState(isLoading: $isLoading, '
        'movieDetails: $movieDetails, '
        'errorMessage: $errorMessage)';
  }
}
