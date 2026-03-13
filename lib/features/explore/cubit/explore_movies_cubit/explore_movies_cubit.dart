
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movix/core/repositories/movie_repository.dart';
import 'package:movix/features/explore/cubit/explore_movies_cubit/explore_movies_states.dart';

class ExploreMoviesCubit extends Cubit<ExploreMoviesStates> {
  final MovieRepository _movieRepository;

  ExploreMoviesCubit(this._movieRepository) : super(const ExploreMoviesStates());

  Future<void> fetchExploreMovies({
    bool refresh = false,
    String? category,
  }) async {
    if (state.exploreIsLoading) return;

    emit(state.copyWith(
      exploreIsLoading: true,
      selectedCategory: category ?? state.selectedCategory,
    ));

    try {
      // For now, just fetching popular movies as explore movies
      // You might want to use a more specific method from repository
      final result = await _movieRepository.getPopularMovies(page: 1);

      result.fold(
        (failure) {
          emit(state.copyWith(
            exploreIsLoading: false,
            errorMessage: failure.message,
          ));
        },
        (showResponse) {
          emit(state.copyWith(
            exploreMovies: showResponse.results,
            exploreIsLoading: false,
            exploreHasReachedMax: true,
            errorMessage: null,
          ));
        },
      );
    } catch (e) {
      emit(state.copyWith(
        exploreIsLoading: false,
        errorMessage: e.toString(),
      ));
    }
  }
}
