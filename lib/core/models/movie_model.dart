import 'package:movix/core/models/show_model.dart';

class MovieModel extends ShowModel {
  final String title;
  final String originalTitle;
  final String? releaseDate;
  final bool video;

  const MovieModel({
    required super.adult,
    super.backdropPath,
    required super.id,
    required super.overview,
    super.posterPath,
    required super.originalLanguage,
    required super.genreIds,
    required super.popularity,
    required super.voteAverage,
    required super.voteCount,
    required this.title,
    required this.originalTitle,
    this.releaseDate,
    required this.video,
  });

  @override
  String get disPlayTitle => title;

  @override
  String? get displayDate => releaseDate;

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
      adult: json['adult'] as bool? ?? false,
      backdropPath: json['backdrop_path'] as String?,
      id: json['id'] as int? ?? 0,
      overview: json['overview'] as String? ?? '',
      posterPath: json['poster_path'] as String?,
      originalLanguage: json['original_language'] as String? ?? '',
      genreIds: (json['genre_ids'] as List<dynamic>?)
              ?.map((id) => id as int).toList() ?? [],
      popularity: (json['popularity'] as num?)?.toDouble() ?? 0,
      voteAverage: (json['vote_average'] as num?)?.toDouble() ?? 0,
      voteCount: json['vote_count'] as int? ?? 0,
      title: json['title'] as String? ?? '',
      originalTitle: json['original_title'] as String? ?? '',
      releaseDate: json['release_date'] as String?,
      video: json['video'] as bool? ?? false,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'adult': adult,
      'backdrop_path': backdropPath,
      'id': id,
      'overview': overview,
      'poster_path': posterPath,
      'original_language': originalLanguage,
      'genre_ids': genreIds,
      'popularity': popularity,
      'vote_average': voteAverage,
      'vote_count': voteCount,
      'title': title,
      'original_title': originalTitle,
      'release_date': releaseDate,
      'video': video,
    };
  }
}
