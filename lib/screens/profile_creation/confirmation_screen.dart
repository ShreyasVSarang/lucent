import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:lucent/models/user_profile.dart';
import 'package:lucent/providers/profile_creation_provider.dart';
import 'package:lucent/screens/main_navigation_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ConfirmationScreen extends StatelessWidget {
  const ConfirmationScreen({super.key});

  // Updated function to save the complete profile from the provider
  Future<void> _completeOnboardingAndSave(BuildContext context) async {
    final provider =
        Provider.of<ProfileCreationProvider>(context, listen: false);

    // --- SAVE THE DATA TO HIVE ---
    final box = await Hive.openBox<UserProfile>('userProfileBox');

    final userProfile = UserProfile()
      ..name = provider.name!
      ..age = provider.age!
      ..location = provider.location!
      ..currentClass = provider.currentClass!
      ..subjects = provider.subjects!.split(',').map((s) => s.trim()).toList();

    await box.put('mainProfile', userProfile);

    // --- SAVE THE ONBOARDING FLAG ---
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('onboarding_complete', true);

    if (context.mounted) {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const MainNavigationScreen()),
        (Route<dynamic> route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Access the provider to display the data
    final provider =
        Provider.of<ProfileCreationProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Profile (4/4)"),
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(4.0),
          child: LinearProgressIndicator(value: 1.0),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(24.0),
        children: [
          Text(
            "Review Your Details",
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 16),
          const Divider(),
          _buildReviewTile('Full Name', provider.name ?? 'Not set'),
          _buildReviewTile('Age', provider.age?.toString() ?? 'Not set'),
          _buildReviewTile('Location', provider.location ?? 'Not set'),
          const Divider(),
          const SizedBox(height: 16),
          _buildReviewTile('Current Class', provider.currentClass ?? 'Not set'),
          _buildReviewTile('Subjects', provider.subjects ?? 'Not set'),
          _buildReviewTile('Recent Grades', provider.grades ?? 'Not set'),
          const Divider(),
          const SizedBox(height: 16),
          _buildReviewTile('Language', provider.preferredLanguage ?? 'Not set'),
          const SizedBox(height: 40),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              backgroundColor: Colors.green,
            ),
            onPressed: () {
              _completeOnboardingAndSave(context);
            },
            child: const Text('Finish Setup',
                style: TextStyle(fontSize: 18, color: Colors.white)),
          ),
        ],
      ),
    );
  }

  // Helper widget to build the list tiles for reviewing data
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
