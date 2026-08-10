import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_colors.dart';
import '../widgets/auth_button.dart';
import '../widgets/auth_screen_scaffold.dart';
import '../widgets/onboarding_slide.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final _pageController = PageController();
  int _currentPage = 0;

  static const _slides = [
    (
      image: 'assets/images/onboarding/slide1.png',
      title: 'Suivre ses dépenses facilement',
      description:
          'Enregistrez chaque dépense en quelques secondes, où que vous soyez.',
    ),
    (
      image: 'assets/images/onboarding/slide2.png',
      title: 'Visualiser ses dépenses par catégorie',
      description:
          'Comprenez où part votre argent grâce à des graphiques clairs.',
    ),
    (
      image: 'assets/images/onboarding/slide3.png',
      title: 'Atteindre ses objectifs financiers',
      description:
          'Fixez-vous des objectifs et suivez votre progression au fil du temps.',
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _goToLogin() => context.go('/login');

  void _onNextPressed() {
    if (_currentPage == _slides.length - 1) {
      _goToLogin();
      return;
    }
    _pageController.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    final isLastPage = _currentPage == _slides.length - 1;

    return AuthScreenScaffold(
      child: Column(
        children: [
          const SizedBox(height: 8),
          Align(
            alignment: Alignment.topRight,
            child: TextButton(
              onPressed: _goToLogin,
              child: const Text('Skip'),
            ),
          ),
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              itemCount: _slides.length,
              onPageChanged: (index) => setState(() => _currentPage = index),
              itemBuilder: (context, index) {
                final slide = _slides[index];
                return OnboardingSlide(
                  imagePath: slide.image,
                  title: slide.title,
                  description: slide.description,
                );
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              _slides.length,
              (index) => AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                margin: const EdgeInsets.symmetric(horizontal: 4),
                height: 8,
                width: index == _currentPage ? 24 : 8,
                decoration: BoxDecoration(
                  color: index == _currentPage
                      ? AppColors.accent
                      : AppColors.border,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
          ),
          const SizedBox(height: 24),
          AuthButton(
            label: isLastPage ? 'Get Started' : 'Suivant',
            onPressed: _onNextPressed,
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
