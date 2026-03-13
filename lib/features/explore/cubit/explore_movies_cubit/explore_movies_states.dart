
import 'package:movix/core/models/movie_model.dart';

class ExploreMoviesStates {
  final List<MovieModel> exploreMovies;
  final bool exploreHasReachedMax;
  final bool exploreIsLoading;
  final String? errorMessage;
  final String? selectedCategory;

  const ExploreMoviesStates({
    this.exploreMovies = const [],
    this.exploreHasReachedMax = false,
    this.exploreIsLoading = false,
    this.errorMessage,
    this.selectedCategory,
  });

  ExploreMoviesStates copyWith({
    List<MovieModel>? exploreMovies,
    
   
    bool? exploreHasReachedMax,
    
    bool? exploreIsLoading,
    String? errorMessage,
    String? selectedCategory,
  }) {
    return ExploreMoviesStates(
      exploreMovies: exploreMovies ?? this.exploreMovies,
      exploreHasReachedMax: exploreHasReachedMax ?? this.exploreHasReachedMax,
      exploreIsLoading: exploreIsLoading ?? this.exploreIsLoading,
      errorMessage: errorMessage,
      selectedCategory: selectedCategory ?? this.selectedCategory,
    );
  }

  @override
  String toString() {
    return 'ExploreMoviesStates(exploreMovies: ${exploreMovies.length}, '
        'exploreIsLoading: $exploreIsLoading, '
        'exploreHasReachedMax: $exploreHasReachedMax, '
        'selectedCategory: $selectedCategory, '
        'errorMessage: $errorMessage)';
  }
}
