import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movix/features/movies/models/movie_response.dart';
import 'package:movix/features/movies/repositories/movie_repository.dart';

part 'movie_state.dart';

class MovieCubit extends Cubit<MovieState> {
  final MovieRepository _movieRepository;

  MovieCubit(this._movieRepository) : super(const MovieState.initial());

  /// Fetch top rated movies
  Future<void> fetchTopRatedMovies({int page = 1}) async {
    emit(const MovieState.loading());
    
    try {
      final movieResponse = await _movieRepository.getTopRatedMovies(page: page);
      emit(MovieState.loaded(movieResponse));
    } catch (e) {
      emit(MovieState.error(e.toString()));
    }
  }

  /// Reset the state to initial
  void reset() {
    emit(const MovieState.initial());
  }
}
