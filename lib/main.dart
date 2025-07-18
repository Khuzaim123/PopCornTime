import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:popcorntime/features/splash/splash_screen.dart';
import 'package:popcorntime/core/theme/app_theme.dart';
import 'package:popcorntime/features/auth/login/login_screen.dart';
import 'package:popcorntime/features/home/home_screen.dart';
import 'firebase_options.dart';
import 'routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PopcornTime',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.dark, // Set initial theme mode to dark
      debugShowCheckedModeBanner: false,
      initialRoute: '/', // Set the initial route
      routes: routes, // Use the defined routes
    );
  }
}
