
import 'package:movix/core/models/movie_model.dart';
import 'package:movix/core/models/show_model.dart';
import 'package:movix/core/models/tv_series_model.dart';

class ShowResponse {
  final List<ShowModel> results;
  final int page;
  final int totalPages;
  final int totalResults;

  const ShowResponse({
    required this.results,
    required this.page,
    required this.totalPages,
    required this.totalResults,
  });

  // ─── Movies only ─────────────────────────────────

  factory ShowResponse.moviesFromJson(Map<String, dynamic> json) {
    final results = (json['results'] as List<dynamic>?)
        ?.map((e) => MovieModel.fromJson(e as Map<String, dynamic>))
        .toList() ?? [];

    return ShowResponse(
      results: results,
      page: json['page'] as int? ?? 1,
      totalPages: json['total_pages'] as int? ?? 1,
      totalResults: json['total_results'] as int? ?? 0,
    );
  }

  // ─── TV only ─────────────────────────────────────
 
  factory ShowResponse.tvFromJson(Map<String, dynamic> json) {
    final results = (json['results'] as List<dynamic>?)
        ?.map((e) => TVSeriesModel.fromJson(e as Map<String, dynamic>))
        .toList() ?? [];

    return ShowResponse(
      results: results,
      page: json['page'] as int? ?? 1,
      totalPages: json['total_pages'] as int? ?? 1,
      totalResults: json['total_results'] as int? ?? 0,
    );
  }

  // ─── Mixed (has media_type field) ────────────────

  factory ShowResponse.mixedFromJson(Map<String, dynamic> json) {
    final results = (json['results'] as List<dynamic>?)
        ?.map((showJson) {
          final item = showJson as Map<String, dynamic>;
          final mediaType = item['media_type'] as String?;

          return switch (mediaType) {
            'tv'    => TVSeriesModel.fromJson(item),
            'movie' => MovieModel.fromJson(item),
            _       => null, // ignore person or unknown
          };
        })
        .whereType<ShowModel>()
        .toList() ?? [];

    return ShowResponse(
      results: results,
      page: json['page'] as int? ?? 1,
      totalPages: json['total_pages'] as int? ?? 1,
      totalResults: json['total_results'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'results': results.map((show) => show.toJson()).toList(),
      'page': page,
      'total_pages': totalPages,
      'total_results': totalResults,
    };
  }

  List<MovieModel> get movies =>
      results.whereType<MovieModel>().toList();

  List<TVSeriesModel> get tvSeries =>
      results.whereType<TVSeriesModel>().toList();

  bool get isEmpty => results.isEmpty;
  bool get isNotEmpty => results.isNotEmpty;
}