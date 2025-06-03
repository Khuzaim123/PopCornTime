import 'movie_model.dart';

class APIResponseModel {
  final int page;
  final List<MovieModel> results;
  final int totalPages;
  final int totalResults;

  const APIResponseModel({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  factory APIResponseModel.fromJson(Map<String, dynamic> json) {
    return APIResponseModel(
      page: json['page'] as int,
      results: List<MovieModel>.from(
        (json['results'] as List).map((x) => MovieModel.fromJson(x)),
      ),
      totalPages: json['total_pages'] as int,
      totalResults: json['total_results'] as int,
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
