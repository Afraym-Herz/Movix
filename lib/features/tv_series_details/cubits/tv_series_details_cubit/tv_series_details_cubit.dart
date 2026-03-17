import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movix/features/tv_series_details/repositories/tv_series_details_repository.dart';
import 'package:movix/features/tv_series_details/cubits/tv_series_details_cubit/tv_series_details_states.dart';

class TVSeriesDetailsCubit extends Cubit<TVSeriesDetailsStates> {
  final TVSeriesDetailsRepository _tvSeriesDetailsRepository;

  TVSeriesDetailsCubit(this._tvSeriesDetailsRepository)
    : super(const TVSeriesDetailsStates.initial());

  Future<void> fetchTVSeriesDetails(int tvSeriesId) async {
    emit(const TVSeriesDetailsStates.loading());

    final result = await _tvSeriesDetailsRepository.getTVSeriesDetails(tvSeriesId);
    
    result.fold(
      (failure) => emit(TVSeriesDetailsStates.error(failure.message)),
      (details) => emit(TVSeriesDetailsStates.loaded(details)),
    );
  }

  Future<void> addTVSeriesRating({
    required double rating,
  }) async {
    try {
      final response = await _tvSeriesDetailsRepository.addTVSeriesRating(
        tvSeries: state.tvSeriesDetails!,
        rating: rating,
      );
      response.fold(
        (failure) => emit(TVSeriesDetailsStates.error(failure.message)),
        (success) => emit(TVSeriesDetailsStates.loaded(state.tvSeriesDetails!)),
      );
    } catch (e) {
      emit(TVSeriesDetailsStates.error(e.toString()));
    }
  }

  void reset() {
    emit(const TVSeriesDetailsStates.initial());
  }
}

