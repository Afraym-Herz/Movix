import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movix/features/movie_details/models/movie_details_model.dart';
import 'package:movix/features/movie_details/repositories/movie_details_repository.dart';

part 'movie_details_state.dart';

class MovieDetailsCubit extends Cubit<MovieDetailsState> {
  final MovieDetailsRepository _movieDetailsRepository;

  MovieDetailsCubit(this._movieDetailsRepository) : super(const MovieDetailsState.initial());

  Future<void> fetchMovieDetails(int movieId) async {
    emit(const MovieDetailsState.loading());
    
    try {
      final movieDetails = await _movieDetailsRepository.getMovieDetails(movieId);
      emit(MovieDetailsState.loaded(movieDetails));
    } catch (e) {
      emit(MovieDetailsState.error(e.toString()));
    }
  }

  void reset() {
    emit(const MovieDetailsState.initial());
  }
}
