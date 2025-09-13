import 'package:flutter/material.dart';

class CollegeDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> collegeData;

  const CollegeDetailsScreen({
    super.key,
    required this.collegeData,
  });

  @override
  Widget build(BuildContext context) {
    // Placeholder data
    final List<String> facilities = [
      'Library',
      'Hostel',
      'Sports Complex',
      'Labs'
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(collegeData['name']),
      ),
      body: ListView(
        children: [
          Image.asset(
            collegeData['image'],
            width: double.infinity,
            height: 250,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  collegeData['name'],
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.location_on, color: Colors.grey, size: 18),
                    const SizedBox(width: 4),
                    Text(
                      collegeData['location'],
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.star, color: Colors.amber, size: 18),
                    const SizedBox(width: 4),
                    Text(
                      '${collegeData['rating']} Rating',
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),
                const Divider(height: 32),
                const Text(
                  "Facilities",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8.0,
                  runSpacing: 4.0,
                  children: facilities
                      .map((facility) => Chip(label: Text(facility)))
                      .toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
