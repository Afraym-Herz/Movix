import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movix/features/home/cubits/trendind_movies_cubit/trending_movies_states.dart';
import 'package:movix/features/home/repositories/movie_repository.dart';


class TrendingMoviesCubit extends Cubit<TrendingMoviesStates> {
  final MovieRepository _movieRepository;

  TrendingMoviesCubit(this._movieRepository) : super(const TrendingMoviesStates());
  
  int _popularCurrentPage = 1;  

  void reset() {
    
    _popularCurrentPage = 1;
    emit(const TrendingMoviesStates());
  }

  Future<void> fetchTrendingMovies({bool refresh = false}) async {
    if (state.trendingIsLoading) return;

    if (refresh) {
      _popularCurrentPage = 1;
      emit(const TrendingMoviesStates(trendingIsLoading: true));
    } else {
      if (state.trendingHasReachedMax) return;
      if (isClosed) return;
      emit(state.copyWith(trendingIsLoading: true));
    }

    try {
      final response = await _movieRepository.getTrendingMovies(
        page: _popularCurrentPage,
      );

        final trendingMovies = refresh ? response.results : [...state.trendingMovies, ...response.results];

      emit(
        state.copyWith(
          trendingMovies: trendingMovies,
          trendingIsLoading: false,
          trendingHasReachedMax: _popularCurrentPage >= response.totalPages,
          errorMessage: null,
        ),
      );

      _popularCurrentPage++;
    } catch (e) {
      log('Error fetching trending movies: $e');
      emit(state.copyWith(trendingIsLoading: false, errorMessage: e.toString()));
    }
  }
}
