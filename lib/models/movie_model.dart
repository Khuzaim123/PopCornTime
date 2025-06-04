import 'genre_model.dart';
import 'credits_model.dart';
import 'video_response_model.dart';

class MovieModel {
  final int id;
  final String title;
  final String overview;
  final String posterPath;
  final String backdropPath;
  final String releaseDate;
  final double voteAverage;
  final int voteCount;
  final List<int> genreIds;
  final int? runtime;
  final List<GenreModel>? genres;
  final CreditsModel? credits;
  final VideoResponseModel? videos;
  final String? character;

  const MovieModel({
    required this.id,
    required this.title,
    required this.overview,
    required this.posterPath,
    required this.backdropPath,
    required this.releaseDate,
    required this.voteAverage,
    required this.voteCount,
    required this.genreIds,
    this.runtime,
    this.genres,
    this.credits,
    this.videos,
    this.character,
  });

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
      id:
          json['id'] is int
              ? json['id']
              : int.tryParse(json['id']?.toString() ?? '0') ?? 0,
      title: json['title'] as String? ?? '',
      overview: json['overview'] as String? ?? '',
      posterPath: json['poster_path'] as String? ?? '',
      backdropPath: json['backdrop_path'] as String? ?? '',
      releaseDate: json['release_date'] as String? ?? '',
      voteAverage: (json['vote_average'] as num?)?.toDouble() ?? 0.0,
      voteCount:
          json['vote_count'] is int
              ? json['vote_count']
              : int.tryParse(json['vote_count']?.toString() ?? '0') ?? 0,
      genreIds:
          (json['genre_ids'] as List?)
              ?.map(
                (e) => e is int ? e : int.tryParse(e?.toString() ?? '0') ?? 0,
              )
              .toList() ??
          [],
      runtime:
          json['runtime'] is int
              ? json['runtime']
              : int.tryParse(json['runtime']?.toString() ?? ''),
      genres:
          json['genres'] != null
              ? List<GenreModel>.from(
                (json['genres'] as List).map((x) => GenreModel.fromJson(x)),
              )
              : null,
      credits:
          json['credits'] != null
              ? CreditsModel.fromJson(json['credits'] as Map<String, dynamic>)
              : null,
      videos:
          json['videos'] != null
              ? VideoResponseModel.fromJson(
                json['videos'] as Map<String, dynamic>,
              )
              : null,
      character: json['character'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'overview': overview,
      'poster_path': posterPath,
      'backdrop_path': backdropPath,
      'release_date': releaseDate,
      'vote_average': voteAverage,
      'vote_count': voteCount,
      'genre_ids': genreIds,
      'runtime': runtime,
      'genres': genres?.map((x) => x.toJson()).toList(),
      'credits': credits?.toJson(),
      'videos': videos?.toJson(),
      'character': character,
    };
  }

  String get posterUrl => 'https://image.tmdb.org/t/p/w500$posterPath';
  String get backdropUrl => 'https://image.tmdb.org/t/p/original$backdropPath';
}
