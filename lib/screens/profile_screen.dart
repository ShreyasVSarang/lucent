// Paste this complete code into: lib/screens/profile_screen.dart

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:lucent/models/user_profile.dart';
import 'package:lucent/providers/theme_provider.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
      ),
      body: FutureBuilder(
        future: Hive.openBox<UserProfile>('userProfileBox'),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final box = snapshot.data!;
          final userProfile = box.get('mainProfile');

          if (userProfile == null) {
            return const Center(child: Text('No profile data found.'));
          }

          return ListView(
            children: [
              Container(
                padding: const EdgeInsets.all(24.0),
                color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                child: Column(
                  children: [
                    const CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.black26,
                      child: Icon(Icons.person, size: 60, color: Colors.white),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      userProfile.name,
                      style: const TextStyle(
                          fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      userProfile.location,
                      style: TextStyle(
                          fontSize: 16,
                          color: Theme.of(context).textTheme.bodySmall?.color),
                    ),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 24.0, left: 16.0, bottom: 8.0),
                child: Text("ACADEMIC DETAILS",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.grey)),
              ),
              Card(
                margin: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  children: [
                    ListTile(
                      leading: const Icon(Icons.class_outlined),
                      title: const Text("Current Class"),
                      subtitle: Text(userProfile.currentClass),
                    ),
                    ListTile(
                      leading: const Icon(Icons.book_outlined),
                      title: const Text("Subjects"),
                      subtitle: Text(userProfile.subjects.join(', ')),
                    ),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 24.0, left: 16.0, bottom: 8.0),
                child: Text("ACCOUNT & SETTINGS",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.grey)),
              ),
              Card(
                margin: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  children: [
                    SwitchListTile(
                      title: const Text("Dark Mode"),
                      value: themeProvider.themeMode == ThemeMode.dark,
                      onChanged: (value) {
                        themeProvider.toggleTheme();
                      },
                      secondary: const Icon(Icons.dark_mode_outlined),
                    ),
                    ListTile(
                      leading: const Icon(Icons.settings_outlined),
                      title: const Text("Settings"),
                      trailing: const Icon(Icons.arrow_forward_ios),
                      onTap: () {},
                    ),
                    ListTile(
                      leading: const Icon(Icons.logout, color: Colors.red),
                      title: const Text("Log Out",
                          style: TextStyle(color: Colors.red)),
                      onTap: () {},
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
