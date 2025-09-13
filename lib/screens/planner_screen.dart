import 'dart:convert';
import 'package:flutter/material.dart'; // Make sure this import line is at the top
import 'package:flutter/services.dart';

class PlannerScreen extends StatefulWidget {
  const PlannerScreen({super.key});

  @override
  State<PlannerScreen> createState() => _PlannerScreenState();
}

class _PlannerScreenState extends State<PlannerScreen> {
  List _timelineEvents = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadTimelineData();
  }

  Future<void> _loadTimelineData() async {
    final String response =
        await rootBundle.loadString('assets/data/timeline_data.json');
    final data = await json.decode(response);
    setState(() {
      _timelineEvents = data;
      _isLoading = false;
    });
  }

  // Helper to get an icon based on the event type
  IconData _getIconForEventType(String type) {
    switch (type) {
      case 'Exam':
        return Icons.edit_document;
      case 'Deadline':
        return Icons.access_alarm;
      default:
        return Icons.event;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Academic Planner"),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: _timelineEvents.length,
              itemBuilder: (context, index) {
                final event = _timelineEvents[index];
                return Card(
                  elevation: 4,
                  margin: const EdgeInsets.symmetric(vertical: 8.0),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(16),
                    leading: Icon(
                      _getIconForEventType(event['type']),
                      color: Colors.blueAccent,
                      size: 36,
                    ),
                    title: Text(
                      event['title'],
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      'Date: ${event['date']}',
                      style: const TextStyle(color: Colors.black54),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
