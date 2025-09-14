// Paste this complete code into: lib/screens/profile_creation/preferences_screen.dart

import 'package:flutter/material.dart';
import 'package:lucent/providers/profile_creation_provider.dart';
import 'package:lucent/screens/profile_creation/confirmation_screen.dart';
import 'package:provider/provider.dart';

class PreferencesScreen extends StatefulWidget {
  const PreferencesScreen({super.key});

  @override
  State<PreferencesScreen> createState() => _PreferencesScreenState();
}

class _PreferencesScreenState extends State<PreferencesScreen> {
  final _formKey = GlobalKey<FormState>();

  String? _selectedLanguage;
  bool _enableNotifications = true;

  @override
  void initState() {
    super.initState();
    // Pre-populate fields from the provider
    final provider =
        Provider.of<ProfileCreationProvider>(context, listen: false);
    _selectedLanguage = provider.preferredLanguage;
    _enableNotifications = provider.enableNotifications;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Profile (3/4)"),
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(4.0),
          child: LinearProgressIndicator(value: 0.75),
        ),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(24.0),
          children: [
            Text(
              "Profile Picture (Optional)",
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 24),
            Center(
              child: Stack(
                children: [
                  const CircleAvatar(
                    radius: 60,
                    backgroundColor: Colors.black12,
                    child: Icon(Icons.person, size: 70, color: Colors.white),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: IconButton(
                      icon: CircleAvatar(
                        radius: 20,
                        backgroundColor: Theme.of(context).primaryColor,
                        child: const Icon(Icons.camera_alt,
                            color: Colors.white, size: 20),
                      ),
                      onPressed: () {
                        // Image picker logic would go here
                        print('Add photo pressed!');
                      },
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
            Text(
              "Settings & Preferences",
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 24),
            DropdownButtonFormField<String>(
              initialValue: _selectedLanguage,
              decoration:
                  const InputDecoration(labelText: 'Preferred Language'),
              items: ['English', 'Hindi', 'Kannada', 'Tamil', 'Telugu']
                  .map((lang) =>
                      DropdownMenuItem(value: lang, child: Text(lang)))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  _selectedLanguage = value;
                });
              },
              validator: (value) =>
                  value == null ? 'Please select a language' : null,
            ),
            const SizedBox(height: 16),
            SwitchListTile(
              title: const Text('Enable Notifications'),
              value: _enableNotifications,
              onChanged: (bool value) {
                setState(() {
                  _enableNotifications = value;
                });
              },
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  final provider = Provider.of<ProfileCreationProvider>(context,
                      listen: false);

                  // Save data to the provider
                  provider.preferredLanguage = _selectedLanguage;
                  provider.enableNotifications = _enableNotifications;

                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const ConfirmationScreen(),
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
