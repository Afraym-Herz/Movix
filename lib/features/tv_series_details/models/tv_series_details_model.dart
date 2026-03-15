import 'package:movix/core/models/show_model.dart';

class TVSeriesDetailsModel extends ShowModel {
  final List<dynamic> createdBy;
  final List<int> episodeRunTime;
  final String? firstAirDate;
  final List<Genre> genres;
  final String? homepage;
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
  final String originalName;
  final List<ProductionCompany> productionCompanies;
  final List<ProductionCountry> productionCountries;
  final List<Season> seasons;
  final List<SpokenLanguage> spokenLanguages;
  final String status;
  final String? tagline;
  final String type;

  const TVSeriesDetailsModel({
    // base
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
    // tv specific
    required this.createdBy,
    required this.episodeRunTime,
    this.firstAirDate,
    required this.genres,
    this.homepage,
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
    required this.originalName,
    required this.productionCompanies,
    required this.productionCountries,
    required this.seasons,
    required this.spokenLanguages,
    required this.status,
    this.tagline,
    required this.type,
  });

  @override
  String get disPlayTitle => name;

  @override
  String? get displayDate => firstAirDate;

  String? get airYear => (firstAirDate != null && firstAirDate!.length >= 4) ? firstAirDate!.substring(0, 4) : null;

  String get formattedEpisodeRunTime {
    if (episodeRunTime.isEmpty) return 'N/A';
    final runtime = episodeRunTime.first;
    final hours = runtime ~/ 60;
    final minutes = runtime % 60;
    if (hours > 0) {
      return '${hours}h ${minutes}m';
    } else {
      return '${minutes}m';
    }
  }

  factory TVSeriesDetailsModel.fromJson(Map<String, dynamic> json) {
    return TVSeriesDetailsModel(
      adult: json['adult'] as bool? ?? false,
      backdropPath: json['backdrop_path'] as String?,
      id: json['id'] as int? ?? 0,
      overview: json['overview'] as String? ?? '',
      posterPath: json['poster_path'] as String?,
      originalLanguage: json['original_language'] as String? ?? '',
      genreIds: (json['genres'] as List<dynamic>?)
              ?.map((g) => g['id'] as int).toList() ?? [],
      popularity: (json['popularity'] as num?)?.toDouble() ?? 0.0,
      voteAverage: (json['vote_average'] as num?)?.toDouble() ?? 0.0,
      voteCount: json['vote_count'] as int? ?? 0,
      createdBy: json['created_by'] as List<dynamic>? ?? [],
      episodeRunTime: (json['episode_run_time'] as List<dynamic>?)?.map((e) => e as int).toList() ?? [],
      firstAirDate: json['first_air_date'] as String?,
      genres: (json['genres'] as List<dynamic>?)
              ?.map((genre) => Genre.fromJson(genre as Map<String, dynamic>))
              .toList() ?? [],
      homepage: json['homepage'] as String?,
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
      originalName: json['original_name'] as String? ?? '',
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
      'created_by': createdBy,
      'episode_run_time': episodeRunTime,
      'first_air_date': firstAirDate,
      'genres': genres.map((g) => g.toJson()).toList(),
      'homepage': homepage,
      'in_production': inProduction,
      'languages': languages,
      'last_air_date': lastAirDate,
      'last_episode_to_air': lastEpisodeToAir?.toJson(),
      'name': name,
      'next_episode_to_air': nextEpisodeToAir,
      'networks': networks.map((n) => n.toJson()).toList(),
      'number_of_episodes': numberOfEpisodes,
      'number_of_seasons': numberOfSeasons,
      'origin_country': originCountry,
      'original_name': originalName,
      'production_companies': productionCompanies.map((c) => c.toJson()).toList(),
      'production_countries': productionCountries.map((c) => c.toJson()).toList(),
      'seasons': seasons.map((s) => s.toJson()).toList(),
      'spoken_languages': spokenLanguages.map((l) => l.toJson()).toList(),
      'status': status,
      'tagline': tagline,
      'type': type,
    };
  }
}

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

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
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

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'overview': overview,
      'vote_average': voteAverage,
      'vote_count': voteCount,
      'air_date': airDate,
      'episode_number': episodeNumber,
      'episode_type': episodeType,
      'runtime': runtime,
      'season_number': seasonNumber,
      'still_path': stillPath,
    };
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

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'logo_path': logoPath,
      'name': name,
      'origin_country': originCountry,
    };
  }
}

class ProductionCompany {
  final int id;
  final String? logoPath;
  final String name;
  final String originCountry;

  const ProductionCompany({
    required this.id,
    this.logoPath,
    required this.name,
    required this.originCountry,
  });

  factory ProductionCompany.fromJson(Map<String, dynamic> json) {
    return ProductionCompany(
      id: json['id'] as int? ?? 0,
      logoPath: json['logo_path'] as String?,
      name: json['name'] as String? ?? '',
      originCountry: json['origin_country'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'logo_path': logoPath,
      'name': name,
      'origin_country': originCountry,
    };
  }

  String? get fullLogoPath => logoPath != null ? 'https://image.tmdb.org/t/p/w200$logoPath' : null;
}

class ProductionCountry {
  final String iso31661;
  final String name;

  const ProductionCountry({required this.iso31661, required this.name});

  factory ProductionCountry.fromJson(Map<String, dynamic> json) {
    return ProductionCountry(
      iso31661: json['iso_3166_1'] as String? ?? '',
      name: json['name'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'iso_3166_1': iso31661,
      'name': name,
    };
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

  Map<String, dynamic> toJson() {
    return {
      'air_date': airDate,
      'episode_count': episodeCount,
      'id': id,
      'name': name,
      'overview': overview,
      'poster_path': posterPath,
      'season_number': seasonNumber,
      'vote_average': voteAverage,
    };
  }
}

class SpokenLanguage {
  final String englishName;
  final String iso6391;
  final String name;

  const SpokenLanguage({required this.englishName, required this.iso6391, required this.name});

  factory SpokenLanguage.fromJson(Map<String, dynamic> json) {
    return SpokenLanguage(
      englishName: json['english_name'] as String? ?? '',
      iso6391: json['iso_639_1'] as String? ?? '',
      name: json['name'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'english_name': englishName,
      'iso_639_1': iso6391,
      'name': name,
    };
  }
}
