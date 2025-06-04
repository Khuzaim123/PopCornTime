import 'package:flutter/material.dart';
import 'package:popcorntime/features/splash/splash_screen.dart';
import 'package:popcorntime/features/auth/login/login_screen.dart';
import 'package:popcorntime/features/home/home_screen.dart';
import 'package:popcorntime/features/auth/signup/signup_screen.dart';

final Map<String, WidgetBuilder> routes = {
  '/': (context) => const SplashScreen(),
  '/login': (context) => const LoginScreen(),
  '/home': (context) => const HomeScreen(),
  '/signup': (context) => const SignupScreen(),
};
