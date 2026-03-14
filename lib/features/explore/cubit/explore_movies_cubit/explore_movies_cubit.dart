import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movix/features/explore/cubit/explore_movies_cubit/explore_movies_states.dart';
import 'package:movix/core/repositories/movie_repository.dart';

class ExploreMoviesCubit extends Cubit<ExploreMoviesStates> {
  final MovieRepository _movieRepository;

  ExploreMoviesCubit(this._movieRepository)
    : super(const ExploreMoviesStates());

  int _exploreCurrentPage = 1;

  void reset() {
    _exploreCurrentPage = 1;
    log('cubit reset');
    emit(const ExploreMoviesStates());
  }

  Future<void> fetchExploreMovies({
    bool refresh = false,
    required String category,
  }) async {
    if (state.exploreIsLoading) return;

    if (refresh) {
      _exploreCurrentPage = 1;
      emit(
        state.copyWith(
          exploreIsLoading: true,
          exploreMovies: [],
          exploreHasReachedMax: false,
          selectedCategory: category,
        ),
      );
    } else {
      if (state.exploreHasReachedMax || isClosed) return;
      emit(state.copyWith(exploreIsLoading: true));
    }

    final response = await _movieRepository.exploreMethod(
      category: category,
      page: _exploreCurrentPage,
    );
    response.fold(
      (l) => emit(
        state.copyWith(exploreIsLoading: false, errorMessage: l.message),
      ),
      (r) => emit(
        state.copyWith(
          exploreMovies: refresh
              ? r.movies
              : [...state.exploreMovies, ...r.movies],
          exploreIsLoading: false,
          exploreHasReachedMax: _exploreCurrentPage >= r.totalPages,
          errorMessage: null,
        ),
      ),
    );

    _exploreCurrentPage++;
  }
}
