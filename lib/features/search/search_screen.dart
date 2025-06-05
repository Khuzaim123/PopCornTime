import 'package:flutter/material.dart';
import 'package:popcorntime/models/movie_model.dart';
import 'package:popcorntime/services/tmdb_service.dart';
import 'package:popcorntime/core/routes/app_router.dart';
import 'dart:async';
import 'package:popcorntime/core/widgets/bottom_nav_bar.dart';
import 'package:popcorntime/features/movie_details/movie_details_screen.dart';
import 'package:popcorntime/models/person_model.dart' as person;

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TMDBService _tmdbService = TMDBService();
  final TextEditingController _searchController = TextEditingController();
  List<dynamic> _searchResults = [];
  bool _isLoading = false;
  String? _error;
  Timer? _debounce;
  bool _isSearchingMovies = true;

  @override
  void dispose() {
    _debounce?.cancel();
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 400), () {
      _search(query);
    });
  }

  Future<void> _search(String query) async {
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
      if (_isSearchingMovies) {
        final response = await _tmdbService.searchMovies(query);
        setState(() {
          _searchResults = response.results;
          _isLoading = false;
        });
      } else {
        final response = await _tmdbService.searchActors(query);
        setState(() {
          _searchResults = response;
          _isLoading = false;
        });
      }
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
      appBar: AppBar(title: const Text('Search'), centerTitle: true),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Search movies or actors...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  prefixIcon: const Icon(Icons.search),
                ),
                onChanged: _onSearchChanged,
                onSubmitted: _search,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: SegmentedButton<bool>(
                segments: const [
                  ButtonSegment<bool>(
                    value: true,
                    label: Text('Movies'),
                    icon: Icon(Icons.movie),
                  ),
                  ButtonSegment<bool>(
                    value: false,
                    label: Text('Actors'),
                    icon: Icon(Icons.person),
                  ),
                ],
                selected: {_isSearchingMovies},
                onSelectionChanged: (Set<bool> newSelection) {
                  setState(() {
                    _isSearchingMovies = newSelection.first;
                    if (_searchController.text.isNotEmpty) {
                      _search(_searchController.text);
                    }
                  });
                },
              ),
            ),
            const SizedBox(height: 8),
            _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _error != null
                ? Center(child: Text(_error!))
                : _searchResults
                    .where(
                      (result) =>
                          _isSearchingMovies || (result is person.PersonModel),
                    )
                    .isEmpty
                ? Center(
                  child: Text(
                    'No ${_isSearchingMovies ? 'movies' : 'actors'} found.',
                    style: TextStyle(color: Colors.white70, fontSize: 16),
                  ),
                )
                : ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _searchResults.length,
                  itemBuilder: (context, index) {
                    final result = _searchResults[index];
                    if (_isSearchingMovies) {
                      final movie = result as MovieModel;
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
                            const Icon(
                              Icons.star,
                              color: Colors.amber,
                              size: 20,
                            ),
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
                    } else if (result is person.PersonModel) {
                      String knownFor = '';
                      if (result.knownFor != null &&
                          result.knownFor!.isNotEmpty) {
                        knownFor = result.knownFor!
                            .map((m) => m['title'] ?? m['name'] ?? '')
                            .where((t) => t != null && t.toString().isNotEmpty)
                            .join(', ');
                      }
                      return ListTile(
                        leading:
                            result.profilePath != null
                                ? Image.network(
                                  'https://image.tmdb.org/t/p/w200${result.profilePath}',
                                  width: 50,
                                  height: 75,
                                  fit: BoxFit.cover,
                                )
                                : const SizedBox(
                                  width: 50,
                                  height: 75,
                                  child: Icon(Icons.person),
                                ),
                        title: Text(result.name),
                        subtitle: Text(
                          knownFor.isNotEmpty
                              ? knownFor
                              : (result.knownForDepartment ?? 'Person'),
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (context) =>
                                      ActorDetailScreen(actorId: result.id),
                            ),
                          );
                        },
                      );
                    } else {
                      return const SizedBox.shrink();
                    }
                  },
                ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(currentIndex: 1),
    );
  }
}
