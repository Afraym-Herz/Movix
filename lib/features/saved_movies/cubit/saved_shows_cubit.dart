import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movix/core/services/secure_storage.dart';
import 'package:movix/features/saved_movies/cubit/saved_shows_states.dart';

class SavedShowsCubit extends Cubit<SavedShowsStates> {
  final SecureStorage _secureStorage;

  SavedShowsCubit(this._secureStorage) : super(SavedShowsInitial());

  Future<void> fetchSavedShows() async {
    emit(SavedShowsLoading());
    try {
      final ratedItems = await _secureStorage.getRatedItems();
      emit(SavedShowsSuccess(ratedItems));
    } catch (e) {
      emit(SavedShowsError(e.toString()));
    }
  }

  Future<void> deleteRatedShow(int showId) async {
    try {
      await _secureStorage.deleteRatedItem(showId);
      await fetchSavedShows();
    } catch (e) {
      emit(SavedShowsError(e.toString()));
    }
  }
}
