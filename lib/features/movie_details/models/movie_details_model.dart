class MovieDetailsModel {
  final bool adult;
  final String? backdropPath;
  final dynamic belongsToCollection;
  final int budget;
  final List<Genre> genres;
  final String? homepage;
  final int id;
  final String? imdbId;
  final String originalLanguage;
  final String originalTitle;
  final String overview;
  final double popularity;
  final String? posterPath;
  final List<ProductionCompany> productionCompanies;
  final List<ProductionCountry> productionCountries;
  final String? releaseDate;
  final int revenue;
  final int? runtime;
  final List<SpokenLanguage> spokenLanguages;
  final String status;
  final String? tagline;
  final String title;
  final bool video;
  final double voteAverage;
  final int voteCount;

  const MovieDetailsModel({
    required this.adult,
    this.backdropPath,
    this.belongsToCollection,
    required this.budget,
    required this.genres,
    this.homepage,
    required this.id,
    this.imdbId,
    required this.originalLanguage,
    required this.originalTitle,
    required this.overview,
    required this.popularity,
    this.posterPath,
    required this.productionCompanies,
    required this.productionCountries,
    this.releaseDate,
    required this.revenue,
    this.runtime,
    required this.spokenLanguages,
    required this.status,
    this.tagline,
    required this.title,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
  });

  factory MovieDetailsModel.fromJson(Map<String, dynamic> json) {
    return MovieDetailsModel(
      adult: json['adult'] as bool? ?? false,
      backdropPath: json['backdrop_path'] as String?,
      belongsToCollection: json['belongs_to_collection'],
      budget: json['budget'] as int? ?? 0,
      genres: (json['genres'] as List<dynamic>?)
              ?.map((genre) => Genre.fromJson(genre as Map<String, dynamic>))
              .toList() ??
          [],
      homepage: json['homepage'] as String?,
      id: json['id'] as int? ?? 0,
      imdbId: json['imdb_id'] as String?,
      originalLanguage: json['original_language'] as String? ?? '',
      originalTitle: json['original_title'] as String? ?? '',
      overview: json['overview'] as String? ?? '',
      popularity: (json['popularity'] as num?)?.toDouble() ?? 0,
      posterPath: json['poster_path'] as String?,
      productionCompanies: (json['production_companies'] as List<dynamic>?)
              ?.map((company) => ProductionCompany.fromJson(company as Map<String, dynamic>))
              .toList() ??
          [],
      productionCountries: (json['production_countries'] as List<dynamic>?)
              ?.map((country) => ProductionCountry.fromJson(country as Map<String, dynamic>))
              .toList() ??
          [],
      releaseDate: json['release_date'] as String?,
      revenue: json['revenue'] as int? ?? 0,
      runtime: json['runtime'] as int?,
      spokenLanguages: (json['spoken_languages'] as List<dynamic>?)
              ?.map((language) => SpokenLanguage.fromJson(language as Map<String, dynamic>))
              .toList() ??
          [],
      status: json['status'] as String? ?? '',
      tagline: json['tagline'] as String?,
      title: json['title'] as String? ?? '',
      video: json['video'] as bool? ?? false,
      voteAverage: (json['vote_average'] as num?)?.toDouble() ?? 0,
      voteCount: json['vote_count'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'adult': adult,
      'backdrop_path': backdropPath,
      'belongs_to_collection': belongsToCollection,
      'budget': budget,
      'genres': genres.map((genre) => genre.toJson()).toList(),
      'homepage': homepage,
      'id': id,
      'imdb_id': imdbId,
      'original_language': originalLanguage,
      'original_title': originalTitle,
      'overview': overview,
      'popularity': popularity,
      'poster_path': posterPath,
      'production_companies': productionCompanies.map((company) => company.toJson()).toList(),
      'production_countries': productionCountries.map((country) => country.toJson()).toList(),
      'release_date': releaseDate,
      'revenue': revenue,
      'runtime': runtime,
      'spoken_languages': spokenLanguages.map((language) => language.toJson()).toList(),
      'status': status,
      'tagline': tagline,
      'title': title,
      'video': video,
      'vote_average': voteAverage,
      'vote_count': voteCount,
    };
  }

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

  /// Release year from releaseDate (e.g. "2024-01-15" -> "2024").
  String? get releaseYear =>
      releaseDate != null && releaseDate!.length >= 4
          ? releaseDate!.substring(0, 4)
          : null;

  /// Formatted runtime (e.g. "2h 19m")
  String? get formattedRuntime {
    if (runtime == null) return null;
    final hours = runtime! ~/ 60;
    final minutes = runtime! % 60;
    if (hours > 0) {
      return '${hours}h ${minutes}m';
    }
    return '${minutes}m';
  }

  /// Formatted budget (e.g. "$63.0M")
  String get formattedBudget {
    if (budget == 0) return 'Unknown';
    if (budget >= 1000000000) {
      return '\$${(budget / 1000000000).toStringAsFixed(1)}B';
    } else if (budget >= 1000000) {
      return '\$${(budget / 1000000).toStringAsFixed(1)}M';
    } else if (budget >= 1000) {
      return '\$${(budget / 1000).toStringAsFixed(1)}K';
    }
    return '\$$budget';
  }

  /// Formatted revenue (e.g. "$100.9M")
  String get formattedRevenue {
    if (revenue == 0) return 'Unknown';
    if (revenue >= 1000000000) {
      return '\$${(revenue / 1000000000).toStringAsFixed(1)}B';
    } else if (revenue >= 1000000) {
      return '\$${(revenue / 1000000).toStringAsFixed(1)}M';
    } else if (revenue >= 1000) {
      return '\$${(revenue / 1000).toStringAsFixed(1)}K';
    }
    return '\$$revenue';
  }
}

class Genre {
  final int id;
  final String name;

  const Genre({
    required this.id,
    required this.name,
  });

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

  /// Full logo URL
  String? get fullLogoUrl {
    if (logoPath == null) return null;
    return 'https://image.tmdb.org/t/p/w92$logoPath';
  }
}

class ProductionCountry {
  final String iso31661;
  final String name;

  const ProductionCountry({
    required this.iso31661,
    required this.name,
  });

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

class SpokenLanguage {
  final String englishName;
  final String iso6391;
  final String name;

  const SpokenLanguage({
    required this.englishName,
    required this.iso6391,
    required this.name,
  });

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
