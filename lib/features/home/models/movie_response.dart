import 'package:movix/features/home/models/movie.dart';

class MovieResponse {
  final List<Movie> results;
  final int page;
  final int totalPages;
  final int totalResults;

  const MovieResponse({
    required this.results,
    required this.page,
    required this.totalPages,
    required this.totalResults,
  });

  factory MovieResponse.fromJson(Map<String, dynamic> json) {
    final results = (json['results'] as List<dynamic>?)
            ?.map((movieJson) => Movie.fromJson(movieJson as Map<String, dynamic>))
            .toList() ??
        [];

    return MovieResponse(
      results: results,
      page: json['page'] as int? ?? 1,
      totalPages: json['total_pages'] as int? ?? 1,
      totalResults: json['total_results'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'results': results.map((movie) => movie.toJson()).toList(),
      'page': page,
      'total_pages': totalPages,
      'total_results': totalResults,
    };
  }
}

