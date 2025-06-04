import 'package:flutter/material.dart';
import 'package:popcorntime/models/movie_model.dart';
import 'package:popcorntime/services/tmdb_service.dart';
import 'package:popcorntime/core/routes/app_router.dart';
import 'dart:async';
import 'package:popcorntime/core/widgets/bottom_nav_bar.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TMDBService _tmdbService = TMDBService();
  final TextEditingController _searchController = TextEditingController();
  List<MovieModel> _searchResults = [];
  bool _isLoading = false;
  String? _error;
  Timer? _debounce;

  @override
  void dispose() {
    _debounce?.cancel();
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 400), () {
      _searchMovies(query);
    });
  }

  Future<void> _searchMovies(String query) async {
    if (query.isEmpty) {
      setState(() {
        _searchResults = [];
        _error = null;
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final response = await _tmdbService.searchMovies(query);
      setState(() {
        _searchResults = response.results;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _searchController,
          decoration: const InputDecoration(
            hintText: 'Search movies...',
            border: InputBorder.none,
          ),
          onChanged: _onSearchChanged,
          onSubmitted: _searchMovies,
        ),
      ),
      body:
          _isLoading
              ? const Center(child: CircularProgressIndicator())
              : _error != null
              ? Center(child: Text(_error!))
              : _searchResults.isEmpty
              ? const Center(child: Text('Search for movies to see results'))
              : ListView.builder(
                itemCount: _searchResults.length,
                itemBuilder: (context, index) {
                  final movie = _searchResults[index];
                  return ListTile(
                    leading:
                        movie.posterPath.isNotEmpty
                            ? Image.network(
                              movie.posterUrl,
                              width: 50,
                              height: 75,
                              fit: BoxFit.cover,
                            )
                            : const SizedBox(
                              width: 50,
                              height: 75,
                              child: Icon(Icons.movie),
                            ),
                    title: Text(movie.title),
                    subtitle: Text(
                      movie.releaseDate,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.star, color: Colors.amber, size: 20),
                        const SizedBox(width: 4),
                        Text(
                          movie.voteAverage.toStringAsFixed(1),
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                    onTap: () {
                      AppRouter.navigateToMovieDetails(
                        context,
                        movieId: movie.id,
                      );
                    },
                  );
                },
              ),
      bottomNavigationBar: BottomNavBar(currentIndex: 1),
    );
  }
}
