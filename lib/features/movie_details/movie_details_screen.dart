import 'package:flutter/material.dart';
import 'package:popcorntime/services/tmdb_service.dart';
import 'package:popcorntime/models/movie_model.dart';
import 'package:popcorntime/models/credits_model.dart';
import 'package:popcorntime/core/widgets/movie_details.dart';

class MovieDetailsScreen extends StatefulWidget {
  final int movieId;
  const MovieDetailsScreen({super.key, required this.movieId});

  @override
  State<MovieDetailsScreen> createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen> {
  late Future<MovieModel> _movieFuture;
  late Future<CreditsModel?> _creditsFuture;
  final TMDBService _tmdbService = TMDBService();

  @override
  void initState() {
    super.initState();
    _movieFuture = _tmdbService.getMovieDetails(widget.movieId);
    _creditsFuture = _fetchCredits();
  }

  Future<CreditsModel?> _fetchCredits() async {
    try {
      final cast = await _tmdbService.getMovieCredits(widget.movieId);
      return CreditsModel(cast: cast, crew: []);
    } catch (_) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Movie Details')),
      body: FutureBuilder<MovieModel>(
        future: _movieFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: \\${snapshot.error}'));
          }
          final movie = snapshot.data!;
          return FutureBuilder<CreditsModel?>(
            future: _creditsFuture,
            builder: (context, creditsSnapshot) {
              final credits = creditsSnapshot.data;
              return MovieDetails(movie: movie, credits: credits);
            },
          );
        },
      ),
    );
  }
}
