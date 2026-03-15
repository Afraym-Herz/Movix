import 'package:movix/core/models/show_model.dart';

class MovieDetailsModel extends ShowModel {
  final String title;
  final String originalTitle;
  final String? releaseDate;
  final bool video;
  final List<ProductionCompany> productionCompanies;
  final List<Genre> genres;
  final int runtime;
  final String status;
  final int budget;
  final int revenue;

  const MovieDetailsModel({
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
    // movie specific
    required this.title,
    required this.originalTitle,
    this.releaseDate,
    required this.video,
    required this.productionCompanies,
    required this.genres,
    required this.runtime,
    required this.status,
    required this.budget,
    required this.revenue,
  });

  @override
  String get disPlayTitle => title;

  @override
  String? get displayDate => releaseDate;

  String get formattedRuntime {
    final hours = runtime ~/ 60;
    final minutes = runtime % 60;
    if (hours > 0) {
      return '${hours}h ${minutes}m';
    } else {
      return '${minutes}m';
    }
  }

  String get formattedBudget => _formatCurrency(budget);
  String get formattedRevenue => _formatCurrency(revenue);

  String _formatCurrency(int amount) {
    if (amount <= 0) return 'N/A';
    if (amount >= 1000000000) {
      return '\$${(amount / 1000000000).toStringAsFixed(1)}B';
    } else if (amount >= 1000000) {
      return '\$${(amount / 1000000).toStringAsFixed(1)}M';
    } else if (amount >= 1000) {
      return '\$${(amount / 1000).toStringAsFixed(1)}K';
    } else {
      return '\$$amount';
    }
  }

  factory MovieDetailsModel.fromJson(Map<String, dynamic> json) {
    return MovieDetailsModel(
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
      productionCompanies: (json['production_companies'] as List<dynamic>?)
              ?.map((c) => ProductionCompany.fromJson(c as Map<String, dynamic>))
              .toList() ?? [],
      genres: (json['genres'] as List<dynamic>?)
              ?.map((g) => Genre.fromJson(g as Map<String, dynamic>))
              .toList() ?? [],
      runtime: json['runtime'] as int? ?? 0,
      status: json['status'] as String? ?? '',
      budget: json['budget'] as int? ?? 0,
      revenue: json['revenue'] as int? ?? 0,
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
      'production_companies': productionCompanies.map((c) => c.toJson()).toList(),
      'genres': genres.map((g) => g.toJson()).toList(),
      'runtime': runtime,
      'status': status,
      'budget': budget,
      'revenue': revenue,
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
