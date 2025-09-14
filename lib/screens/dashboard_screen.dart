// Paste this corrected code into: lib/screens/dashboard_screen.dart

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:lucent/models/user_profile.dart'; // Corrected import path
import 'package:lucent/screens/resource_library_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  String _userName = 'User';

  @override
  void initState() {
    super.initState();
    _loadUserName();
  }

  Future<void> _loadUserName() async {
    final box = await Hive.openBox<UserProfile>('userProfileBox');
    final userProfile = box.get('mainProfile');
    if (userProfile != null && mounted) {
      setState(() {
        _userName = userProfile.name;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hi, $_userName!"),
        actions: [
          IconButton(
            icon: const CircleAvatar(
              // Corrected syntax
              backgroundColor: Colors.black26,
              child: Icon(Icons.person, color: Colors.white),
            ),
            onPressed: () {},
          ),
        ],
      ),
      // ... rest of the body is the same ...
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          Card(
            color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
            elevation: 4,
            child: ListTile(
              leading:
                  const Icon(Icons.library_books, color: Colors.blue, size: 36),
              title: const Text("Resource Library",
                  style: TextStyle(fontWeight: FontWeight.bold)),
              subtitle:
                  const Text("Access study materials, videos, and tests."),
              trailing: const Icon(Icons.arrow_forward),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (context) => const ResourceLibraryScreen()),
                );
              },
            ),
          ),
          const SizedBox(height: 20),
          const Text("Top 3 Career Suggestions",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          const Card(
            child: ListTile(
              leading: Icon(Icons.code, color: Colors.green),
              title: Text("Software Engineer"),
              trailing: Icon(Icons.arrow_forward_ios),
            ),
          ),
          const Card(
            child: ListTile(
              leading: Icon(Icons.draw, color: Colors.orange),
              title: Text("UI/UX Designer"),
              trailing: Icon(Icons.arrow_forward_ios),
            ),
          ),
        ],
      ),
    );
  }
}
