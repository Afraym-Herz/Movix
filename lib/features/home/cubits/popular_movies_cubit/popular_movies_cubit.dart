import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movix/features/home/cubits/popular_movies_cubit/popular_movies_states.dart';
import 'package:movix/features/home/repositories/movie_repository.dart';


class PopularMoviesCubit extends Cubit<PopularMoviesStates> {
  final MovieRepository _movieRepository;

  PopularMoviesCubit(this._movieRepository) : super(const PopularMoviesStates());
  
  int _popularCurrentPage = 1;  

  void reset() {
    
    _popularCurrentPage = 1;
    emit(const PopularMoviesStates());
  }

  Future<void> fetchPopularMovies({bool refresh = false}) async {
    if (state.popularIsLoading) return;

    if (refresh) {
      _popularCurrentPage = 1;
      emit(const PopularMoviesStates(popularIsLoading: true));
    } else {
      if (state.popularHasReachedMax) return;
      if (isClosed) return;
      emit(state.copyWith(popularIsLoading: true));
    }

    try {
      final response = await _movieRepository.getPopularMovies(
        page: _popularCurrentPage,
      );

        final popularMovies = refresh ? response.results : [...state.popularMovies, ...response.results];

      emit(
        state.copyWith(
          popularMovies: popularMovies,
          popularIsLoading: false,
          popularHasReachedMax: _popularCurrentPage >= response.totalPages,
          errorMessage: null,
        ),
      );

      _popularCurrentPage++;
    } catch (e) {
      log('Error fetching popular movies: $e');
      emit(state.copyWith(popularIsLoading: false, errorMessage: e.toString()));
    }
  }
}
