import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movix/features/movie_details/repositories/movie_details_repository.dart';
part 'package:movix/features/movie_details/cubits/rating_movie_cubit/rating_movie_state.dart';

class RatingMovieCubit extends Cubit<RatingMovieState> {
  
  final MovieDetailsRepository _movieDetailsRepository;

  RatingMovieCubit( this._movieDetailsRepository) : super(const RatingMovieState.initial());

  Future<String> submitRating(int movieId, double rating) async {
    if (state.isSubmitting || state.isRated) return "You have already rated this movie";

    emit(state.copyWith(isSubmitting: true));

    final response = await _movieDetailsRepository.addMovieRating(
      movieId: movieId,
      rating: rating,
    );

    try {
      return response.fold(
        (l) {
          _movieDetailsRepository.removeMovieRating(movieId: movieId);
          emit(RatingMovieState._(errorMessage: l.message));
          return l.message;
        } ,
        (r){
          _movieDetailsRepository.addMovieRating(movieId: movieId,rating: 2*rating);
          emit(
            RatingMovieState._(
              isRated: true,
              successMessage: r,
              userRating: rating,
            ),
          );
          return r;
        },
      );
    } on Exception catch (e) {
      emit(RatingMovieState._(errorMessage: e.toString()));
      return e.toString();
    }
  }

  Future<void> getMovieRating(int movieId) async {
    final ratingValue = await _movieDetailsRepository.getMovieRating(movieId);
    ratingValue != null ? emit(state.copyWith(userRating: double.parse(ratingValue)/2)) : emit(state);
  }

  void clearMessages() {
    emit(RatingMovieState.clearMessages(state.userRating));
  }
}
