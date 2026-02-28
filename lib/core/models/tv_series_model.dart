class TVSeriesModel {
  final bool adult;
  final String? backdropPath;
  final int id;
  final String title;
  final String originalName;
  final String overview;
  final String? posterPath;
  final String? mediaType;
  final String originalLanguage;
  final List<int> genreIds;
  final double popularity;
  final String? firstAirDate;
  final double voteAverage;
  final int voteCount;
  final List<String> originCountry;

  const TVSeriesModel({
    required this.adult,
    this.backdropPath,
    required this.id,
    required this.title,
    required this.originalName,
    required this.overview,
    this.posterPath,
    this.mediaType,
    required this.originalLanguage,
    required this.genreIds,
    required this.popularity,
    this.firstAirDate,
    required this.voteAverage,
    required this.voteCount,
    required this.originCountry,
  });

  factory TVSeriesModel.fromJson(Map<String, dynamic> json) {
    return TVSeriesModel(
      adult: json['adult'] as bool? ?? false,
      backdropPath: json['backdrop_path'] as String?,
      id: json['id'] as int? ?? 0,
      title: json['name'] as String? ?? '',
      originalName: json['original_name'] as String? ?? '',
      overview: json['overview'] as String? ?? '',
      posterPath: json['poster_path'] as String?,
      mediaType: json['media_type'] as String?,
      originalLanguage: json['original_language'] as String? ?? '',
      genreIds:
          (json['genre_ids'] as List<dynamic>?)
              ?.map((id) => id as int)
              .toList() ??
          [],
      popularity: (json['popularity'] as num?)?.toDouble() ?? 0.0,
      firstAirDate: json['first_air_date'] as String?,
      voteAverage: (json['vote_average'] as num?)?.toDouble() ?? 0.0,
      voteCount: json['vote_count'] as int? ?? 0,
      originCountry:
          (json['origin_country'] as List<dynamic>?)
              ?.map((country) => country as String)
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'adult': adult,
      'backdrop_path': backdropPath,
      'id': id,
      'name': title,
      'original_name': originalName,
      'overview': overview,
      'poster_path': posterPath,
      'media_type': mediaType,
      'original_language': originalLanguage,
      'genre_ids': genreIds,
      'popularity': popularity,
      'first_air_date': firstAirDate,
      'vote_average': voteAverage,
      'vote_count': voteCount,
      'origin_country': originCountry,
    };
  }

   /// Release year from releaseDate (e.g. "2024-01-15" -> "2024").
  String? get releaseYear =>
      firstAirDate != null && firstAirDate!.length >= 4
          ? firstAirDate!.substring(0, 4)
          : null;

  /// Full poster URL
  String? get fullPosterUrl {
    if (posterPath == null) return null;
    return 'https://image.tmdb.org/t/p/w500$posterPath';
  }

  /// Full backdrop URL
  String? get fullBackdropUrl {
    if (backdropPath == null) return null;
    return 'https://image.tmdb.org/t/p/w1280$backdropPath';
  }
}
