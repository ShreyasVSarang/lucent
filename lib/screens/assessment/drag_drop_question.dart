import 'package:flutter/material.dart';

class DragDropQuestion extends StatefulWidget {
  final String questionText;
  final List<String> items;

  const DragDropQuestion({
    super.key,
    required this.questionText,
    required this.items,
  });

  @override
  State<DragDropQuestion> createState() => _DragDropQuestionState();
}

class _DragDropQuestionState extends State<DragDropQuestion> {
  late List<String> _rankedItems;

  @override
  void initState() {
    super.initState();
    // Make a copy of the list to modify it
    _rankedItems = List.from(widget.items);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              widget.questionText,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              "(Long-press and drag to rank)",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ReorderableListView(
                onReorder: (int oldIndex, int newIndex) {
                  setState(() {
                    if (oldIndex < newIndex) {
                      newIndex -= 1;
                    }
                    final String item = _rankedItems.removeAt(oldIndex);
                    _rankedItems.insert(newIndex, item);
                  });
                },
                children: _rankedItems.map((item) {
                  return Card(
                    key: ValueKey(item),
                    child: ListTile(
                      leading: const Icon(Icons.drag_handle),
                      title: Text(item),
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
