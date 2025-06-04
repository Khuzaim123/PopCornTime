import 'movie_model.dart';

class APIResponseModel {
  final int page;
  final List<MovieModel> results;
  final int totalPages;
  final int totalResults;

  APIResponseModel({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  factory APIResponseModel.fromJson(Map<String, dynamic> json) {
    return APIResponseModel(
      page:
          json['page'] is int
              ? json['page']
              : int.tryParse(json['page']?.toString() ?? '1') ?? 1,
      results:
          (json['results'] as List?)
              ?.map(
                (movie) => MovieModel.fromJson(movie as Map<String, dynamic>),
              )
              .toList() ??
          [],
      totalPages:
          json['total_pages'] is int
              ? json['total_pages']
              : int.tryParse(json['total_pages']?.toString() ?? '1') ?? 1,
      totalResults:
          json['total_results'] is int
              ? json['total_results']
              : int.tryParse(json['total_results']?.toString() ?? '0') ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'page': page,
      'results': results.map((x) => x.toJson()).toList(),
      'total_pages': totalPages,
      'total_results': totalResults,
    };
  }

  bool get hasNextPage => page < totalPages;
  bool get hasPreviousPage => page > 1;
}
