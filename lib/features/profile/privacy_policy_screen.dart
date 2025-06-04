import 'package:flutter/material.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Privacy Policy')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            'Privacy Policy',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 16),
          Text(
            'Last Updated: January 1, 2023',
            style: Theme.of(context).textTheme.bodySmall,
          ),
          const SizedBox(height: 24),
          Text(
            '1. Data Collection',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 8),
          const Text(
            'We collect information that you provide directly to us, such as your name, email address, and any other information you choose to provide.',
          ),
          const SizedBox(height: 16),
          Text('2. Data Usage', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 8),
          const Text(
            'We use the information we collect to provide, maintain, and improve our services, to communicate with you, and to comply with legal obligations.',
          ),
          const SizedBox(height: 16),
          Text(
            '3. Data Sharing',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 8),
          const Text(
            'We do not share your personal information with third parties except as described in this policy.',
          ),
          const SizedBox(height: 16),
          Text(
            '4. Data Security',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 8),
          const Text(
            'We take reasonable measures to help protect your personal information from loss, theft, misuse, unauthorized access, disclosure, alteration, and destruction.',
          ),
          const SizedBox(height: 16),
          Text('5. Your Rights', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 8),
          const Text(
            'You have the right to access, correct, or delete your personal information. You may also have the right to restrict or object to certain processing of your information.',
          ),
          const SizedBox(height: 16),
          Text('6. Contact Us', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 8),
          const Text(
            'If you have any questions about this Privacy Policy, please contact us at privacy@popcorntime.com.',
          ),
        ],
      ),
    );
  }
}
