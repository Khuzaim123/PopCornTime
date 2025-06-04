import 'package:flutter/material.dart';

class TermsOfServiceScreen extends StatelessWidget {
  const TermsOfServiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Terms of Service')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            'Terms of Service',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 16),
          Text(
            'Last Updated: January 1, 2023',
            style: Theme.of(context).textTheme.bodySmall,
          ),
          const SizedBox(height: 24),
          Text(
            '1. Acceptance of Terms',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 8),
          const Text(
            'By accessing or using PopcornTime, you agree to be bound by these Terms of Service.',
          ),
          const SizedBox(height: 16),
          Text(
            '2. User Obligations',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 8),
          const Text(
            'You agree not to use the service for any illegal or unauthorized purpose. You must not transmit any worms, viruses, or any code of a destructive nature.',
          ),
          const SizedBox(height: 16),
          Text(
            '3. Intellectual Property',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 8),
          const Text(
            'The content, organization, graphics, design, and other matters related to the service are protected under applicable copyrights and other proprietary laws.',
          ),
          const SizedBox(height: 16),
          Text('4. Disclaimer', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 8),
          const Text(
            'The service is provided "as is" without any warranties, expressed or implied. We do not guarantee that the service will be uninterrupted or error-free.',
          ),
          const SizedBox(height: 16),
          Text(
            '5. Limitation of Liability',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 8),
          const Text(
            'In no event shall PopcornTime be liable for any indirect, incidental, special, consequential, or punitive damages, including without limitation, loss of profits, data, use, goodwill, or other intangible losses.',
          ),
          const SizedBox(height: 16),
          Text('6. Contact Us', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 8),
          const Text(
            'If you have any questions about these Terms of Service, please contact us at terms@popcorntime.com.',
          ),
        ],
      ),
    );
  }
}
