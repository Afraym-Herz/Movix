
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movix/features/movies_home/cubits/now_playing_movies_cubit/now_playing_movies_states.dart';
import 'package:movix/core/repositories/movie_repository.dart';

class NowPlayingMoviesCubit extends Cubit<NowPlayingMoviesStates> {
  final MovieRepository _movieRepository;

  NowPlayingMoviesCubit(this._movieRepository)
    : super(const NowPlayingMoviesStates());

  int _nowPlayingCurrentPage = 1;

  void reset() {
    _nowPlayingCurrentPage = 1;
    emit(const NowPlayingMoviesStates());
  }

  Future<void> fetchNowPlayingMovies({bool refresh = false}) async {
    if (state.nowPlayingIsLoading) return;

    if (refresh) {
      _nowPlayingCurrentPage = 1;
      emit(const NowPlayingMoviesStates(nowPlayingIsLoading: true));
    } else {
      if (state.nowPlayingHasReachedMax) return;
      if (isClosed) return;
      emit(state.copyWith(nowPlayingIsLoading: true));
    }

    final response = await _movieRepository.getNowPlayingMovies(
      page: _nowPlayingCurrentPage,
    );
    response.fold((l)=> emit(state.copyWith(errorMessage: l.message)) , (r) {
      final nowPlayingMovies = refresh
          ? r.results
          : [...state.nowPlayingMovies, ...r.results];
      emit(
        state.copyWith(
          nowPlayingMovies: nowPlayingMovies,
          nowPlayingIsLoading: false,
          nowPlayingHasReachedMax: _nowPlayingCurrentPage >= r.totalPages,
          errorMessage: null,
        ),
      );
      _nowPlayingCurrentPage++;
    });
  }
}
