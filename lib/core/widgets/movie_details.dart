import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../theme/app_colors.dart';
import '../../models/movie_model.dart';
import '../../models/credits_model.dart';

class MovieDetails extends StatelessWidget {
  final MovieModel movie;
  final CreditsModel? credits;
  final bool isInWatchlist;
  final VoidCallback? onWatchlistToggle;
  final VoidCallback? onPlayTrailer;

  const MovieDetails({
    super.key,
    required this.movie,
    this.credits,
    this.isInWatchlist = false,
    this.onWatchlistToggle,
    this.onPlayTrailer,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final customColors = Theme.of(context).extension<AppColors>();

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Backdrop Image
          Stack(
            children: [
              AspectRatio(
                aspectRatio: 16 / 9,
                child: CachedNetworkImage(
                  imageUrl:
                      movie.backdropPath != null
                          ? 'https://image.tmdb.org/t/p/w1280${movie.backdropPath}'
                          : 'https://via.placeholder.com/1280x720',
                  fit: BoxFit.cover,
                  placeholder:
                      (context, url) => Container(
                        color: theme.colorScheme.surface,
                        child: const Center(child: CircularProgressIndicator()),
                      ),
                  errorWidget:
                      (context, url, error) => Container(
                        color: theme.colorScheme.surface,
                        child: const Icon(Icons.error),
                      ),
                ),
              ),
              // Gradient Overlay
              Positioned.fill(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black.withOpacity(0.8),
                      ],
                    ),
                  ),
                ),
              ),
              // Play Trailer Button
              if (onPlayTrailer != null)
                Positioned.fill(
                  child: Center(
                    child: IconButton(
                      onPressed: onPlayTrailer,
                      icon: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.5),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.play_arrow,
                          size: 32,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
          // Movie Info
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title and Watchlist Button
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        movie.title,
                        style: theme.textTheme.headlineMedium?.copyWith(
                          color: theme.colorScheme.onSurface,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    if (onWatchlistToggle != null)
                      IconButton(
                        onPressed: onWatchlistToggle,
                        icon: Icon(
                          isInWatchlist
                              ? Icons.bookmark
                              : Icons.bookmark_border,
                          color:
                              isInWatchlist
                                  ? customColors?.watchlistActive
                                  : customColors?.watchlistInactive,
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 8),
                // Rating
                Row(
                  children: [
                    Icon(
                      Icons.star,
                      size: 20,
                      color: customColors?.ratingStarFilled,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      movie.voteAverage.toStringAsFixed(1),
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: theme.colorScheme.onSurface,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Text(
                      '${movie.voteCount} votes',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.onSurface.withOpacity(0.7),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                // Release Date and Runtime
                Row(
                  children: [
                    if (movie.releaseDate != null) ...[
                      Icon(
                        Icons.calendar_today,
                        size: 16,
                        color: theme.colorScheme.onSurface.withOpacity(0.7),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        movie.releaseDate!.isNotEmpty &&
                                movie.releaseDate!.length >= 4
                            ? movie.releaseDate!.substring(0, 4)
                            : '',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.onSurface.withOpacity(0.7),
                        ),
                      ),
                      const SizedBox(width: 16),
                    ],
                    if (movie.runtime != null) ...[
                      Icon(
                        Icons.access_time,
                        size: 16,
                        color: theme.colorScheme.onSurface.withOpacity(0.7),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '${movie.runtime} min',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.onSurface.withOpacity(0.7),
                        ),
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: 16),
                // Genres
                if (movie.genres != null && movie.genres!.isNotEmpty)
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children:
                        movie.genres!.map((genre) {
                          return Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: theme.colorScheme.primary,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Text(
                              genre.name,
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: theme.colorScheme.onPrimary,
                              ),
                            ),
                          );
                        }).toList(),
                  ),
                const SizedBox(height: 24),
                // Overview
                Text(
                  'Overview',
                  style: theme.textTheme.titleLarge?.copyWith(
                    color: theme.colorScheme.onSurface,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  movie.overview,
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: theme.colorScheme.onSurface.withOpacity(0.9),
                    height: 1.5,
                  ),
                ),
                if (credits != null) ...[
                  const SizedBox(height: 24),
                  // Cast
                  Text(
                    'Cast',
                    style: theme.textTheme.titleLarge?.copyWith(
                      color: theme.colorScheme.onSurface,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    height: 120,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: credits!.cast.length,
                      itemBuilder: (context, index) {
                        final person = credits!.cast[index];
                        return Padding(
                          padding: const EdgeInsets.only(right: 16),
                          child: Column(
                            children: [
                              CircleAvatar(
                                radius: 32,
                                backgroundImage:
                                    person.profilePath != null
                                        ? CachedNetworkImageProvider(
                                          'https://image.tmdb.org/t/p/w185${person.profilePath}',
                                        )
                                        : null,
                                child:
                                    person.profilePath == null
                                        ? const Icon(Icons.person)
                                        : null,
                              ),
                              const SizedBox(height: 8),
                              Text(
                                person.name,
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  color: theme.colorScheme.onSurface,
                                  fontWeight: FontWeight.bold,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                person.character,
                                style: theme.textTheme.bodySmall?.copyWith(
                                  color: theme.colorScheme.onSurface
                                      .withOpacity(0.7),
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
