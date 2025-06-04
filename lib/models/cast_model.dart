class CastModel {
  final int id;
  final String name;
  final String character;
  final String profilePath;

  CastModel({
    required this.id,
    required this.name,
    required this.character,
    required this.profilePath,
  });

  factory CastModel.fromJson(Map<String, dynamic> json) {
    return CastModel(
      id: json['id'] as int,
      name: json['name'] as String,
      character: json['character'] as String,
      profilePath: json['profile_path'] as String? ?? '',
    );
  }

  String get profileUrl => 'https://image.tmdb.org/t/p/w200$profilePath';

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'character': character,
      'profile_path': profilePath,
    };
  }
}

class PersonModel {
  final int id;
  final String name;
  final String profilePath;
  final String biography;
  final String birthday;
  final String placeOfBirth;
  final double popularity;
  final String knownForDepartment;

  PersonModel({
    required this.id,
    required this.name,
    required this.profilePath,
    required this.biography,
    required this.birthday,
    required this.placeOfBirth,
    required this.popularity,
    required this.knownForDepartment,
  });

  factory PersonModel.fromJson(Map<String, dynamic> json) {
    return PersonModel(
      id: json['id'] as int,
      name: json['name'] as String? ?? '',
      profilePath: json['profile_path'] as String? ?? '',
      biography: json['biography'] as String? ?? '',
      birthday: json['birthday'] as String? ?? '',
      placeOfBirth: json['place_of_birth'] as String? ?? '',
      popularity: (json['popularity'] as num?)?.toDouble() ?? 0.0,
      knownForDepartment: json['known_for_department'] as String? ?? '',
    );
  }

  String get profileUrl => 'https://image.tmdb.org/t/p/w300$profilePath';
}
