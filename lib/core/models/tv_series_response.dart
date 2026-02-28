import 'package:movix/core/models/tv_series_model.dart';

class TvSeriesResponse {
  final List<TVSeriesModel> results;
  final int page;
  final int totalPages;
  final int totalResults;

  const TvSeriesResponse({
    required this.results,
    required this.page,
    required this.totalPages,
    required this.totalResults,
  });
  
  factory TvSeriesResponse.fromJson(Map<String, dynamic> json) {
    final results = (json['results'] as List<dynamic>?)
            ?.map((showJson) => TVSeriesModel.fromJson(showJson as Map<String, dynamic>))
            .toList() ??
        [];

    return TvSeriesResponse(
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
}

