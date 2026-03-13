

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movix/core/repositories/tv_series_repository.dart';
import 'package:movix/features/tv_series_home/cubits/latest_tv_series_cubit/latest_tv_states.dart';

class LatestTVSeriesCubit extends Cubit<LatestTVSeriesStates> {
  final TVSeriesRepository _tvSeriesRepository;

  int _latestTVSeriesCurrentPage = 1;

  LatestTVSeriesCubit(this._tvSeriesRepository) : super(const LatestTVSeriesStates());
  

  void reset() {
    _latestTVSeriesCurrentPage = 1;
    emit(const LatestTVSeriesStates());
  }

  Future<void> getLatestTVSeries({bool refresh = false}) async {
    if (state.latestTVSeriesIsLoading) return;

    if (refresh) {
      _latestTVSeriesCurrentPage = 1;
      emit(const LatestTVSeriesStates(latestTVSeriesIsLoading: true));
    } else {
      if (state.latestTVSeriesHasReachedMax) return;
      if (isClosed) return;
      emit(state.copyWith(latestTVSeriesIsLoading: true));
    }

   final response = await _tvSeriesRepository.getLatestTVSeries(
      page: _latestTVSeriesCurrentPage,
    );
    response.fold((l)=> emit(state.copyWith(errorMessage: l.message)) , (r){
      final latestTVSeries = refresh
          ? r.results
          : [...state.latestTVSeries, ...r.results];
      emit(
        state.copyWith(
          latestTVSeries: latestTVSeries,
          latestTVSeriesIsLoading: false,
          latestTVSeriesHasReachedMax: _latestTVSeriesCurrentPage >= r.totalPages,
          errorMessage: null,
        ),
      );
      _latestTVSeriesCurrentPage++;
    } );
  }
}
