// Paste this simplified code into: lib/main.dart

import 'package:flutter/material.dart';
import 'package:lucent/screens/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Define your themes directly here
    final ThemeData lightTheme = ThemeData(
      brightness: Brightness.light,
      primarySwatch: Colors.blue,
      // ... other light theme properties
    );

    final ThemeData darkTheme = ThemeData(
      brightness: Brightness.dark,
      primarySwatch: Colors.blue,
      scaffoldBackgroundColor: const Color(0xFF121212),
      // ... other dark theme properties
    );

    return MaterialApp(
      title: 'Lucent',
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      darkTheme: darkTheme,
      // This line tells the app to follow the phone's setting
      themeMode: ThemeMode.system,
      home: const SplashScreen(),
    );
  }
}
