import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../src/routing/routes.dart';
import '../../../../../src/themes/app_colors.dart';
import '../../../../../src/themes/app_theme.dart';
import '../widgets/onboarding_bottom_card.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  final List<_OnboardingData> _pages = [
    const _OnboardingData(
      image: 'assets/images/onboard1.png',
      title: 'Step into the Future\n of Your Fashion',
      description:
          'Discover the latest trends and express your unique style with our\nexclusive fashion collections.',
    ),
    const _OnboardingData(
      image: 'assets/images/onboard2.png',
      title: 'Get your best Clothes\n with our store',
      description:
          'Find the perfect outfit for every occasion.\n Shop top-quality clothes and enjoy a seamless experience.',
    ),
    const _OnboardingData(
      image: 'assets/images/onboard3.png',
      title: 'All Your Clothes You Need\n with our store',
      description:
          'Everything you need for your wardrobe\n in one place. Fast delivery and secure shopping guaranteed.',
    ),
  ];
  late SharedPreferences prefs;
  Future<void> _initPreferencesAndNavigate() async {
    prefs = await SharedPreferences.getInstance();

    final seenOnboarding = prefs.getBool('isShowOnBoarding');
    print(" seenOnboardingseenOnboardingseenOnboarding${seenOnboarding}");
    if (seenOnboarding == true) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _navigateToLogin();
      });
    } else {
      await prefs.setBool('isShowOnBoarding', true);
    }
  }

  void _nextPage() {
    if (_currentIndex < _pages.length - 1) {
      _pageController.nextPage(
          duration: const Duration(milliseconds: 400), curve: Curves.ease);
    }
  }

  void _navigateToLogin() {
    context.push(Routes.login);
  }

  void _prevPage() {
    if (_currentIndex > 0) {
      _pageController.previousPage(
          duration: const Duration(milliseconds: 400), curve: Curves.ease);
    }
  }

  void _skip() {
    context.push(Routes.login);
  }

  void _getStarted() {
    context.push(Routes.dashboard);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initPreferencesAndNavigate();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: PageView.builder(
        controller: _pageController,
        itemCount: _pages.length,
        onPageChanged: (index) => setState(() => _currentIndex = index),
        itemBuilder: (context, index) {
          final data = _pages[index];
          return Stack(
            children: [
              SizedBox(
                width: size.width,
                height: size.height,
                child: Image.asset(
                  data.image,
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                width: size.width,
                height: size.height,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black.withOpacity(0.5),
                      Colors.black.withOpacity(0.8),
                    ],
                    stops: const [0.0, 0.6, 1.0],
                  ),
                ),
              ),
              if (_currentIndex != _pages.length - 1)
                Positioned(
                  top: size.height * 0.1,
                  right: size.width * 0.1,
                  child: GestureDetector(
                    onTap: _skip,
                    child: Text(
                      'Skip',
                      style: textTheme.labelLarge!.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        shadows: const [
                          Shadow(blurRadius: 4, color: Colors.black26)
                        ],
                      ),
                    ),
                  ),
                ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: OnboardingBottomCard(
                  title: data.title,
                  description: data.description,
                  currentIndex: _currentIndex,
                  totalPages: _pages.length,
                  onNext: _currentIndex < _pages.length - 1 ? _nextPage : null,
                  onPrev: _currentIndex > 0 ? _prevPage : null,
                  onGetStarted:
                      _currentIndex == _pages.length - 1 ? _getStarted : null,
                  noMargin: true,
                  titleStyle: textTheme.displayMedium!.copyWith(
                    color: AppColors.black.withOpacity(0.5),
                    height: 1.5,
                    letterSpacing: 0.0,
                  ),
                  descriptionStyle: textTheme.bodyLarge!.copyWith(
                    color: AppColors.black.withOpacity(0.5),
                    height: 1.4,
                    letterSpacing: 0.0,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _OnboardingData {
  final String image;
  final String title;
  final String description;
  const _OnboardingData(
      {required this.image, required this.title, required this.description});
}
