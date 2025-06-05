class PersonModel {
  final int id;
  final String name;
  final String? profilePath;
  final String? knownForDepartment;
  final List<dynamic>? knownFor;

  PersonModel({
    required this.id,
    required this.name,
    this.profilePath,
    this.knownForDepartment,
    this.knownFor,
  });

  factory PersonModel.fromJson(Map<String, dynamic> json) {
    return PersonModel(
      id: json['id'],
      name: json['name'],
      profilePath: json['profile_path'],
      knownForDepartment: json['known_for_department'],
      knownFor: json['known_for'],
    );
  }
}
