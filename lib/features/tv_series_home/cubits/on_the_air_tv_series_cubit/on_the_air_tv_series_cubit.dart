

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movix/core/repositories/tv_series_repository.dart';
import 'package:movix/features/tv_series_home/cubits/on_the_air_tv_series_cubit/on_the_air_tv_series_states.dart';

class OnTheAirTVSeriesCubit extends Cubit<OnTheAirTVSeriesStates> {
  final TVSeriesRepository _tvSeriesRepository;

  OnTheAirTVSeriesCubit(this._tvSeriesRepository)
    : super(const OnTheAirTVSeriesStates());

  int _onTheAirCurrentPage = 1;

  void reset() {
    _onTheAirCurrentPage = 1;
    emit(const OnTheAirTVSeriesStates());
  }

  Future<void> fetchOnTheAirTVSeries({bool refresh = false}) async {
    if (state.onTheAirIsLoading) return;

    if (refresh) {
      _onTheAirCurrentPage = 1;
      emit(const OnTheAirTVSeriesStates(onTheAirIsLoading: true));
    } else {
      if (state.onTheAirHasReachedMax) return;
      if (isClosed) return;
      emit(state.copyWith(onTheAirIsLoading: true));
    }

   final response = await _tvSeriesRepository.getOnTheAirTVSeries(
      page: _onTheAirCurrentPage,
    );
    response.fold((l)=> emit(state.copyWith(errorMessage: l.message)) , (r){
      final onTheAirTVSeries = refresh
          ? r.results
          : [...state.onTheAirTVSeries, ...r.results];
      emit(
        state.copyWith(
          onTheAirTVSeries: onTheAirTVSeries,
          onTheAirIsLoading: false,
          onTheAirHasReachedMax: _onTheAirCurrentPage >= r.totalPages,
          errorMessage: null,
        ),
      );
      _onTheAirCurrentPage++;
    } );
  }
}
