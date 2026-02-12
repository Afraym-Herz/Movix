import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movix/features/movies/models/movie_details.dart';
import 'package:movix/features/movies/repositories/movie_repository.dart';

part 'movie_details_state.dart';

class MovieDetailsCubit extends Cubit<MovieDetailsState> {
  final MovieRepository _movieRepository;

  MovieDetailsCubit(this._movieRepository) : super(const MovieDetailsState.initial());

  /// Fetch movie details by ID
  Future<void> fetchMovieDetails(int movieId) async {
    emit(const MovieDetailsState.loading());
    
    try {
      final movieDetails = await _movieRepository.getMovieDetails(movieId);
      emit(MovieDetailsState.loaded(movieDetails));
    } catch (e) {
      emit(MovieDetailsState.error(e.toString()));
    }
  }

  /// Reset the state to initial
  void reset() {
    emit(const MovieDetailsState.initial());
  }
}
