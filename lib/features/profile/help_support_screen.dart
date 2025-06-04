import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:popcorntime/features/profile/privacy_policy_screen.dart';
import 'package:popcorntime/features/profile/terms_of_service_screen.dart';

class HelpSupportScreen extends StatelessWidget {
  const HelpSupportScreen({super.key});

  void _launchEmail() async {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: 'support@popcorntime.com',
      query: 'subject=PopcornTime App Support',
    );
    if (await canLaunchUrl(emailLaunchUri)) {
      await launchUrl(emailLaunchUri);
    }
  }

  void _launchPhone() async {
    final Uri phoneUri = Uri(scheme: 'tel', path: '+923319067567');
    if (await canLaunchUrl(phoneUri)) {
      await launchUrl(phoneUri);
    }
  }

  void _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Help & Support')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            'Frequently Asked Questions',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 12),
          ExpansionTile(
            title: const Text('How do I add a movie to my watchlist?'),
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'When you watch the movie tailer it automatically add to your watchlist',
                ),
              ),
            ],
          ),
          ExpansionTile(
            title: const Text('How do I reset my password?'),
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'In the setting their is the section of reset password',
                ),
              ),
            ],
          ),
          ExpansionTile(
            title: const Text('Why are some posters missing?'),
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Some movies may not have posters available from TMDB.',
                ),
              ),
            ],
          ),
          ExpansionTile(
            title: const Text('How do I contact support?'),
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'You can email us at support@popcorntime.com or use the contact options below.',
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Text(
            'Contact Support',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 12),
          ListTile(
            leading: const Icon(Icons.email),
            title: const Text('Email'),
            subtitle: const Text('support@popcorntime.com'),
            onTap: _launchEmail,
          ),
          ListTile(
            leading: const Icon(Icons.phone),
            title: const Text('Phone'),
            subtitle: const Text('+923319067567'),
            onTap: _launchPhone,
          ),
          const SizedBox(height: 24),
          Text(
            'Troubleshooting',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 12),
          ListTile(
            leading: const Icon(Icons.help_outline),
            title: const Text('App is not loading'),
            subtitle: const Text(
              'Check your internet connection and try restarting the app.',
            ),
          ),
          ListTile(
            leading: const Icon(Icons.help_outline),
            title: const Text('Can\'t sign in'),
            subtitle: const Text(
              'Make sure your email and password are correct. If you forgot your password, use the reset option.',
            ),
          ),
          const SizedBox(height: 24),
          Text('Legal', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 12),
          ListTile(
            leading: const Icon(Icons.privacy_tip),
            title: const Text('Privacy Policy'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const PrivacyPolicyScreen(),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.article),
            title: const Text('Terms of Service'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const TermsOfServiceScreen(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
