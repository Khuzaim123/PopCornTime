import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:popcorntime/features/auth/login/login_screen.dart';
import 'package:popcorntime/features/home/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkAuthAndNavigate();
  }

  Future<void> _checkAuthAndNavigate() async {
    // Show splash screen for at least 2 seconds
    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;

    // Check authentication state
    final user = FirebaseAuth.instance.currentUser;

    if (!mounted) return;

    // Navigate to appropriate screen
    Navigator.of(
      context,
    ).pushReplacementNamed(user != null ? '/home' : '/login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/Logo.png', // Make sure this matches your image path
              width: 150,
              height: 150,
              errorBuilder: (context, error, stackTrace) {
                return const Icon(Icons.movie, size: 150, color: Colors.white);
              },
            ),
            const SizedBox(height: 20),
            const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
