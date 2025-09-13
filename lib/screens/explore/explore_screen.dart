import 'dart:convert';
// THIS IMPORT WAS MISSING FOR THE WIDGETS INSIDE THIS FILE
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lucent/screens/college_discovery/college_list_screen.dart';
import 'package:lucent/screens/explore/career_details_screen.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Explore"),
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.work), text: "Careers"),
              Tab(icon: Icon(Icons.school), text: "Colleges"),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            CareerList(),
            CollegeListScreen(),
          ],
        ),
      ),
    );
  }
}

// Widget for the Career List Tab
class CareerList extends StatefulWidget {
  const CareerList({super.key});

  @override
  State<CareerList> createState() => _CareerListState();
}

class _CareerListState extends State<CareerList> {
  List _careers = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadCareerData();
  }

  Future<void> _loadCareerData() async {
    final String response =
        await rootBundle.loadString('assets/data/careers_data.json');
    final data = await json.decode(response);
    setState(() {
      _careers = data;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? const Center(child: CircularProgressIndicator())
        : Column(
            children: [
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search for careers...',
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12.0)),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: _careers.length,
                  itemBuilder: (context, index) {
                    return Card(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 8.0),
                      elevation: 4,
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(16),
                        leading: const Icon(Icons.work_outline,
                            color: Colors.blueAccent),
                        title: Text(
                          _careers[index]['title'],
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(_careers[index]['description']),
                        trailing: const Icon(Icons.arrow_forward_ios),
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => CareerDetailsScreen(
                                careerData: _careers[index],
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          );
  }
}
