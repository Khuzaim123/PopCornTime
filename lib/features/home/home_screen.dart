import 'package:flutter/material.dart';
import 'package:popcorntime/models/movie_model.dart';
import 'package:popcorntime/services/tmdb_service.dart';
import 'package:popcorntime/core/routes/app_router.dart';
import 'package:popcorntime/core/widgets/bottom_nav_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TMDBService _tmdbService = TMDBService();
  int _currentIndex = 0;
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchSubmitted(String query) {
    if (query.isNotEmpty) {
      AppRouter.navigateToSearch(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PopCornTime'),
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
      body: ListView(
        children: [
          _buildMovieSection('Trending', _tmdbService.getTrendingMovies()),
          _buildMovieSection('Top Rated', _tmdbService.getTopRatedMovies()),
          _buildMovieSection('Upcoming', _tmdbService.getUpcomingMovies()),
          _buildMovieSection('Now Playing', _tmdbService.getNowPlayingMovies()),
        ],
      ),
      bottomNavigationBar: BottomNavBar(currentIndex: 0),
    );
  }

  Widget _buildMovieSection(String title, Future<dynamic> future) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(title, style: Theme.of(context).textTheme.headlineSmall),
        ),
        SizedBox(
          height: 270, // Adjust as needed for your card size
          child: FutureBuilder(
            future: future,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              if (snapshot.hasError) {
                return Center(child: Text('Error: \\${snapshot.error}'));
              }

              final movies = snapshot.data!.results as List<MovieModel>;
              return ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: movies.length,
                itemBuilder: (context, index) {
                  final movie = movies[index];
                  return GestureDetector(
                    onTap: () {
                      AppRouter.navigateToMovieDetails(
                        context,
                        movieId: movie.id,
                      );
                    },
                    child: Container(
                      width: 150,
                      margin: const EdgeInsets.only(left: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child:
                                movie.posterPath.isNotEmpty
                                    ? Image.network(
                                      movie.posterUrl,
                                      fit: BoxFit.cover,
                                    )
                                    : const Center(
                                      child: Icon(Icons.movie, size: 50),
                                    ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            movie.title,
                            style: Theme.of(context).textTheme.titleMedium,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              const Icon(
                                Icons.star,
                                color: Colors.amber,
                                size: 16,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                movie.voteAverage.toStringAsFixed(1),
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
