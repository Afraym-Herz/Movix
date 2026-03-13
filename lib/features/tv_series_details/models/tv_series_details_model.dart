class Genre {
  final int id;
  final String name;

  const Genre({required this.id, required this.name});

  factory Genre.fromJson(Map<String, dynamic> json) {
    return Genre(
      id: json['id'] as int? ?? 0,
      name: json['name'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() => {'id': id, 'name': name};
}

class TVSeriesDetailsModel {
  final int id;
  final String name;
  final String originalName;
  final String? firstAirDate;
  final String? lastAirDate;
  final String overview;
  final String? posterPath;
  final String? backdropPath;
  final double voteAverage;
  final int voteCount;
  final double popularity;
  final List<Genre> genres;
  final String? tagline;
  final String status;
  final String originalLanguage;
  final int numberOfSeasons;
  final int numberOfEpisodes;
  final List<int>? episodeRunTime;

  const TVSeriesDetailsModel({
    required this.id,
    required this.name,
    required this.originalName,
    this.firstAirDate,
    this.lastAirDate,
    required this.overview,
    this.posterPath,
    this.backdropPath,
    required this.voteAverage,
    required this.voteCount,
    required this.popularity,
    required this.genres,
    this.tagline,
    required this.status,
    required this.originalLanguage,
    required this.numberOfSeasons,
    required this.numberOfEpisodes,
    this.episodeRunTime,
  });

  String? get fullPosterUrl =>
      posterPath != null ? 'https://image.tmdb.org/t/p/w500$posterPath' : null;

  String? get fullBackdropUrl => backdropPath != null
      ? 'https://image.tmdb.org/t/p/w1280$backdropPath'
      : null;

  String? get releaseYear => firstAirDate != null && firstAirDate!.length >= 4
      ? firstAirDate!.substring(0, 4)
      : null;

  factory TVSeriesDetailsModel.fromJson(Map<String, dynamic> json) {
    return TVSeriesDetailsModel(
      id: json['id'] as int? ?? 0,
      name: json['name'] as String? ?? '',
      originalName: json['original_name'] as String? ?? '',
      firstAirDate: json['first_air_date'] as String?,
      lastAirDate: json['last_air_date'] as String?,
      overview: json['overview'] as String? ?? '',
      posterPath: json['poster_path'] as String?,
      backdropPath: json['backdrop_path'] as String?,
      voteAverage: (json['vote_average'] as num?)?.toDouble() ?? 0,
      voteCount: json['vote_count'] as int? ?? 0,
      popularity: (json['popularity'] as num?)?.toDouble() ?? 0,
      genres: (json['genres'] as List<dynamic>?)
              ?.map((g) => Genre.fromJson(g as Map<String, dynamic>))
              .toList() ??
          [],
      tagline: json['tagline'] as String?,
      status: json['status'] as String? ?? '',
      originalLanguage: json['original_language'] as String? ?? '',
      numberOfSeasons: json['number_of_seasons'] as int? ?? 0,
      numberOfEpisodes: json['number_of_episodes'] as int? ?? 0,
      episodeRunTime: (json['episode_run_time'] as List<dynamic>?)
          ?.map((e) => e as int)
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'original_name': originalName,
      'first_air_date': firstAirDate,
      'last_air_date': lastAirDate,
      'overview': overview,
      'poster_path': posterPath,
      'backdrop_path': backdropPath,
      'vote_average': voteAverage,
      'vote_count': voteCount,
      'popularity': popularity,
      'genres': genres.map((g) => g.toJson()).toList(),
      'tagline': tagline,
      'status': status,
      'original_language': originalLanguage,
      'number_of_seasons': numberOfSeasons,
      'number_of_episodes': numberOfEpisodes,
      'episode_run_time': episodeRunTime,
    };
  }
}
