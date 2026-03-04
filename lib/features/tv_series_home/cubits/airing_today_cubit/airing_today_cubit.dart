import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movix/core/repositories/tv_series_repository.dart';
import 'package:movix/features/tv_series_home/cubits/airing_today_cubit/airing_today_states.dart';

class AiringTVSeriesCubit extends Cubit<AiringTodayTVSeriesStates> {
  final TVSeriesRepository _tvSeriesRepository;

  AiringTVSeriesCubit(this._tvSeriesRepository)
    : super(const AiringTodayTVSeriesStates());

  int _airingTodayCurrentPage = 1;

  void reset() {
    _airingTodayCurrentPage = 1;
    emit(const AiringTodayTVSeriesStates());
  }

  Future<void> fetchAiringTodayTVSeries({bool refresh = false}) async {
    if (state.airingTodayIsLoading) return;

    if (refresh) {
      _airingTodayCurrentPage = 1;
      emit(const AiringTodayTVSeriesStates(airingTodayIsLoading: true));
    } else {
      if (state.airingTodayHasReachedMax) return;
      if (isClosed) return;
      emit(state.copyWith(airingTodayIsLoading: true));
    }

   final response = await _tvSeriesRepository.getAiringTodayTVSeries(
      page: _airingTodayCurrentPage,
    );
    response.fold((l) {
      final airingTodayTVSeries = refresh
          ? l.results
          : [...state.airingTodayTVSeries, ...l.results];
      emit(
        state.copyWith(
          airingTodayTVSeries: airingTodayTVSeries,
          airingTodayIsLoading: false,
          airingTodayHasReachedMax: _airingTodayCurrentPage >= l.totalPages,
          errorMessage: null,
        ),
      );
      _airingTodayCurrentPage++;
    }, (r) => emit(state.copyWith(errorMessage: r.message)));
  }
}
