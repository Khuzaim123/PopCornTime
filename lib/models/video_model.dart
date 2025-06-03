class VideoModel {
  final String id;
  final String key;
  final String name;
  final String site;
  final String type;
  final int size;
  final bool official;

  const VideoModel({
    required this.id,
    required this.key,
    required this.name,
    required this.site,
    required this.type,
    required this.size,
    required this.official,
  });

  factory VideoModel.fromJson(Map<String, dynamic> json) {
    return VideoModel(
      id: json['id'] as String,
      key: json['key'] as String,
      name: json['name'] as String,
      site: json['site'] as String,
      type: json['type'] as String,
      size: json['size'] as int,
      official: json['official'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'key': key,
      'name': name,
      'site': site,
      'type': type,
      'size': size,
      'official': official,
    };
  }

  String get youtubeUrl =>
      site == 'YouTube' ? 'https://www.youtube.com/watch?v=$key' : '';
}
