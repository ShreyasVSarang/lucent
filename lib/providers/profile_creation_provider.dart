import 'package:flutter/material.dart';

class ProfileCreationProvider with ChangeNotifier {
  // Personal Info
  String? name;
  int? age;
  String? location;

  // Academic Info
  String? currentClass;
  String? subjects;
  String? grades;

  // Preferences
  String? profilePicturePath;
  String? preferredLanguage;
  bool enableNotifications = true;

  // We can add methods here to update the data, for example:
  void updatePersonalInfo({
    required String newName,
    required int newAge,
    required String newLocation,
  }) {
    name = newName;
    age = newAge;
    location = newLocation;
    // This tells any listening widgets to rebuild.
    notifyListeners();
  }
}
