import 'package:flutter/material.dart';
import 'package:lucent/providers/profile_creation_provider.dart';
import 'package:lucent/screens/profile_creation/academic_background_screen.dart';
import 'package:provider/provider.dart'; // CORRECTED: Import path for provider

class PersonalInfoScreen extends StatefulWidget {
  const PersonalInfoScreen({super.key});

  @override
  State<PersonalInfoScreen> createState() => _PersonalInfoScreenState();
}

class _PersonalInfoScreenState extends State<PersonalInfoScreen> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  String? _selectedLocation;

  @override
  void initState() {
    super.initState();
    // NEW: Pre-populate fields if data already exists in the provider.
    // This makes the form stateful when navigating back and forth.
    final provider =
        Provider.of<ProfileCreationProvider>(context, listen: false);
    if (provider.name != null) {
      _nameController.text = provider.name!;
    }
    if (provider.age != null) {
      _ageController.text = provider.age.toString();
    }
    if (provider.location != null) {
      _selectedLocation = provider.location;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Profile (1/4)"),
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(4.0),
          child: LinearProgressIndicator(value: 0.25),
        ),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(24.0),
          children: [
            Text(
              "Tell us about yourself",
              // UPDATED: Using theme-aware text styles
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 24),
            TextFormField(
              controller: _nameController,
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
              controller: _ageController,
              decoration: const InputDecoration(labelText: 'Age'),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your age';
                }
                if (int.tryParse(value) == null) {
                  return 'Please enter a valid number';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              initialValue: _selectedLocation,
              decoration: const InputDecoration(labelText: 'Location'),
              items: ['Bengaluru', 'Mumbai', 'Delhi', 'Chennai', 'Kolkata']
                  .map((city) =>
                      DropdownMenuItem(value: city, child: Text(city)))
                  .toList(),
              onChanged: (value) {
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
                if (_formKey.currentState!.validate()) {
                  final provider = Provider.of<ProfileCreationProvider>(context,
                      listen: false);

                  provider.updatePersonalInfo(
                    newName: _nameController.text,
                    newAge: int.parse(_ageController.text),
                    newLocation: _selectedLocation!,
                  );

                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const AcademicBackgroundScreen(),
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
