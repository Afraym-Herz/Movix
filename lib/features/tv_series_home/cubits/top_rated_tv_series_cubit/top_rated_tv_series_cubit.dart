import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movix/core/repositories/tv_series_repository.dart';
import 'package:movix/features/tv_series_home/cubits/top_rated_tv_series_cubit/top_rated_tv_series_states.dart';

class TopRatedTVSeriesCubit extends Cubit<TopRatedTVSeriesStates> {
  final TVSeriesRepository _tvSeriesRepository;

  TopRatedTVSeriesCubit(this._tvSeriesRepository)
    : super(const TopRatedTVSeriesStates());

  int _topRatedCurrentPage = 1;

  void reset() {
    _topRatedCurrentPage = 1;
    emit(const TopRatedTVSeriesStates());
  }

  Future<void> fetchTopRatedTVSeries({bool refresh = false}) async {
    if (state.topRatedIsLoading) return;

    if (refresh) {
      _topRatedCurrentPage = 1;
      emit(const TopRatedTVSeriesStates(topRatedIsLoading: true));
    } else {
      if (state.topRatedHasReachedMax) return;
      if (isClosed) return;
      emit(state.copyWith(topRatedIsLoading: true));
    }

    final response = await _tvSeriesRepository.getTopRatedTVSeries(
      page: _topRatedCurrentPage,
    );
    response.fold(
      (l) => emit(state.copyWith(errorMessage: l.message, topRatedIsLoading: false)),
      (r) {
        final topRatedTVSeries = refresh
            ? r.results
            : [...state.topRatedTVSeries, ...r.results];
        emit(
          state.copyWith(
            topRatedTVSeries: topRatedTVSeries,
            topRatedIsLoading: false,
            topRatedHasReachedMax: _topRatedCurrentPage >= r.totalPages,
            errorMessage: null,
          ),
        );
        _topRatedCurrentPage++;
      },
    );
  }
}
