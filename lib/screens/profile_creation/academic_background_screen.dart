import 'package:flutter/material.dart';
// Import the new screen
import 'package:lucent/screens/profile_creation/preferences_screen.dart';

class AcademicBackgroundScreen extends StatefulWidget {
  const AcademicBackgroundScreen({super.key});

  @override
  State<AcademicBackgroundScreen> createState() =>
      _AcademicBackgroundScreenState();
}

class _AcademicBackgroundScreenState extends State<AcademicBackgroundScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Profile (2/4)"),
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(4.0),
          child: LinearProgressIndicator(
            value: 0.50, // 50% complete
            backgroundColor: Colors.white,
          ),
        ),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(24.0),
          children: [
            const Text(
              "Your Academic Details",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(labelText: 'Current Class'),
              items: ['9th', '10th', '11th', '12th']
                  .map(
                    (grade) =>
                        DropdownMenuItem(value: grade, child: Text(grade)),
                  )
                  .toList(),
              onChanged: (value) {},
              validator: (value) =>
                  value == null ? 'Please select your class' : null,
            ),
            const SizedBox(height: 16),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Subjects',
                hintText: 'e.g., Physics, Chemistry, Math',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your subjects';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Recent Grades / Percentage',
              ),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your grades';
                }
                return null;
              },
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  // **THIS IS THE UPDATE**
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const PreferencesScreen(),
                    ),
                  );
                }
              },
              child: const Text('Next', style: TextStyle(fontSize: 18)),
            ),
          ],
        ),
      ),
    );
  }
}
