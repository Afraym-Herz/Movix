import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movix/core/repositories/tv_series_repository.dart';
import 'package:movix/features/tv_series_home/cubits/popular_tv_series_cubit/popular_tv_series_states.dart';


class PopularTVSeriesCubit extends Cubit<PopularTVSeriesStates> {
  final TVSeriesRepository _tVSeriesRepository;

  PopularTVSeriesCubit(this._tVSeriesRepository) : super(const PopularTVSeriesStates());
  
  int _popularCurrentPage = 1;  

  void reset() {
    
    _popularCurrentPage = 1;
    emit(const PopularTVSeriesStates());
  }

  Future<void> fetchPopularTVSeries({bool refresh = false}) async {
    if (state.popularIsLoading) return;

    if (refresh) {
      _popularCurrentPage = 1;
      emit(const PopularTVSeriesStates(popularIsLoading: true));
    } else {
      if (state.popularHasReachedMax) return;
      if (isClosed) return;
      emit(state.copyWith(popularIsLoading: true));
    }

    final response = await _tVSeriesRepository.getPopularTVSeries(
      page: _popularCurrentPage,
    );
    response.fold((l) {
      final popularTVSeries = refresh
          ? l.results
          : [...state.popularTVSeries, ...l.results];
      emit(
        state.copyWith(
          popularTVSeries: popularTVSeries,
          popularIsLoading: false,
          popularHasReachedMax: _popularCurrentPage >= l.totalPages,
          errorMessage: null,
        ),
      );
      _popularCurrentPage++;
    }, (r) => emit(state.copyWith(errorMessage: r.message)));
  }
}
