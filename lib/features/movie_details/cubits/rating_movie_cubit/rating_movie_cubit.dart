import 'package:flutter_bloc/flutter_bloc.dart';
import '../../repositories/movie_details_repository.dart';
import 'package:movix/features/movie_details/models/movie_details_model.dart';
part 'package:movix/features/movie_details/cubits/rating_movie_cubit/rating_movie_state.dart';

class RatingMovieCubit extends Cubit<RatingMovieState> {
  
  final MovieDetailsRepository _movieDetailsRepository;

  RatingMovieCubit( this._movieDetailsRepository) : super(const RatingMovieState.initial());

  Future<String> submitRating(MovieDetailsModel movie, double rating) async {
    if (state.isSubmitting) return "Already submitting";

    emit(state.copyWith(isSubmitting: true));

    // TMDB expects rating from 0.5 to 10.0. Our UI gives 1.0 to 5.0.
    final tmdbRating = rating * 2;

    final response = await _movieDetailsRepository.addMovieRating(
      movie: movie,
      rating: tmdbRating,
    );

    try {
      return response.fold(
        (l) {
          emit(state.copyWith(isSubmitting: false, errorMessage: l.message));
          return l.message;
        } ,
        (r){
          emit(
            state.copyWith(
              isSubmitting: false,
              isRated: true,
              successMessage: r,
              userRating: rating,
            ),
          );
          return r;
        },
      );
    } on Exception catch (e) {
      emit(state.copyWith(isSubmitting: false, errorMessage: e.toString()));
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
