import 'package:flutter/material.dart';

class AppRouter {
  static const String splash = '/';
  static const String login = '/login';
  static const String signup = '/signup';
  static const String home = '/home';
  static const String movieDetails = '/movie-details';
  static const String search = '/search';
  static const String watchlist = '/watchlist';
  static const String profile = '/profile';

  static void navigateToSplash(BuildContext context) {
    Navigator.pushReplacementNamed(context, splash);
  }

  static void navigateToLogin(BuildContext context) {
    Navigator.pushReplacementNamed(context, login);
  }

  static void navigateToSignup(BuildContext context) {
    Navigator.pushNamed(context, signup);
  }

  static void navigateToHome(BuildContext context) {
    Navigator.pushReplacementNamed(context, home);
  }

  static void navigateToMovieDetails(
    BuildContext context, {
    required int movieId,
  }) {
    Navigator.pushNamed(context, movieDetails, arguments: movieId);
  }

  static void navigateToSearch(BuildContext context) {
    Navigator.pushNamed(context, search);
  }

  static void navigateToWatchlist(BuildContext context) {
    Navigator.pushNamed(context, watchlist);
  }

  static void navigateToProfile(BuildContext context) {
    Navigator.pushNamed(context, profile);
  }

  static void pop(BuildContext context) {
    Navigator.pop(context);
  }
}
