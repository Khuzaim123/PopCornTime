import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:popcorntime/services/watchlist_service.dart';
import 'package:popcorntime/services/tmdb_service.dart';
import 'package:popcorntime/models/movie_model.dart';
import 'package:popcorntime/features/movie_details/movie_details_screen.dart';
import 'package:popcorntime/core/widgets/bottom_nav_bar.dart';

class WatchlistScreen extends StatefulWidget {
  const WatchlistScreen({super.key});

  @override
  State<WatchlistScreen> createState() => _WatchlistScreenState();
}

class _WatchlistScreenState extends State<WatchlistScreen> {
  final WatchlistService _watchlistService = WatchlistService();
  final TMDBService _tmdbService = TMDBService();
  late Future<List<MovieModel>> _moviesFuture;
  Set<int> _selectedMovieIds = {};

  @override
  void initState() {
    super.initState();
    _moviesFuture = _fetchWatchlistMovies();
  }

  Future<List<MovieModel>> _fetchWatchlistMovies() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return [];
    final movieIds = await _watchlistService.getWatchlist(user.uid);
    if (movieIds.isEmpty) return [];
    final movies = <MovieModel>[];
    for (final id in movieIds) {
      try {
        final movie = await _tmdbService.getMovieDetails(id);
        movies.add(movie);
      } catch (_) {}
    }
    return movies;
  }

  Future<void> _removeSelectedMovies() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;
    for (final id in _selectedMovieIds) {
      await _watchlistService.removeFromWatchlist(user.uid, id);
    }
    setState(() {
      _selectedMovieIds.clear();
      _moviesFuture = _fetchWatchlistMovies();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Watchlist'),
        actions: [
          if (_selectedMovieIds.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: _removeSelectedMovies,
              tooltip: 'Remove selected',
            ),
        ],
      ),
      body: FutureBuilder<List<MovieModel>>(
        future: _moviesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: \\${snapshot.error}'));
          }
          final movies = snapshot.data ?? [];
          if (movies.isEmpty) {
            return const Center(
              child: Text('Your watchlist will appear here.'),
            );
          }
          return ListView.builder(
            itemCount: movies.length,
            itemBuilder: (context, index) {
              final movie = movies[index];
              final isSelected = _selectedMovieIds.contains(movie.id);
              return ListTile(
                leading:
                    movie.posterPath.isNotEmpty
                        ? Image.network(
                          movie.posterUrl,
                          width: 50,
                          height: 75,
                          fit: BoxFit.cover,
                          errorBuilder:
                              (context, error, stackTrace) =>
                                  const Icon(Icons.broken_image, size: 50),
                        )
                        : const SizedBox(
                          width: 50,
                          height: 75,
                          child: Icon(Icons.movie),
                        ),
                title: Text(movie.title),
                subtitle: Text(movie.releaseDate),
                selected: isSelected,
                selectedTileColor: Colors.red.withOpacity(0.1),
                onTap: () {
                  if (_selectedMovieIds.isNotEmpty) {
                    setState(() {
                      if (isSelected) {
                        _selectedMovieIds.remove(movie.id);
                      } else {
                        _selectedMovieIds.add(movie.id);
                      }
                    });
                  } else {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (context) => MovieDetailsScreen(movieId: movie.id),
                      ),
                    );
                  }
                },
                onLongPress: () {
                  setState(() {
                    if (isSelected) {
                      _selectedMovieIds.remove(movie.id);
                    } else {
                      _selectedMovieIds.add(movie.id);
                    }
                  });
                },
              );
            },
          );
        },
      ),
      bottomNavigationBar: BottomNavBar(currentIndex: 2),
    );
  }
}
 