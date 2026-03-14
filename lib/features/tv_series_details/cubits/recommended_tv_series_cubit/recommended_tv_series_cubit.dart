import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movix/core/repositories/tv_series_repository.dart';
import 'package:movix/features/tv_series_details/cubits/recommended_tv_series_cubit/recommended_tv_series_states.dart';

class RecommendedTVSeriesCubit extends Cubit<RecommendedTVSeriesStates> {
  final TVSeriesRepository _tvSeriesRepository;

  RecommendedTVSeriesCubit(this._tvSeriesRepository)
    : super(const RecommendedTVSeriesStates());

  int _recommendedCurrentPage = 1;

  void reset() {
    _recommendedCurrentPage = 1;
    emit(const RecommendedTVSeriesStates());
  }

  Future<void> fetchRecommendedTVSeries({
    required int tvSeriesId,
    bool refresh = false,
  }) async {
    if (state.recommendedIsLoading) return;

    if (refresh) {
      _recommendedCurrentPage = 1;
      emit(const RecommendedTVSeriesStates(recommendedIsLoading: true));
    } else {
      if (state.recommendedHasReachedMax) return;
      if (isClosed) return;
      emit(state.copyWith(recommendedIsLoading: true));
    }

    final response = await _tvSeriesRepository.getRecommendedTVSeries(
      tvSeriesId: tvSeriesId,
      page: _recommendedCurrentPage,
    );
    response.fold(
      (l) => emit(state.copyWith(errorMessage: l.message)),
      (r) => emit(
        state.copyWith(
          recommendedTVSeries: refresh
              ? r.results
              : [...state.recommendedTVSeries, ...r.results],
          recommendedIsLoading: false,
          recommendedHasReachedMax: _recommendedCurrentPage >= r.totalPages,
          errorMessage: null,
        ),
      ),
    );
    _recommendedCurrentPage++;
  }
}

