
import 'package:movix/features/movie_details/models/movie_details_model.dart';

class TVSeriesDetailsModel {
  final bool adult;
  final String? backdropPath;
  final List<dynamic> createdBy;
  final List<int> episodeRunTime;
  final String? firstAirDate;
  final List<Genre> genres;
  final String? homepage;
  final int id;
  final bool inProduction;
  final List<String> languages;
  final String? lastAirDate;
  final Episode? lastEpisodeToAir;
  final String name;
  final dynamic nextEpisodeToAir;
  final List<Network> networks;
  final int numberOfEpisodes;
  final int numberOfSeasons;
  final List<String> originCountry;
  final String originalLanguage;
  final String originalName;
  final String overview;
  final double popularity;
  final String? posterPath;
  final List<ProductionCompany> productionCompanies;
  final List<ProductionCountry> productionCountries;
  final List<Season> seasons;
  final List<SpokenLanguage> spokenLanguages;
  final String status;
  final String? tagline;
  final String type;
  final double voteAverage;
  final int voteCount;

  const TVSeriesDetailsModel({
    required this.adult,
    this.backdropPath,
    required this.createdBy,
    required this.episodeRunTime,
    this.firstAirDate,
    required this.genres,
    this.homepage,
    required this.id,
    required this.inProduction,
    required this.languages,
    this.lastAirDate,
    this.lastEpisodeToAir,
    required this.name,
    this.nextEpisodeToAir,
    required this.networks,
    required this.numberOfEpisodes,
    required this.numberOfSeasons,
    required this.originCountry,
    required this.originalLanguage,
    required this.originalName,
    required this.overview,
    required this.popularity,
    this.posterPath,
    required this.productionCompanies,
    required this.productionCountries,
    required this.seasons,
    required this.spokenLanguages,
    required this.status,
    this.tagline,
    required this.type,
    required this.voteAverage,
    required this.voteCount,
  });

  factory TVSeriesDetailsModel.fromJson(Map<String, dynamic> json) {
    return TVSeriesDetailsModel(
      adult: json['adult'] as bool? ?? false,
      backdropPath: json['backdrop_path'] as String?,
      createdBy: json['created_by'] as List<dynamic>? ?? [],
      episodeRunTime: (json['episode_run_time'] as List<dynamic>?)?.map((e) => e as int).toList() ?? [],
      firstAirDate: json['first_air_date'] as String?,
      genres: (json['genres'] as List<dynamic>?)
              ?.map((genre) => Genre.fromJson(genre as Map<String, dynamic>))
              .toList() ?? [],
      homepage: json['homepage'] as String?,
      id: json['id'] as int? ?? 0,
      inProduction: json['in_production'] as bool? ?? false,
      languages: (json['languages'] as List<dynamic>?)?.map((e) => e as String).toList() ?? [],
      lastAirDate: json['last_air_date'] as String?,
      lastEpisodeToAir: json['last_episode_to_air'] != null 
          ? Episode.fromJson(json['last_episode_to_air'] as Map<String, dynamic>) 
          : null,
      name: json['name'] as String? ?? '',
      nextEpisodeToAir: json['next_episode_to_air'],
      networks: (json['networks'] as List<dynamic>?)
              ?.map((n) => Network.fromJson(n as Map<String, dynamic>))
              .toList() ?? [],
      numberOfEpisodes: json['number_of_episodes'] as int? ?? 0,
      numberOfSeasons: json['number_of_seasons'] as int? ?? 0,
      originCountry: (json['origin_country'] as List<dynamic>?)?.map((e) => e as String).toList() ?? [],
      originalLanguage: json['original_language'] as String? ?? '',
      originalName: json['original_name'] as String? ?? '',
      overview: json['overview'] as String? ?? '',
      popularity: (json['popularity'] as num?)?.toDouble() ?? 0.0,
      posterPath: json['poster_path'] as String?,
      productionCompanies: (json['production_companies'] as List<dynamic>?)
              ?.map((c) => ProductionCompany.fromJson(c as Map<String, dynamic>))
              .toList() ?? [],
      productionCountries: (json['production_countries'] as List<dynamic>?)
              ?.map((c) => ProductionCountry.fromJson(c as Map<String, dynamic>))
              .toList() ?? [],
      seasons: (json['seasons'] as List<dynamic>?)
              ?.map((s) => Season.fromJson(s as Map<String, dynamic>))
              .toList() ?? [],
      spokenLanguages: (json['spoken_languages'] as List<dynamic>?)
              ?.map((l) => SpokenLanguage.fromJson(l as Map<String, dynamic>))
              .toList() ?? [],
      status: json['status'] as String? ?? '',
      tagline: json['tagline'] as String?,
      type: json['type'] as String? ?? '',
      voteAverage: (json['vote_average'] as num?)?.toDouble() ?? 0.0,
      voteCount: json['vote_count'] as int? ?? 0,
    );
  }

