import 'package:flutter/material.dart';
// Import the new main navigation screen
import 'package:lucent/screens/main_navigation_screen.dart';

class ConfirmationScreen extends StatelessWidget {
  const ConfirmationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Profile (4/4)"),
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(4.0),
          child: LinearProgressIndicator(
            value: 1.0,
            backgroundColor: Colors.white,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(24.0),
        children: [
          const Text(
            "Review Your Details",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          const Divider(),
          _buildReviewTile('Full Name', 'Alex Doe (Placeholder)'),
          _buildReviewTile('Age', '16 (Placeholder)'),
          _buildReviewTile('Location', 'Mumbai (Placeholder)'),
          const Divider(),
          const SizedBox(height: 16),
          _buildReviewTile('Current Class', '10th (Placeholder)'),
          _buildReviewTile('Subjects', 'Physics, Chemistry (Placeholder)'),
          const Divider(),
          const SizedBox(height: 40),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              backgroundColor: Colors.green,
            ),
            onPressed: () {
              // **THIS IS THE UPDATE**
              // Navigate to the main app and remove all previous screens (onboarding flow)
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (context) => const MainNavigationScreen(),
                ),
                (Route<dynamic> route) =>
                    false, // This condition removes all previous routes
              );
            },
            child: const Text(
              'Finish Setup',
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReviewTile(String title, String subtitle) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(title, style: const TextStyle(color: Colors.black54)),
      subtitle: Text(
        subtitle,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
