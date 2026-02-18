import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movix/features/home/models/movie.dart';
import 'package:movix/features/home/repositories/movie_repository.dart';

part 'movie_state.dart';

class MovieCubit extends Cubit<MovieState> {
  final MovieRepository _movieRepository;

  MovieCubit(this._movieRepository) : super(const MovieState());
int _currentPage = 1;
  /// Fetch top rated movies
  Future<void> fetchTopRatedMovies({bool refresh = false}) async {
    if (state.isLoading) return;

    if (refresh) {
      _currentPage = 1;
      emit(const MovieState(isLoading: true));
    } else {
      if (state.hasReachedMax) return;
      emit(state.copyWith(isLoading: true));
    }

    try {
      final response = await _movieRepository.getTopRatedMovies(page: _currentPage);

      final allMovies = refresh
          ? response.results
          : [...state.movies, ...response.results];

      emit(state.copyWith(
        movies: allMovies,
        isLoading: false,
        hasReachedMax: _currentPage >= response.totalPages,
        errorMessage: null,
      ));

      _currentPage++;
    } catch (e) {
      log('Error fetching top rated movies: $e');
        emit(state.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
      ));
    }
  }

  

  /// Fetch trending movies
  Future<void> fetchTrendingMovies({bool refresh = false}) async {
    if (state.isLoading) return;

    if (refresh) {
      _currentPage = 1;
      emit(const MovieState(isLoading: true));
    } else {
      if (state.hasReachedMax) return;
      emit(state.copyWith(isLoading: true));
    }

    try {
      final response = await _movieRepository.getTrendingMovies(page: _currentPage);

      final allMovies = refresh
          ? response.results
          : [...state.movies, ...response.results];

      emit(state.copyWith(
        movies: allMovies,
        isLoading: false,
        hasReachedMax: _currentPage >= response.totalPages,
        errorMessage: null,
      ));

      _currentPage++;
    } catch (e) {
      log('Error fetching trending movies: $e');
      emit(state.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
      ));
    }
  }

  void reset() {
    _currentPage = 1;
    emit(const MovieState());
  }

  Future<void> fetchPopularMovies({bool refresh = false}) async {
    if (state.isLoading) return;

    if (refresh) {
      _currentPage = 1;
      emit(const MovieState(isLoading: true));
    } else {
      if (state.hasReachedMax) return;
      emit(state.copyWith(isLoading: true));
    }
    
    try {
      final response = await _movieRepository.getPopularMovies(page: _currentPage);

      final allMovies = refresh
          ? response.results
          : [...state.movies, ...response.results];

      emit(state.copyWith(
        movies: allMovies,
        isLoading: false,
        hasReachedMax: _currentPage >= response.totalPages,
        errorMessage: null,
      ));

      _currentPage++;
    } catch (e) {
      log('Error fetching popular movies: $e');
      emit(state.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
      ));
    }
   
  }

  
}
