import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movix/features/tv_series_details/repositories/tv_series_details_repository.dart';
import 'tv_series_details_state.dart';

class TVSeriesDetailsCubit extends Cubit<TVSeriesDetailsState> {
  final TVSeriesDetailsRepository _repository;

  TVSeriesDetailsCubit(this._repository)
      : super(const TVSeriesDetailsState.initial());

  Future<void> fetchTVSeriesDetails(int tvSeriesId) async {
    emit(const TVSeriesDetailsState.loading());
    try {
      final details = await _repository.getTVSeriesDetails(tvSeriesId);
      emit(TVSeriesDetailsState.loaded(details));
    } catch (e) {
      emit(TVSeriesDetailsState.error(e.toString()));
    }
  }
}
