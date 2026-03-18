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

    final tmdbRating = rating * 2;

    

    try {
      final response = await _movieDetailsRepository.addMovieRating(
      movie: movie,
      rating: tmdbRating,
    );
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
    if (ratingValue != null) {
    final double? parsed = double.tryParse(ratingValue);
    if (parsed != null) {
      emit(state.copyWith(userRating: parsed / 2));
    }
  }
  }

  void clearMessages() {
    emit(RatingMovieState.clearMessages(state.userRating));
  }
}
