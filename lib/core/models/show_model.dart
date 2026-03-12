
abstract class ShowModel {
  final bool adult;
  final String? backdropPath;
  final int id;
  final String overview;
  final String? posterPath;
  final String originalLanguage;
  final List<int> genreIds;
  final double popularity;
  final double voteAverage;
  final int voteCount;

  const ShowModel({
    required this.adult,
    this.backdropPath,
    required this.id,
    required this.overview,
    this.posterPath,
    required this.originalLanguage,
    required this.genreIds,
    required this.popularity,
    required this.voteAverage,
    required this.voteCount,
  });

  String get displayTitle;
  String? get displayDate;
  Map<String, dynamic> toJson();

  String? get releaseYear => displayDate != null && displayDate!.length >= 4
      ? displayDate!.substring(0, 4) : null;

  String? get fullPosterUrl => posterPath != null
      ? 'https://image.tmdb.org/t/p/w500$posterPath' : null;

  String? get fullBackdropUrl => backdropPath != null
      ? 'https://image.tmdb.org/t/p/w1280$backdropPath' : null;

}