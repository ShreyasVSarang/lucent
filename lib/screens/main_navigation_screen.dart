import 'package:flutter/material.dart';
import 'package:lucent/screens/dashboard_screen.dart';
import 'package:lucent/screens/assessment_screen.dart';
import 'package:lucent/screens/explore/explore_screen.dart';
import 'package:lucent/screens/planner_screen.dart';
// **1. IMPORT THE NEW SCREEN**
import 'package:lucent/screens/profile_screen.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _selectedIndex = 0;

  // **2. UPDATE THE WIDGET LIST**
  static const List<Widget> _widgetOptions = <Widget>[
    DashboardScreen(),
    AssessmentScreen(),
    ExploreScreen(),
    PlannerScreen(),
    ProfileScreen(), // Replaced the final placeholder
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        // ... (rest of the BottomNavigationBar code is the same)
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.blueAccent,
        unselectedItemColor: Colors.grey,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.assignment), label: 'Assess'),
          BottomNavigationBarItem(icon: Icon(Icons.explore), label: 'Explore'),
          BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today), label: 'Plan'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}
