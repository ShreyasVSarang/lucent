import 'package:flutter/material.dart';
import 'package:lucent/providers/profile_creation_provider.dart';
import 'package:lucent/screens/profile_creation/preferences_screen.dart';
import 'package:provider/provider.dart';

class AcademicBackgroundScreen extends StatefulWidget {
  const AcademicBackgroundScreen({super.key});

  @override
  State<AcademicBackgroundScreen> createState() =>
      _AcademicBackgroundScreenState();
}

class _AcademicBackgroundScreenState extends State<AcademicBackgroundScreen> {
  final _formKey = GlobalKey<FormState>();

  final _subjectsController = TextEditingController();
  final _gradesController = TextEditingController();
  String? _selectedClass;

  @override
  void initState() {
    super.initState();
    // Pre-populate fields from the provider if data exists
    final provider =
        Provider.of<ProfileCreationProvider>(context, listen: false);
    if (provider.currentClass != null) {
      _selectedClass = provider.currentClass;
    }
    if (provider.subjects != null) {
      _subjectsController.text = provider.subjects!;
    }
    if (provider.grades != null) {
      _gradesController.text = provider.grades!;
    }
  }

  @override
  void dispose() {
    _subjectsController.dispose();
    _gradesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Profile (2/4)"),
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(4.0),
          child: LinearProgressIndicator(value: 0.50),
        ),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(24.0),
          children: [
            Text(
              "Your Academic Details",
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 24),
            DropdownButtonFormField<String>(
              initialValue: _selectedClass,
              decoration: const InputDecoration(labelText: 'Current Class'),
              items: ['9th', '10th', '11th', '12th']
                  .map((grade) => DropdownMenuItem(
                        value: grade,
                        child: Text(grade),
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  _selectedClass = value;
                });
              },
              validator: (value) =>
                  value == null ? 'Please select your class' : null,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _subjectsController,
              decoration: const InputDecoration(
                  labelText: 'Subjects',
                  hintText: 'e.g., Physics, Chemistry, Math'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your subjects';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _gradesController,
              decoration: const InputDecoration(
                  labelText: 'Recent Grades / Percentage'),
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
                  final provider = Provider.of<ProfileCreationProvider>(context,
                      listen: false);

                  // Save data to the provider
                  provider.currentClass = _selectedClass;
                  provider.subjects = _subjectsController.text;
                  provider.grades = _gradesController.text;

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
