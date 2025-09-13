import 'package:flutter/material.dart';
import 'package:lucent/providers/theme_provider.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const String userName = "Alex Doe";
    const String location = "Bengaluru, Karnataka";
    const String userClass = "10th Standard";
    const String subjects = "Science, Mathematics, English";

    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
      ),
      body: ListView(
        children: [
          Container(
            padding: const EdgeInsets.all(24.0),
            // Use theme-aware colors
            color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
            child: const Column(
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.black26,
                  child: Icon(Icons.person, size: 60, color: Colors.white),
                ),
                SizedBox(height: 16),
                Text(
                  userName,
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 4),
                Text(
                  location,
                  style: TextStyle(fontSize: 16, color: Colors.black54),
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 24.0, left: 16.0, bottom: 8.0),
            child: Text("ACADEMIC DETAILS",
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.grey)),
          ),
          const Card(
            margin: EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                ListTile(
                  leading: Icon(Icons.class_outlined),
                  title: Text("Current Class"),
                  subtitle: Text(userClass),
                ),
                ListTile(
                  leading: Icon(Icons.book_outlined),
                  title: Text("Subjects"),
                  subtitle: Text(subjects),
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 24.0, left: 16.0, bottom: 8.0),
            child: Text("ACCOUNT & SETTINGS",
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.grey)),
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
      ),
    );
  }
}
