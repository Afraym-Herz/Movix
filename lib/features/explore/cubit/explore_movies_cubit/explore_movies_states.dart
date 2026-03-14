import 'package:movix/core/models/show_model.dart';
import 'package:equatable/equatable.dart';

class ExploreMoviesStates extends Equatable {
  final List<ShowModel> exploreMovies;
  final bool exploreIsLoading;
  final bool exploreHasReachedMax;
  final String? errorMessage;
  final String? selectedCategory;

  const ExploreMoviesStates({
    this.exploreMovies = const [],
    this.exploreIsLoading = false,
    this.exploreHasReachedMax = false,
    this.errorMessage,
    this.selectedCategory,
  });

  ExploreMoviesStates copyWith({
    List<ShowModel>? exploreMovies,
    bool? exploreIsLoading,
    bool? exploreHasReachedMax,
    String? errorMessage,
    String? selectedCategory,
  }) {
    return ExploreMoviesStates(
      exploreMovies: exploreMovies ?? this.exploreMovies,
      exploreIsLoading: exploreIsLoading ?? this.exploreIsLoading,
      exploreHasReachedMax: exploreHasReachedMax ?? this.exploreHasReachedMax,
      errorMessage: errorMessage ?? this.errorMessage,
      selectedCategory: selectedCategory ?? this.selectedCategory,
    );
  }

  @override
  List<Object?> get props => [
        exploreMovies,
        exploreIsLoading,
        exploreHasReachedMax,
        errorMessage,
        selectedCategory,
      ];

  @override
  String toString() {
    return 'ExploreMoviesStates(exploreMovies: ${exploreMovies.length}, '
        'exploreIsLoading: $exploreIsLoading, '
        'exploreHasReachedMax: $exploreHasReachedMax, '
        'selectedCategory: $selectedCategory, '
        'errorMessage: $errorMessage)';
  }
}
