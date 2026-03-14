import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movix/features/movies_home/cubits/popular_movies_cubit/popular_movies_states.dart';
import 'package:movix/core/repositories/movie_repository.dart';


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

   final response = await _movieRepository.getPopularMovies(
      page: _popularCurrentPage,
    );
    response.fold((l) => emit(state.copyWith(errorMessage: l.message)) , (r){
      final popularMovies = refresh
          ? r.results
          : [...state.popularMovies, ...r.results];
      emit(
        state.copyWith(
          popularMovies: popularMovies,
          popularIsLoading: false,
          popularHasReachedMax: _popularCurrentPage >= r.totalPages,
          errorMessage: null,
        ),
      );
      _popularCurrentPage++;
    });
  }
}
