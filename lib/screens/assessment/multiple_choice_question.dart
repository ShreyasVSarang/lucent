import 'package:flutter/material.dart';

class MultipleChoiceQuestion extends StatefulWidget {
  final String questionText;
  final List<String> options;
  final Function(String) onOptionSelected;

  const MultipleChoiceQuestion({
    super.key,
    required this.questionText,
    required this.options,
    required this.onOptionSelected,
  });

  @override
  State<MultipleChoiceQuestion> createState() => _MultipleChoiceQuestionState();
}

class _MultipleChoiceQuestionState extends State<MultipleChoiceQuestion> {
  String? _selectedOption;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              widget.questionText,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),
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
    );
  }
}
