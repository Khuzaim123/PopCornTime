import 'genre_model.dart';
import 'credits_model.dart';
import 'video_response_model.dart';

class MovieModel {
  final int id;
  final String title;
  final String overview;
  final String? posterPath;
  final String? backdropPath;
  final String? releaseDate;
  final double voteAverage;
  final int voteCount;
  final List<int> genreIds;
  final int? runtime;
  final List<GenreModel>? genres;
  final CreditsModel? credits;
  final VideoResponseModel? videos;

  const MovieModel({
    required this.id,
    required this.title,
    required this.overview,
    this.posterPath,
    this.backdropPath,
    this.releaseDate,
    required this.voteAverage,
    required this.voteCount,
    required this.genreIds,
    this.runtime,
    this.genres,
    this.credits,
    this.videos,
  });

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
      id: json['id'] as int,
      title: json['title'] as String,
      overview: json['overview'] as String,
      posterPath: json['poster_path'] as String?,
      backdropPath: json['backdrop_path'] as String?,
      releaseDate: json['release_date'] as String?,
      voteAverage: (json['vote_average'] as num).toDouble(),
      voteCount: json['vote_count'] as int,
      genreIds: List<int>.from(json['genre_ids'] as List),
      runtime: json['runtime'] as int?,
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
    };
  }

  String get posterUrl =>
      posterPath != null
          ? 'https://image.tmdb.org/t/p/w500$posterPath'
          : 'https://via.placeholder.com/500x750?text=No+Poster';

  String get backdropUrl =>
      backdropPath != null
          ? 'https://image.tmdb.org/t/p/original$backdropPath'
          : 'https://via.placeholder.com/1920x1080?text=No+Backdrop';
}
