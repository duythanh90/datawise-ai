import 'package:flutter/material.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({Key? key}) : super(key: key);

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _pageController,
            children: [
              IntroPage(
                title: 'Add Your Data',
                description:
                    'You can add your data via a link, PDF, or text file, and the app will store it securely.',
                image: 'assets/images/intro.png',
              ),
              IntroPage(
                title: 'Chatbot Creation',
                description:
                    'A chatbot is automatically created from your data to answer questions based on the information.',
                image: 'assets/images/intro.png',
              ),
              IntroPage(
                title: 'Share Your Bot',
                description:
                    'You can share your chatbot with others to help them access the information you’ve added.',
                image: 'assets/images/intro.png',
              ),
            ],
          ),
          Positioned(
            bottom: 50,
            left: 20,
            right: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Implement skip or move to login/register here
                    Navigator.pushReplacementNamed(context, '/login');
                  },
                  child: const Text('Skip'),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_pageController.page == 2) {
                      // Navigate to Login/Register screen after last page
                      Navigator.pushReplacementNamed(context, '/login');
                    } else {
                      _pageController.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    }
                  },
                  child: const Text('Next'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class IntroPage extends StatelessWidget {
  final String title;
  final String description;
  final String image;

  const IntroPage({
    Key? key,
    required this.title,
    required this.description,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            image,
            height: 200,
          ),
          const SizedBox(height: 20),
          Text(
            title,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          Text(
            description,
            style: const TextStyle(
              fontSize: 16,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
