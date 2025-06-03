import 'cast_model.dart';

class CreditsModel {
  final List<CastModel> cast;
  final List<CastModel> crew;

  const CreditsModel({required this.cast, required this.crew});

  factory CreditsModel.fromJson(Map<String, dynamic> json) {
    return CreditsModel(
      cast: List<CastModel>.from(
        (json['cast'] as List).map((x) => CastModel.fromJson(x)),
      ),
      crew: List<CastModel>.from(
        (json['crew'] as List).map((x) => CastModel.fromJson(x)),
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'cast': cast.map((x) => x.toJson()).toList(),
      'crew': crew.map((x) => x.toJson()).toList(),
    };
  }

  List<CastModel> get topCast => cast.take(10).toList();

  List<CastModel> get directors =>
      crew
          .where(
            (person) => person.character.toLowerCase().contains('director'),
          )
          .toList();
}
