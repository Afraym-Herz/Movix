part of 'movie_cubit.dart';

class MovieState {
  final bool isLoading;
  final MovieResponse? movieResponse;
  final String? errorMessage;

  const MovieState._({
    this.isLoading = false,
    this.movieResponse,
    this.errorMessage,
  });

  const MovieState.initial() : this._();

  const MovieState.loading() : this._(isLoading: true);

  const MovieState.loaded(MovieResponse movieResponse)
      : this._(movieResponse: movieResponse);

  const MovieState.error(String errorMessage)
      : this._(errorMessage: errorMessage);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is MovieState &&
        other.isLoading == isLoading &&
        other.movieResponse == movieResponse &&
        other.errorMessage == errorMessage;
  }

  @override
  int get hashCode {
    return isLoading.hashCode ^
        movieResponse.hashCode ^
        errorMessage.hashCode;
  }

  @override
  String toString() {
    return 'MovieState(isLoading: $isLoading, '
        'movieResponse: $movieResponse, '
        'errorMessage: $errorMessage)';
  }
}
