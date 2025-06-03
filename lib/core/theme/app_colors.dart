import 'package:flutter/material.dart';

@immutable
class AppColors extends ThemeExtension<AppColors> {
  const AppColors({
    required this.ratingStarFilled,
    required this.ratingStarEmpty,
    required this.watchlistActive,
    required this.watchlistInactive,
    required this.movieCardGradient,
  });

  final Color ratingStarFilled;
  final Color ratingStarEmpty;
  final Color watchlistActive;
  final Color watchlistInactive;
  final LinearGradient movieCardGradient;

  @override
  ThemeExtension<AppColors> copyWith({
    Color? ratingStarFilled,
    Color? ratingStarEmpty,
    Color? watchlistActive,
    Color? watchlistInactive,
    LinearGradient? movieCardGradient,
  }) {
    return AppColors(
      ratingStarFilled: ratingStarFilled ?? this.ratingStarFilled,
      ratingStarEmpty: ratingStarEmpty ?? this.ratingStarEmpty,
      watchlistActive: watchlistActive ?? this.watchlistActive,
      watchlistInactive: watchlistInactive ?? this.watchlistInactive,
      movieCardGradient: movieCardGradient ?? this.movieCardGradient,
    );
  }

  @override
  ThemeExtension<AppColors> lerp(ThemeExtension<AppColors>? other, double t) {
    if (other is! AppColors) {
      return this;
    }
    return AppColors(
      ratingStarFilled:
          Color.lerp(ratingStarFilled, other.ratingStarFilled, t)!,
      ratingStarEmpty: Color.lerp(ratingStarEmpty, other.ratingStarEmpty, t)!,
      watchlistActive: Color.lerp(watchlistActive, other.watchlistActive, t)!,
      watchlistInactive:
          Color.lerp(watchlistInactive, other.watchlistInactive, t)!,
      movieCardGradient: movieCardGradient,
    );
  }

  static const light = AppColors(
    ratingStarFilled: Color(0xFFFFD700), // Gold
    ratingStarEmpty: Color(0xFF4A4A4A), // Dark Gray
    watchlistActive: Color(0xFFFFD700), // Gold
    watchlistInactive: Color(0xFF666666), // Medium Gray
    movieCardGradient: LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        Colors.transparent,
        Color(0xCC000000), // Semi-transparent Black
      ],
    ),
  );

  static const dark = AppColors(
    ratingStarFilled: Color(0xFFFFD700), // Gold
    ratingStarEmpty: Color(0xFF4A4A4A), // Dark Gray
    watchlistActive: Color(0xFFFFD700), // Gold
    watchlistInactive: Color(0xFF666666), // Medium Gray
    movieCardGradient: LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        Colors.transparent,
        Color(0xCC000000), // Semi-transparent Black
      ],
    ),
  );
}
