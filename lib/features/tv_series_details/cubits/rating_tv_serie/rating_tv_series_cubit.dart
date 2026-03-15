import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movix/features/tv_series_details/repositories/tv_series_details_repository.dart';
part 'rating_tv_series_states.dart';

class RatingTVSeriesCubit extends Cubit<RatingTVSeriesStates> {
  final TVSeriesDetailsRepository _tvSeriesDetailsRepository;

  RatingTVSeriesCubit(this._tvSeriesDetailsRepository)
    : super(const RatingTVSeriesStates());

  Future<void> submitRating({
    required int tvSeriesId,
    required double rating,
  }) async {
    if (state.isSubmitting) return;

    emit(
      state.copyWith(
        isSubmitting: true,
        errorMessage: null,
        successMessage: null,
      ),
    );

    // TMDB expects rating from 0.5 to 10.0. Our UI gives 1.0 to 5.0.
    final tmdbRating = rating * 2;

    try {
      final response = await _tvSeriesDetailsRepository.addTVSeriesRating(
        tvSeriesId: tvSeriesId,
        rating: tmdbRating,
      );
      response.fold(
        (l) {
          emit(state.copyWith(errorMessage: l.message, isSubmitting: false));
        },
        (r) {
          emit(
            state.copyWith(
              isRated: true,
              successMessage: r,
              userRating: rating,
              isSubmitting: false,
            ),
          );
        },
      );
    } on Exception catch (e) {
      emit(state.copyWith(errorMessage: e.toString(), isSubmitting: false));
    }
  }

  Future<void> fetchTVSeriesRating(int tvSeriesId) async {
    final ratingValue = await _tvSeriesDetailsRepository.getTVSeriesRating(tvSeriesId);
    if (ratingValue != null) {
      emit(state.copyWith(userRating: double.parse(ratingValue) / 2));
    }
  }

  void reset() => emit(const RatingTVSeriesStates());
}

