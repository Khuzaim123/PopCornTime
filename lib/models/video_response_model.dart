import 'video_model.dart';

class VideoResponseModel {
  final List<VideoModel> results;

  const VideoResponseModel({required this.results});

  factory VideoResponseModel.fromJson(Map<String, dynamic> json) {
    return VideoResponseModel(
      results: List<VideoModel>.from(
        (json['results'] as List).map((x) => VideoModel.fromJson(x)),
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {'results': results.map((x) => x.toJson()).toList()};
  }

  List<VideoModel> get trailers =>
      results
          .where((video) => video.type == 'Trailer' && video.site == 'YouTube')
          .toList();

  List<VideoModel> get teasers =>
      results
          .where((video) => video.type == 'Teaser' && video.site == 'YouTube')
          .toList();
}
