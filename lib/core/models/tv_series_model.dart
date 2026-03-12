import 'package:movix/core/models/show_model.dart';

class TVSeriesModel extends ShowModel {
  final String name;
  final String originalName;
  final String? firstAirDate;
  final String? mediaType;
  final List<String> originCountry;

  const TVSeriesModel({
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
    required this.name,
    required this.originalName,
    this.firstAirDate,
    this.mediaType,
    required this.originCountry,
  });

  // ✅ Implement abstract getters
  @override
  String get displayTitle => name;

  @override
  String? get displayDate => firstAirDate;

  factory TVSeriesModel.fromJson(Map<String, dynamic> json) {
    return TVSeriesModel(
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
      name: json['name'] as String? ?? '',
      originalName: json['original_name'] as String? ?? '',
      firstAirDate: json['first_air_date'] as String?,
      mediaType: json['media_type'] as String?,
      originCountry: (json['origin_country'] as List<dynamic>?)
              ?.map((c) => c as String).toList() ?? [],
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
      'name': name,
      'original_name': originalName,
      'first_air_date': firstAirDate,
      'media_type': mediaType,
      'origin_country': originCountry,
    };
  }
}