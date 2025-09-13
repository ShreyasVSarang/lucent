import 'package:flutter/material.dart';
import 'package:lucent/screens/assessment/drag_drop_question.dart';
import 'package:lucent/screens/assessment/image_question.dart';
import 'package:lucent/screens/assessment/multiple_choice_question.dart';
import 'package:lucent/screens/assessment/slider_question.dart';
// Import the new results screen
import 'package:lucent/screens/assessment/test_results_screen.dart';

enum QuestionType { multipleChoice, image, slider, dragAndDrop }

class Question {
  final String questionText;
  final List<String> options;
  final QuestionType type;
  final String? imagePath;

  Question({
    required this.questionText,
    this.options = const [],
    required this.type,
    this.imagePath,
  });
}

class AptitudeTestScreen extends StatefulWidget {
  const AptitudeTestScreen({super.key});

  @override
  State<AptitudeTestScreen> createState() => _AptitudeTestScreenState();
}

class _AptitudeTestScreenState extends State<AptitudeTestScreen> {
  final List<Question> _questions = [
    Question(
      questionText: 'Which number should come next? 1, 4, 9, 16, ?',
      options: ['20', '25', '30', '36'],
      type: QuestionType.multipleChoice,
    ),
    Question(
      questionText: 'Which shape is missing from the pattern?',
      imagePath: 'assets/images/puzzle_image.png',
      options: ['Triangle', 'Square', 'Circle', 'Star'],
      type: QuestionType.image,
    ),
    Question(
      questionText: 'Rank the following subjects from most to least favorite.',
      options: ['Mathematics', 'Science', 'History', 'English'],
      type: QuestionType.dragAndDrop,
    ),
    Question(
      questionText:
          'On a scale of 1 to 10, how confident are you in your math skills?',
      type: QuestionType.slider,
    ),
  ];

  int _currentQuestionIndex = 0;

  void _nextQuestion() {
    // **THIS IS THE UPDATE**
    if (_currentQuestionIndex < _questions.length - 1) {
      setState(() {
        _currentQuestionIndex++;
      });
    } else {
      // If it's the last question, navigate to the results screen
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const TestResultsScreen()),
      );
    }
  }

  void _previousQuestion() {
    setState(() {
      if (_currentQuestionIndex > 0) {
        _currentQuestionIndex--;
      }
    });
  }

  void _onOptionSelected(String selectedOption) {
    print('User selected: $selectedOption');
  }

  Widget _buildQuestionWidget(Question question) {
    switch (question.type) {
      case QuestionType.dragAndDrop:
        return DragDropQuestion(
          key: ValueKey(_currentQuestionIndex),
          questionText: question.questionText,
          items: question.options,
        );
      case QuestionType.slider:
        return SliderQuestion(
          key: ValueKey(_currentQuestionIndex),
          questionText: question.questionText,
        );
      case QuestionType.image:
        return ImageQuestion(
          key: ValueKey(_currentQuestionIndex),
          questionText: question.questionText,
          imagePath: question.imagePath!,
          options: question.options,
          onOptionSelected: _onOptionSelected,
        );
      case QuestionType.multipleChoice:
      default:
        return MultipleChoiceQuestion(
          key: ValueKey(_currentQuestionIndex),
          questionText: question.questionText,
          options: question.options,
          onOptionSelected: _onOptionSelected,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentQuestion = _questions[_currentQuestionIndex];
    final totalQuestions = _questions.length;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Aptitude Test'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(4.0),
          child: LinearProgressIndicator(
            value: (_currentQuestionIndex + 1) / totalQuestions,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Question ${_currentQuestionIndex + 1} of $totalQuestions',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: _buildQuestionWidget(currentQuestion),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed:
                      _currentQuestionIndex == 0 ? null : _previousQuestion,
                  child: const Text('<< Previous'),
                ),
                ElevatedButton(
                  onPressed: _nextQuestion,
                  child: Text(
                    _currentQuestionIndex == totalQuestions - 1
                        ? 'Finish'
                        : 'Next >>',
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
