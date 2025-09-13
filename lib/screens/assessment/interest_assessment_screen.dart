import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:lucent/screens/assessment/interest_questions/star_rating_question.dart';
import 'package:lucent/screens/assessment/interest_questions/scenario_question.dart';

class InterestAssessmentScreen extends StatefulWidget {
  const InterestAssessmentScreen({super.key});

  @override
  State<InterestAssessmentScreen> createState() =>
      _InterestAssessmentScreenState();
}

class _InterestAssessmentScreenState extends State<InterestAssessmentScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  final int _totalPages = 3; // We now have 3 pages

  // --- Data for Step 1: Card Swipe ---
  final List<String> interests = [
    'Creative Writing',
    'Solving Complex Puzzles',
    'Building things',
    'Public Speaking',
  ];

  // --- Data for Step 2: Star Rating ---
  final List<String> subjects = [
    'Mathematics',
    'Physics',
    'History',
    'Literature'
  ];

  // --- Data for Step 3: Scenario ---
  final String scenario =
      'Your team is given a challenging project with a tight deadline.';
  final List<String> choices = [
    'Organize and delegate tasks to the team.',
    'Start working on the hardest part by yourself.',
    'Research different ways to approach the project.',
    'Brainstorm creative ideas with the team.',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Interest Assessment"),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(4.0),
          child:
              LinearProgressIndicator(value: (_currentPage + 1) / _totalPages),
        ),
      ),
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        onPageChanged: (page) => setState(() => _currentPage = page),
        children: [
          _buildCardSwipePage(),
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: StarRatingQuestion(
              questionText: "How much do you enjoy these subjects?",
              subjects: subjects,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: ScenarioQuestion(
              scenarioText: scenario,
              choices: choices,
            ),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(24.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 16),
          ),
          onPressed: () {
            if (_currentPage < _totalPages - 1) {
              _pageController.nextPage(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeIn,
              );
            } else {
              print("Interest Assessment Finished!");
              Navigator.of(context).pop();
            }
          },
          child: Text(
            _currentPage < _totalPages - 1 ? 'Next' : 'Finish',
            style: const TextStyle(fontSize: 18),
          ),
        ),
      ),
    );
  }

  Widget _buildCardSwipePage() {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        children: [
          const Text('Which activities do you enjoy?',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          const Text('Swipe Right for "Like"',
              style: TextStyle(fontSize: 16, color: Colors.grey)),
          Expanded(
            child: CardSwiper(
              cardsCount: interests.length,
              onSwipe: (p, c, d) => true,
              cardBuilder: (context, index, a, b) {
                return Card(
                  elevation: 8,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(interests[index],
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold)),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
