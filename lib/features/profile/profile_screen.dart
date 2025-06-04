import 'package:flutter/material.dart';
import 'package:popcorntime/services/auth_service.dart';
import 'package:popcorntime/core/routes/app_router.dart';
import 'package:popcorntime/core/widgets/bottom_nav_bar.dart';
import 'package:popcorntime/features/profile/help_support_screen.dart';
import 'package:popcorntime/features/profile/settings_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = AuthService().currentUser;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              try {
                await AuthService().signOut();
                if (context.mounted) {
                  AppRouter.navigateToLogin(context);
                }
              } catch (e) {
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Error: ${e.toString()}')),
                  );
                }
              }
            },
          ),
        ],
      ),
      body:
          user == null
              ? const Center(child: Text('Please sign in to view your profile'))
              : ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  const CircleAvatar(
                    radius: 50,
                    child: Icon(Icons.person, size: 50),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    user.displayName ?? 'User',
                    style: Theme.of(context).textTheme.headlineSmall,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    user.email ?? '',
                    style: Theme.of(context).textTheme.bodyLarge,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 32),
                  ListTile(
                    leading: const Icon(Icons.bookmark),
                    title: const Text('My Watchlist'),
                    onTap: () {
                      AppRouter.navigateToWatchlist(context);
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.settings),
                    title: const Text('Settings'),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SettingsScreen(),
                        ),
                      );
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.help),
                    title: const Text('Help & Support'),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HelpSupportScreen(),
                        ),
                      );
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.info),
                    title: const Text('About'),
                    onTap: () {
                      showAboutDialog(
                        context: context,
                        applicationName: 'Popcorn Time',
                        applicationVersion: '1.0.0',
                        applicationIcon: const FlutterLogo(size: 64),
                        children: const [
                          Text(
                            'Popcorn Time is a movie browsing app that helps you discover and keep track of your favorite movies.',
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
      bottomNavigationBar: BottomNavBar(currentIndex: 3),
    );
  }
}
