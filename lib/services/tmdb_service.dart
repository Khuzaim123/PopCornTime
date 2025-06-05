import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/api_response_model.dart';
import '../models/movie_model.dart';
import '../models/cast_model.dart';
import '../models/video_model.dart';
import '../models/genre_model.dart';
import '../models/person_model.dart' as person;

class TMDBService {
  static const String _baseUrl = 'https://api.themoviedb.org/3';
  static const String _apiKey =
      'fb7bb23f03b6994dafc674c074d01761'; // User's TMDB API key

  // Get trending movies
  Future<APIResponseModel> getTrendingMovies({int page = 1}) async {
    final response = await http.get(
      Uri.parse('$_baseUrl/trending/movie/week?api_key=$_apiKey&page=$page'),
    );
    return APIResponseModel.fromJson(json.decode(response.body));
  }

  // Get top rated movies
  Future<APIResponseModel> getTopRatedMovies({int page = 1}) async {
    final response = await http.get(
      Uri.parse('$_baseUrl/movie/top_rated?api_key=$_apiKey&page=$page'),
    );
    return APIResponseModel.fromJson(json.decode(response.body));
  }

  // Get upcoming movies
  Future<APIResponseModel> getUpcomingMovies({int page = 1}) async {
    final response = await http.get(
      Uri.parse('$_baseUrl/movie/upcoming?api_key=$_apiKey&page=$page'),
    );
    return APIResponseModel.fromJson(json.decode(response.body));
  }

  // Get now playing movies
  Future<APIResponseModel> getNowPlayingMovies({int page = 1}) async {
    final response = await http.get(
      Uri.parse('$_baseUrl/movie/now_playing?api_key=$_apiKey&page=$page'),
    );
    return APIResponseModel.fromJson(json.decode(response.body));
  }

  // Search movies
  Future<APIResponseModel> searchMovies(String query, {int page = 1}) async {
    final response = await http.get(
      Uri.parse(
        '$_baseUrl/search/movie?api_key=$_apiKey&query=$query&page=$page',
      ),
    );
    return APIResponseModel.fromJson(json.decode(response.body));
  }

  // Search actors
  Future<List<person.PersonModel>> searchActors(
    String query, {
    int page = 1,
  }) async {
    final response = await http.get(
      Uri.parse(
        '$_baseUrl/search/person?api_key=$_apiKey&query=$query&page=$page',
      ),
    );
    final data = json.decode(response.body);
    final results = data['results'] as List;
    return results.map((json) => person.PersonModel.fromJson(json)).toList();
  }

  // Get movie details
  Future<MovieModel> getMovieDetails(int movieId) async {
    final response = await http.get(
      Uri.parse('$_baseUrl/movie/$movieId?api_key=$_apiKey'),
    );
    return MovieModel.fromJson(json.decode(response.body));
  }

  // Get movie credits (cast)
  Future<List<CastModel>> getMovieCredits(int movieId) async {
    final response = await http.get(
      Uri.parse('$_baseUrl/movie/$movieId/credits?api_key=$_apiKey'),
    );
    final data = json.decode(response.body);
    return (data['cast'] as List)
        .map((cast) => CastModel.fromJson(cast))
        .toList();
  }

  // Get movie videos (trailers)
  Future<List<VideoModel>> getMovieVideos(int movieId) async {
    final response = await http.get(
      Uri.parse('$_baseUrl/movie/$movieId/videos?api_key=$_apiKey'),
    );
    final data = json.decode(response.body);
    return (data['results'] as List)
        .map((video) => VideoModel.fromJson(video))
        .toList();
  }

  // Get movie genres
  Future<List<GenreModel>> getMovieGenres() async {
    final response = await http.get(
      Uri.parse('$_baseUrl/genre/movie/list?api_key=$_apiKey'),
    );
    final data = json.decode(response.body);
    return (data['genres'] as List)
        .map((genre) => GenreModel.fromJson(genre))
        .toList();
  }

  // Get actor (person) details
  Future<Map<String, dynamic>> getPersonDetails(int personId) async {
    final response = await http.get(
      Uri.parse('$_baseUrl/person/$personId?api_key=$_apiKey'),
    );
    return json.decode(response.body) as Map<String, dynamic>;
  }

  // Get actor's movie credits
  Future<List<MovieModel>> getPersonMovieCredits(int personId) async {
    final response = await http.get(
      Uri.parse('$_baseUrl/person/$personId/movie_credits?api_key=$_apiKey'),
    );
    final data = json.decode(response.body);
    return (data['cast'] as List)
        .map((movie) => MovieModel.fromJson(movie))
        .toList();
  }
}
