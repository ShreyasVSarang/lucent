import 'dart:async';
import 'package:flutter/material.dart';
import 'package:lucent/screens/main_navigation_screen.dart';
import 'package:lucent/screens/welcome_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkOnboardingStatus();
  }

  Future<void> _checkOnboardingStatus() async {
    final prefs = await SharedPreferences.getInstance();
    // Check for the 'onboarding_complete' flag. It defaults to false if not found.
    final bool onboardingComplete =
        prefs.getBool('onboarding_complete') ?? false;

    // Wait for 3 seconds to show the splash screen
    Timer(const Duration(seconds: 3), () {
      if (mounted) {
        // Check if the widget is still in the tree
        // Navigate based on the flag's value
        if (onboardingComplete) {
          // If onboarding is complete, go to the main app
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
                builder: (context) => const MainNavigationScreen()),
          );
        } else {
          // If onboarding is not complete, go to the welcome screen
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const WelcomeScreen()),
          );
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.lightbulb_outline,
              size: 100,
              color: Colors.blueAccent,
            ),
            const SizedBox(height: 24),
            Text(
              'Lucent',
              style: Theme.of(context).textTheme.headlineLarge,
            ),
          ],
        ),
      ),
    );
  }
}
