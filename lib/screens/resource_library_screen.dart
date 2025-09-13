import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ResourceLibraryScreen extends StatefulWidget {
  const ResourceLibraryScreen({super.key});

  @override
  State<ResourceLibraryScreen> createState() => _ResourceLibraryScreenState();
}

class _ResourceLibraryScreenState extends State<ResourceLibraryScreen> {
  List _materials = [];
  List _videos = [];
  List _tests = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadResources();
  }

  Future<void> _loadResources() async {
    final String response =
        await rootBundle.loadString('assets/data/resources_data.json');
    final List<dynamic> data = json.decode(response);
    setState(() {
      _materials = data.where((item) => item['type'] == 'material').toList();
      _videos = data.where((item) => item['type'] == 'video').toList();
      _tests = data.where((item) => item['type'] == 'test').toList();
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Resource Library"),
          bottom: const TabBar(
            tabs: [
              Tab(text: "Materials"),
              Tab(text: "Videos"),
              Tab(text: "Practice Tests"),
            ],
          ),
        ),
        body: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : TabBarView(
                children: [
                  _buildResourceList(_materials, Icons.picture_as_pdf),
                  _buildResourceList(_videos, Icons.video_collection),
                  _buildResourceList(_tests, Icons.quiz),
                ],
              ),
      ),
    );
  }

  // Helper widget to build a list for any category
  Widget _buildResourceList(List resources, IconData icon) {
    return ListView.builder(
      itemCount: resources.length,
      itemBuilder: (context, index) {
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: ListTile(
            leading: Icon(icon, color: Colors.blueAccent),
            title: Text(resources[index]['title']),
            subtitle: Text(resources[index]['description']),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {},
          ),
        );
      },
    );
  }
}
