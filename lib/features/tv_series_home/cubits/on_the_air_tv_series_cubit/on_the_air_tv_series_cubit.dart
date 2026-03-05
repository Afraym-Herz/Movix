import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movix/core/repositories/tv_series_repository.dart';
import 'package:movix/features/tv_series_home/cubits/on_the_air_tv_series_cubit/on_the_air_tv_series_states.dart';

class OnTheAirTvSeriesCubit extends Cubit<OnTheAirTvSeriesStates> {
  final TVSeriesRepository _tvSeriesRepository;

  OnTheAirTvSeriesCubit(this._tvSeriesRepository)
    : super(const OnTheAirTvSeriesStates());

  int _onTheAirCurrentPage = 1;

  void reset() {
    _onTheAirCurrentPage = 1;
    emit(const OnTheAirTvSeriesStates());
  }

  Future<void> fetchOnTheAirTVSeries({bool refresh = false}) async {
    if (state.onTheAirIsLoading) return;

    if (refresh) {
      _onTheAirCurrentPage = 1;
      emit(const OnTheAirTvSeriesStates(onTheAirIsLoading: true));
    } else {
      if (state.onTheAirHasReachedMax) return;
      if (isClosed) return;
      emit(state.copyWith(onTheAirIsLoading: true));
    }

   final response = await _tvSeriesRepository.getOnTheAirTVSeries(
      page: _onTheAirCurrentPage,
    );
    response.fold((l) {
      final onTheAirTVSeries = refresh
          ? l.results
          : [...state.onTheAirTVSeries, ...l.results];
      emit(
        state.copyWith(
          onTheAirTVSeries: onTheAirTVSeries,
          onTheAirIsLoading: false,
          onTheAirHasReachedMax: _onTheAirCurrentPage >= l.totalPages,
          errorMessage: null,
        ),
      );
      _onTheAirCurrentPage++;
    }, (r) => emit(state.copyWith(errorMessage: r.message)));
  }
}
