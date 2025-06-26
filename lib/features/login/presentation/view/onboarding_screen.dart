import 'package:flutter/material.dart';
import 'package:medical/features/login/presentation/view/login.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Map<String, String>> _pages = [
    {
      'image': 'assets/images/splash_image_1 (1).png',
      'title': 'View & buy Medicine online',
      'subtitle':
          'Etiam mollis metus non purus faucibus sollicitudin. Pellentesque sagittis mi. Integer.'
    },
    {
      'image': 'assets/images/splash_image_1 (1).png',
      'title': 'Fast delivery',
      'subtitle':
          'Get your medicine delivered to your door in minutes with real-time tracking.'
    },
    {
      'image': 'assets/images/splash_image_1 (1).png',
      'title': 'Secure payments',
      'subtitle':
          'Pay safely with multiple methods and keep full control over your orders.'
    },
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // 3️⃣ PageView نفسه
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: _pages.length,
                onPageChanged: (index) =>
                    setState(() => _currentPage = index),
                itemBuilder: (context, index) {
                  final page = _pages[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          page['image']!,
                          width: 256,
                          height: 284,
                        ),
                        const SizedBox(height: 30),
                        Text(
                          page['title']!,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF0B1F3F),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          page['subtitle']!,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Color(0xFF8F9BB3),
                            height: 1.4,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            // 4️⃣ شريط الأزرار والمؤشّر
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // --- Skip
                  TextButton(
                    onPressed: _goToLogin,
                    child: Text(
                      'Skip',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[400],
                      ),
                    ),
                  ),

                  Row(
                    children: List.generate(
                      _pages.length,
                      (i) => _buildDot(isActive: i == _currentPage),
                    ),
                  ),

                  // --- Next
                  TextButton(
                    onPressed: _handleNext,
                    child: const Text(
                      'Next',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  // ---------------------------------
  // ⬇️ Functions

  void _handleNext() {
    if (_currentPage == _pages.length - 1) {
      _goToLogin();
    } else {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _goToLogin() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const LoginScreen()),
    );
  }

  Widget _buildDot({required bool isActive}) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      margin: const EdgeInsets.symmetric(horizontal: 4),
      width: isActive ? 12 : 10,
      height: isActive ? 12 : 10,
      decoration: BoxDecoration(
        color: isActive ? Colors.blue : Colors.grey[400],
        shape: BoxShape.circle,
      ),
    );
  }
}
