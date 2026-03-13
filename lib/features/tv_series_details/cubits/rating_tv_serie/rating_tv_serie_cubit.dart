import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movix/features/tv_series_details/repositories/tv_series_details_repository.dart';
part 'package:movix/features/tv_series_details/cubits/rating_tv_serie/rating_tv_serie_state.dart';

class RatingTVSerieCubit extends Cubit<RatingTVSerieState> {
  final TVSeriesDetailsRepository _tvSerieDetailsRepository;

  RatingTVSerieCubit(this._tvSerieDetailsRepository)
    : super(const RatingTVSerieState());

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

    try {
      final response = await _tvSerieDetailsRepository.addTVSeriesRating(
        tvSeriesId: tvSeriesId,
        rating: 2*rating,
      );
      response.fold(
        (l) {
          _tvSerieDetailsRepository.removeTVSeriesRating(tvSeriesId: tvSeriesId);
          emit(RatingTVSerieState(errorMessage: l.message));
        },
        (r) {
          _tvSerieDetailsRepository.addTVSeriesRating(
            tvSeriesId: tvSeriesId,
            rating: rating,
          );
          emit(
            RatingTVSerieState(
              isRated: true,
              successMessage: r,
              userRating: rating,
            ),
          );
          return;
        },
      );
    } on Exception catch (e) {
      emit(RatingTVSerieState(errorMessage: e.toString()));
    }
  }

  Future<void> fetchTVSeriesRating(int tvSeriesId) async {
    final ratingValue = await _tvSerieDetailsRepository.getTVSeriesRating(tvSeriesId);
    ratingValue != null ? emit(state.copyWith(userRating: double.parse(ratingValue))) : emit(state);
  }

  void reset() => emit(const RatingTVSerieState());
}
