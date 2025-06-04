import 'package:flutter/material.dart';
import 'package:popcorntime/services/tmdb_service.dart';
import 'package:popcorntime/models/movie_model.dart';
import 'package:popcorntime/models/credits_model.dart';
import 'package:popcorntime/core/widgets/movie_details.dart';
import 'package:popcorntime/services/watchlist_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:popcorntime/models/video_model.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:popcorntime/models/cast_model.dart';

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
                    onActorTap: (actor) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (context) => ActorDetailScreen(actorId: actor.id),
                        ),
                      );
                    },
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

class ExpandableText extends StatefulWidget {
  final String text;
  final int maxLines;
  const ExpandableText(this.text, {this.maxLines = 4, super.key});

  @override
  State<ExpandableText> createState() => _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText> {
  bool expanded = false;

  @override
  Widget build(BuildContext context) {
    final textWidget = Text(
      widget.text,
      maxLines: expanded ? null : widget.maxLines,
      overflow: expanded ? TextOverflow.visible : TextOverflow.ellipsis,
      style: Theme.of(context).textTheme.bodyLarge,
    );
    if (widget.text.length < 200) return textWidget;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        textWidget,
        TextButton(
          onPressed: () => setState(() => expanded = !expanded),
          child: Text(expanded ? 'Show less' : 'Read more'),
        ),
      ],
    );
  }
}

class ActorDetailScreen extends StatelessWidget {
  final int actorId;
  const ActorDetailScreen({super.key, required this.actorId});

  @override
  Widget build(BuildContext context) {
    final tmdbService = TMDBService();
    return Scaffold(
      appBar: AppBar(title: const Text('Actor Details')),
      body: FutureBuilder<Map<String, dynamic>>(
        future: tmdbService.getPersonDetails(actorId),
        builder: (context, snapshot) {
          if (!snapshot.hasData)
            return const Center(child: CircularProgressIndicator());
          final person = PersonModel.fromJson(snapshot.data!);
          return FutureBuilder<List<MovieModel>>(
            future: tmdbService.getPersonMovieCredits(actorId),
            builder: (context, movieSnapshot) {
              if (!movieSnapshot.hasData)
                return const Center(child: CircularProgressIndicator());
              final movies = movieSnapshot.data!;
              // Sort movies by popularity for Known For
              final knownFor = List<MovieModel>.from(movies)
                ..sort((a, b) => b.voteCount.compareTo(a.voteCount));
              // Group movies by year for Acting Credits
              final creditsByYear = <String, List<MovieModel>>{};
              for (final movie in movies) {
                final year =
                    (movie.releaseDate.isNotEmpty &&
                            movie.releaseDate.length >= 4)
                        ? movie.releaseDate.substring(0, 4)
                        : 'Unknown';
                creditsByYear.putIfAbsent(year, () => []).add(movie);
              }
              final sortedYears =
                  creditsByYear.keys.toList()..sort((a, b) => b.compareTo(a));
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Biography Section
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Center(
                            child: CircleAvatar(
                              radius: 60,
                              backgroundImage:
                                  person.profilePath.isNotEmpty
                                      ? NetworkImage(person.profileUrl)
                                      : null,
                              child:
                                  person.profilePath.isEmpty
                                      ? const Icon(Icons.person, size: 60)
                                      : null,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            person.name,
                            style: Theme.of(context).textTheme.headlineSmall
                                ?.copyWith(fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 8),
                          if (person.knownForDepartment.isNotEmpty)
                            Text(
                              person.knownForDepartment,
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          if (person.birthday.isNotEmpty)
                            Text(
                              'Born: ${person.birthday}',
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          if (person.placeOfBirth.isNotEmpty)
                            Text(
                              'Place of Birth: ${person.placeOfBirth}',
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          const SizedBox(height: 16),
                          if (person.biography.isNotEmpty)
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Biography',
                                  style: Theme.of(context).textTheme.titleMedium
                                      ?.copyWith(fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 8),
                                ExpandableText(person.biography),
                              ],
                            ),
                        ],
                      ),
                    ),
                    // Known For Section
                    if (knownFor.isNotEmpty) ...[
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          'Known For',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ),
                      SizedBox(
                        height: 220,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount:
                              knownFor.length > 10 ? 10 : knownFor.length,
                          itemBuilder: (context, index) {
                            final movie = knownFor[index];
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder:
                                        (context) => MovieDetailsScreen(
                                          movieId: movie.id,
                                        ),
                                  ),
                                );
                              },
                              child: Container(
                                width: 120,
                                margin: const EdgeInsets.all(8),
                                child: Column(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: Image.network(
                                        movie.posterUrl,
                                        height: 160,
                                        fit: BoxFit.cover,
                                        errorBuilder:
                                            (context, error, stackTrace) =>
                                                const Icon(
                                                  Icons.broken_image,
                                                  size: 80,
                                                ),
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      movie.title,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                    // Acting Credits Section
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      child: Text(
                        'Acting Credits',
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                    ),
                    for (final year in sortedYears)
                      if (creditsByYear[year] != null)
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 4,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                year,
                                style: Theme.of(context).textTheme.titleSmall
                                    ?.copyWith(fontWeight: FontWeight.bold),
                              ),
                              ...creditsByYear[year]!.map(
                                (movie) => ListTile(
                                  contentPadding: EdgeInsets.zero,
                                  leading:
                                      movie.posterPath.isNotEmpty
                                          ? Image.network(
                                            movie.posterUrl,
                                            width: 50,
                                            height: 75,
                                            fit: BoxFit.cover,
                                            errorBuilder:
                                                (context, error, stackTrace) =>
                                                    const Icon(
                                                      Icons.broken_image,
                                                      size: 40,
                                                    ),
                                          )
                                          : const SizedBox(
                                            width: 50,
                                            height: 75,
                                            child: Icon(Icons.movie),
                                          ),
                                  title: Text(movie.title),
                                  subtitle: Text(
                                    (movie as dynamic).character != null
                                        ? (movie as dynamic).character
                                        : '',
                                  ),
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder:
                                            (context) => MovieDetailsScreen(
                                              movieId: movie.id,
                                            ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
