import 'package:flutter/material.dart';
import 'package:popcorntime/features/splash/splash_screen.dart';
import 'package:popcorntime/features/auth/login/login_screen.dart';
import 'package:popcorntime/features/auth/signup/signup_screen.dart';
import 'package:popcorntime/features/home/home_screen.dart';
import 'package:popcorntime/features/movie_details/movie_details_screen.dart';
import 'package:popcorntime/features/search/search_screen.dart';
import 'package:popcorntime/features/watchlist/watchlist_screen.dart';
import 'package:popcorntime/features/profile/profile_screen.dart';

final Map<String, WidgetBuilder> routes = {
  '/': (context) => const SplashScreen(),
  '/login': (context) => const LoginScreen(),
  '/signup': (context) => const SignupScreen(),
  '/home': (context) => const HomeScreen(),
  '/movie-details': (context) {
    final movieId = ModalRoute.of(context)!.settings.arguments as int;
    return MovieDetailsScreen(movieId: movieId);
  },
  '/search': (context) => const SearchScreen(),
  '/watchlist': (context) => const WatchlistScreen(),
  '/profile': (context) => const ProfileScreen(),
};
