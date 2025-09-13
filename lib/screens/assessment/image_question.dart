import 'package:flutter/material.dart';

class ImageQuestion extends StatefulWidget {
  final String questionText;
  final String imagePath;
  final List<String> options;
  final Function(String) onOptionSelected;

  const ImageQuestion({
    super.key,
    required this.questionText,
    required this.imagePath,
    required this.options,
    required this.onOptionSelected,
  });

  @override
  State<ImageQuestion> createState() => _ImageQuestionState();
}

class _ImageQuestionState extends State<ImageQuestion> {
  String? _selectedOption;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      clipBehavior: Clip
          .antiAlias, // Ensures the image respects the card's rounded corners
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                widget.questionText,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              // Display the image from your assets
              Image.asset(widget.imagePath),
              const SizedBox(height: 16),
              ...widget.options.map((option) {
                return RadioListTile<String>(
                  title: Text(option),
                  value: option,
                  groupValue: _selectedOption,
                  onChanged: (value) {
                    setState(() {
                      _selectedOption = value;
                    });
                    if (value != null) {
                      widget.onOptionSelected(value);
                    }
                  },
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
