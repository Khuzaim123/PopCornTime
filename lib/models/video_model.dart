class VideoModel {
  final String key;
  final String site;
  final String type;
  final String name;

  VideoModel({
    required this.key,
    required this.site,
    required this.type,
    required this.name,
  });

  factory VideoModel.fromJson(Map<String, dynamic> json) {
    return VideoModel(
      key: json['key'] as String,
      site: json['site'] as String,
      type: json['type'] as String,
      name: json['name'] as String,
    );
  }

  String get youtubeUrl => 'https://www.youtube.com/watch?v=$key';
  String get youtubeThumbnailUrl =>
      'https://img.youtube.com/vi/$key/maxresdefault.jpg';

  Map<String, dynamic> toJson() {
    return {'key': key, 'site': site, 'type': type, 'name': name};
  }
}
