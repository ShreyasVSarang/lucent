import 'package:flutter/material.dart';

class SliderQuestion extends StatefulWidget {
  final String questionText;

  const SliderQuestion({
    super.key,
    required this.questionText,
  });

  @override
  State<SliderQuestion> createState() => _SliderQuestionState();
}

class _SliderQuestionState extends State<SliderQuestion> {
  double _currentValue = 5; // Start the slider in the middle

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              widget.questionText,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),
            Slider(
              value: _currentValue,
              min: 1,
              max: 10,
              divisions: 9, // Creates 10 selectable points (1, 2, 3... 10)
              label: _currentValue.round().toString(),
              onChanged: (double value) {
                setState(() {
                  _currentValue = value;
                });
              },
            ),
            Text(
              'Your Rating: ${_currentValue.round()}',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}
