import 'package:flutter/material.dart';
import 'package:popcorntime/services/tmdb_service.dart';
import 'package:popcorntime/models/movie_model.dart';
import 'package:popcorntime/models/credits_model.dart';
import 'package:popcorntime/core/widgets/movie_details.dart';
import 'package:popcorntime/services/watchlist_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:popcorntime/models/video_model.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class MovieDetailsScreen extends StatefulWidget {
  final int movieId;
  const MovieDetailsScreen({super.key, required this.movieId});

  @override
  State<MovieDetailsScreen> createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen> {
  late Future<MovieModel> _movieFuture;
  late Future<CreditsModel?> _creditsFuture;
  late Future<List<VideoModel>> _videosFuture;
  final TMDBService _tmdbService = TMDBService();
  final WatchlistService _watchlistService = WatchlistService();

  @override
  void initState() {
    super.initState();
    _movieFuture = _tmdbService.getMovieDetails(widget.movieId);
    _creditsFuture = _fetchCredits();
    _videosFuture = _tmdbService.getMovieVideos(widget.movieId);
  }

  Future<CreditsModel?> _fetchCredits() async {
    try {
      final cast = await _tmdbService.getMovieCredits(widget.movieId);
      return CreditsModel(cast: cast, crew: []);
    } catch (_) {
      return null;
    }
  }

  void _playTrailerAndAddToWatchlist(
    List<VideoModel> videos,
    MovieModel movie,
  ) async {
    VideoModel? trailer;
    try {
      trailer = videos.firstWhere(
        (v) => v.site == 'YouTube' && v.type == 'Trailer',
      );
    } catch (_) {
      try {
        trailer = videos.firstWhere((v) => v.site == 'YouTube');
      } catch (_) {
        trailer = null;
      }
    }
    if (trailer == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('No trailer available.')));
      return;
    }
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await _watchlistService.addToWatchlist(user.uid, movie.id);
    }
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          contentPadding: EdgeInsets.zero,
          content: AspectRatio(
            aspectRatio: 16 / 9,
            child: YoutubePlayer(
              controller: YoutubePlayerController(
                initialVideoId: trailer!.key,
                flags: const YoutubePlayerFlags(autoPlay: true, mute: false),
              ),
              showVideoProgressIndicator: true,
            ),
          ),
        );
      },
    );
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
              return FutureBuilder<List<VideoModel>>(
                future: _videosFuture,
                builder: (context, videoSnapshot) {
                  final videos = videoSnapshot.data ?? [];
                  final hasTrailer = videos.any(
                    (v) => v.site == 'YouTube' && v.type == 'Trailer',
                  );
                  return MovieDetails(
                    movie: movie,
                    credits: credits,
                    onPlayTrailer:
                        hasTrailer
                            ? () => _playTrailerAndAddToWatchlist(videos, movie)
                            : null,
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
