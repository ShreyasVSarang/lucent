import 'package:flutter/material.dart';
import 'package:lucent/screens/resource_library_screen.dart'; // Import the new screen

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Hi, Alex!"),
        actions: [
          IconButton(
            icon: const CircleAvatar(
              backgroundColor: Colors.black26,
              child: Icon(Icons.person, color: Colors.white),
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // --- THIS IS THE NEW CARD ---
          Card(
            color: Colors.blue[50],
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

          // --- Existing Cards ---
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
