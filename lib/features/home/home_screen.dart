import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../models/movie_model.dart';
import '../../core/widgets/movie_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<MovieModel> trendingMovies = [];
  List<MovieModel> topRatedMovies = [];
  List<MovieModel> upcomingMovies = [];
  List<MovieModel> nowPlayingMovies = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchMovies();
  }

  Future<void> fetchMovies() async {
    final apiKey = 'fb7bb23f03b6994dafc674c074d01761'; // Replace with your TMDB API key
    final baseUrl = 'https://api.themoviedb.org/3';

    try {
      final trendingResponse = await http.get(
        Uri.parse('$baseUrl/trending/movie/week?api_key=$apiKey'),
      );
      final topRatedResponse = await http.get(
        Uri.parse('$baseUrl/movie/top_rated?api_key=$apiKey'),
      );
      final upcomingResponse = await http.get(
        Uri.parse('$baseUrl/movie/upcoming?api_key=$apiKey'),
      );
      final nowPlayingResponse = await http.get(
        Uri.parse('$baseUrl/movie/now_playing?api_key=$apiKey'),
      );

      if (trendingResponse.statusCode == 200) {
        final data = json.decode(trendingResponse.body);
        setState(() {
          trendingMovies =
              (data['results'] as List)
                  .map((movie) => MovieModel.fromJson(movie))
                  .toList();
        });
      }

      if (topRatedResponse.statusCode == 200) {
        final data = json.decode(topRatedResponse.body);
        setState(() {
          topRatedMovies =
              (data['results'] as List)
                  .map((movie) => MovieModel.fromJson(movie))
                  .toList();
        });
      }

      if (upcomingResponse.statusCode == 200) {
        final data = json.decode(upcomingResponse.body);
        setState(() {
          upcomingMovies =
              (data['results'] as List)
                  .map((movie) => MovieModel.fromJson(movie))
                  .toList();
        });
      }

      if (nowPlayingResponse.statusCode == 200) {
        final data = json.decode(nowPlayingResponse.body);
        setState(() {
          nowPlayingMovies =
              (data['results'] as List)
                  .map((movie) => MovieModel.fromJson(movie))
                  .toList();
        });
      }
    } catch (e) {
      print('Error fetching movies: $e');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Movie Browser')),
      body:
          isLoading
              ? const Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildMovieSection('Trending Movies', trendingMovies),
                    _buildMovieSection('Top Rated Movies', topRatedMovies),
                    _buildMovieSection('Upcoming Movies', upcomingMovies),
                    _buildMovieSection('Now Playing Movies', nowPlayingMovies),
                  ],
                ),
              ),
    );
  }

  Widget _buildMovieSection(String title, List<MovieModel> movies) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            title,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(
          height: 240,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: movies.length,
            itemBuilder: (context, index) {
              return MovieCard(movie: movies[index]);
            },
          ),
        ),
      ],
    );
  }
}
