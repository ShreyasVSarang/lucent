// Paste this corrected code into: lib/screens/profile_creation/personal_info_screen.dart

import 'package:flutter/material.dart';
import 'package:lucent/screens/profile_creation/academic_background_screen.dart';

class PersonalInfoScreen extends StatefulWidget {
  const PersonalInfoScreen({super.key});

  @override
  State<PersonalInfoScreen> createState() => _PersonalInfoScreenState();
}

class _PersonalInfoScreenState extends State<PersonalInfoScreen> {
  final _formKey = GlobalKey<FormState>();

  // --- 1. ADD A VARIABLE TO STORE THE SELECTION ---
  String? _selectedLocation;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Profile (1/4)"),
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(4.0),
          child: LinearProgressIndicator(
            value: 0.25,
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
              "Tell us about yourself",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Full Name'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your name';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Age'),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your age';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),

            // --- 2. UPDATE THE DROPDOWN WIDGET ---
            DropdownButtonFormField<String>(
              initialValue: _selectedLocation, // Set the current value
              decoration: const InputDecoration(labelText: 'Location'),
              items: ['Bengaluru', 'Mumbai', 'Delhi', 'Chennai', 'Kolkata']
                  .map((city) => DropdownMenuItem(
                        value: city,
                        child: Text(city),
                      ))
                  .toList(),
              onChanged: (value) {
                // Update the state when a new value is selected
                setState(() {
                  _selectedLocation = value;
                });
              },
              validator: (value) =>
                  value == null ? 'Please select a location' : null,
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              onPressed: () {
                // Now, this will work correctly
                if (_formKey.currentState!.validate()) {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const AcademicBackgroundScreen(),
                    ),
                  );
                }
              },
              child: const Text('Next', style: TextStyle(fontSize: 18)),
            ),
            const SizedBox(height: 12),
            TextButton(
              onPressed: () {
                print('Skip button pressed!');
              },
              child: const Text('Skip for now'),
            ),
          ],
        ),
      ),
    );
  }
}
