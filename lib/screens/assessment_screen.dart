import 'package:flutter/material.dart';
import 'package:lucent/screens/assessment/aptitude_test_screen.dart';
// Import the new interest assessment screen
import 'package:lucent/screens/assessment/interest_assessment_screen.dart';

class AssessmentScreen extends StatelessWidget {
  const AssessmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Assessments"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ... (The top text remains the same)
            const Text(
              "Discover Your Strengths",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              "These tests are designed to help you understand yourself better.",
              style: TextStyle(fontSize: 16, color: Colors.black54),
            ),
            const SizedBox(height: 32),

            // Aptitude Test Card
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading:
                          Icon(Icons.psychology, color: Colors.blue, size: 40),
                      title: Text("Aptitude Test",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                      subtitle: Text(
                          "Measures your logical reasoning and problem-solving skills."),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const AptitudeTestScreen(),
                          ),
                        );
                      },
                      child: const Text("Start Test"),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Interest Assessment Card
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading:
                          Icon(Icons.interests, color: Colors.orange, size: 40),
                      title: Text("Interest Assessment",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                      subtitle: Text(
                          "Helps you discover subjects and activities you are passionate about."),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        // **THIS IS THE UPDATE**
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) =>
                                const InterestAssessmentScreen(),
                          ),
                        );
                      },
                      child: const Text("Start Assessment"),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
