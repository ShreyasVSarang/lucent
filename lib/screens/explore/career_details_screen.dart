import 'package:flutter/material.dart';

class CareerDetailsScreen extends StatelessWidget {
  // We will pass the career data to this screen
  final Map<String, dynamic> careerData;

  const CareerDetailsScreen({
    super.key,
    required this.careerData,
  });

  @override
  Widget build(BuildContext context) {
    // Placeholder data for skills and salary
    final List<String> skills = ['Problem Solving', 'Logic', 'Creativity'];
    const String salaryRange = '₹8 - 25 LPA';

    return Scaffold(
      appBar: AppBar(
        title: Text(careerData['title']),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          Text(
            careerData['title'],
            style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          Text(
            careerData['field'],
            style: const TextStyle(fontSize: 18, color: Colors.black54),
          ),
          const Divider(height: 32),
          const Text(
            "About the Role",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            careerData['description'],
            style: const TextStyle(fontSize: 16, height: 1.5),
          ),
          const SizedBox(height: 24),
          const Text(
            "Skills Required",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8.0,
            children: skills.map((skill) => Chip(label: Text(skill))).toList(),
          ),
          const SizedBox(height: 24),
          const Text(
            "Average Salary Range",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text(
            salaryRange,
            style: TextStyle(fontSize: 18, color: Colors.green),
          ),
        ],
      ),
    );
  }
}