  String? get airYear => (firstAirDate != null && firstAirDate!.length >= 4) ? firstAirDate!.substring(0, 4) : null;
  String? get fullPosterUrl => posterPath != null ? 'https://image.tmdb.org/t/p/w500$posterPath' : null;
  String? get fullBackdropUrl => backdropPath != null ? 'https://image.tmdb.org/t/p/w1280$backdropPath' : null;
}

class Episode {
  final int id;
  final String name;
  final String overview;
  final double voteAverage;
  final int voteCount;
  final String? airDate;
  final int episodeNumber;
  final String episodeType;
  final int runtime;
  final int seasonNumber;
  final String? stillPath;

  const Episode({
    required this.id,
    required this.name,
    required this.overview,
    required this.voteAverage,
    required this.voteCount,
    this.airDate,
    required this.episodeNumber,
    required this.episodeType,
    required this.runtime,
    required this.seasonNumber,
    this.stillPath,
  });

  factory Episode.fromJson(Map<String, dynamic> json) {
    return Episode(
      id: json['id'] as int? ?? 0,
      name: json['name'] as String? ?? '',
      overview: json['overview'] as String? ?? '',
      voteAverage: (json['vote_average'] as num?)?.toDouble() ?? 0.0,
      voteCount: json['vote_count'] as int? ?? 0,
      airDate: json['air_date'] as String?,
      episodeNumber: json['episode_number'] as int? ?? 0,
      episodeType: json['episode_type'] as String? ?? '',
      runtime: json['runtime'] as int? ?? 0,
      seasonNumber: json['season_number'] as int? ?? 0,
      stillPath: json['still_path'] as String?,
    );
  }
}

class Network {
  final int id;
  final String? logoPath;
  final String name;
  final String originCountry;

  const Network({required this.id, this.logoPath, required this.name, required this.originCountry});

  factory Network.fromJson(Map<String, dynamic> json) {
    return Network(
      id: json['id'] as int? ?? 0,
      logoPath: json['logo_path'] as String?,
      name: json['name'] as String? ?? '',
      originCountry: json['origin_country'] as String? ?? '',
    );
  }
}

class Season {
  final String? airDate;
  final int episodeCount;
  final int id;
  final String name;
  final String overview;
  final String? posterPath;
  final int seasonNumber;
  final double voteAverage;

  const Season({
    this.airDate,
    required this.episodeCount,
    required this.id,
    required this.name,
    required this.overview,
    this.posterPath,
    required this.seasonNumber,
    required this.voteAverage,
  });

  factory Season.fromJson(Map<String, dynamic> json) {
    return Season(
      airDate: json['air_date'] as String?,
      episodeCount: json['episode_count'] as int? ?? 0,
      id: json['id'] as int? ?? 0,
      name: json['name'] as String? ?? '',
      overview: json['overview'] as String? ?? '',
      posterPath: json['poster_path'] as String?,
      seasonNumber: json['season_number'] as int? ?? 0,
      voteAverage: (json['vote_average'] as num?)?.toDouble() ?? 0.0,
    );
  }
}