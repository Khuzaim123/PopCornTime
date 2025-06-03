class CastModel {
  final int id;
  final String name;
  final String character;
  final String? profilePath;
  final int? order;

  const CastModel({
    required this.id,
    required this.name,
    required this.character,
    this.profilePath,
    this.order,
  });

  factory CastModel.fromJson(Map<String, dynamic> json) {
    return CastModel(
      id: json['id'] as int,
      name: json['name'] as String,
      character: json['character'] as String,
      profilePath: json['profile_path'] as String?,
      order: json['order'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'character': character,
      'profile_path': profilePath,
      'order': order,
    };
  }

  String get profileUrl =>
      profilePath != null
          ? 'https://image.tmdb.org/t/p/w185$profilePath'
          : 'https://via.placeholder.com/185x278?text=No+Image';
}
