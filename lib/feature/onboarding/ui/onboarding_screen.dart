import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:logger/logger.dart';
import 'package:shatably_app/core/helpers/cache/storage_manager.dart';
import 'package:shatably_app/core/helpers/extensions.dart';
import 'package:shatably_app/core/routes/routes.dart';
import 'package:shatably_app/feature/onboarding/ui/widgets/onboarding_navigation_buttons.dart';
import 'package:shatably_app/feature/onboarding/ui/widgets/onboarding_page_item.dart';
import '../data/models/onboarding_item.dart';
import 'package:shatably_app/core/utils/app_images.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  OnboardingScreenState createState() => OnboardingScreenState();
}

class OnboardingScreenState extends State<OnboardingScreen>
    with TickerProviderStateMixin {
  final List<OnboardingItem> onboardingItems = [
    OnboardingItem(
      title: 'Find experts for carpentry, electrical work, and more!',
      description:
          'Hire skilled professionals for carpentry, electrical repairs, plumbing, painting, and all your home maintenance needs!',
      imagePath: AppImages.onboarding1,
    ),
    OnboardingItem(
      title: 'Craftsmen can browse and take on new projects.',
      description:
          'Browse job listings, apply for projects, and connect with clients to expand your work opportunities!',
      imagePath: AppImages.onboarding2,
    ),
    OnboardingItem(
      title: 'Craftsmen can browse and take on new projects.',
      description:
          'Browse job listings, apply for projects, and connect with clients to expand your work opportunities!',
      imagePath: AppImages.onboarding3,
    ),
  ];

  final PageController pageController = PageController();
  bool isLastPage = false;

  // Animation controllers
  late AnimationController _fadeController;
  late AnimationController _slideController;
  late AnimationController _scaleController;
  late AnimationController _buttonController;

  // Animations
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<double> _buttonScaleAnimation;

  @override
  void initState() {
    super.initState();

    // Initialize animation controllers
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _slideController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    _buttonController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    // Initialize animations
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeInOut),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _slideController, curve: Curves.elasticOut),
    );

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _scaleController, curve: Curves.bounceOut),
    );

    _buttonScaleAnimation = Tween<double>(begin: 0.9, end: 1.0).animate(
      CurvedAnimation(parent: _buttonController, curve: Curves.elasticOut),
    );

    // Start initial animations
    _startAnimations();
  }

  void _startAnimations() {
    _fadeController.forward();
    Future.delayed(const Duration(milliseconds: 200), () {
      _slideController.forward();
    });
    Future.delayed(const Duration(milliseconds: 400), () {
      _scaleController.forward();
    });
    Future.delayed(const Duration(milliseconds: 600), () {
      _buttonController.forward();
    });
  }

  void _resetAnimations() {
    _fadeController.reset();
    _slideController.reset();
    _scaleController.reset();
    _buttonController.reset();
    _startAnimations();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _slideController.dispose();
    _scaleController.dispose();
    _buttonController.dispose();
    pageController.dispose();
    super.dispose();
  }

  void submitOnboarding() {
    StorageManager.instance.setHasSeenOnboarding();
    context.pushReplacementNamed(Routes.typeScreen);
    Logger().i('Onboarding Done');
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
    );
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20.w),
          child: Column(
            children: [
              Expanded(
                flex: 8,
                child: PageView.builder(
                  controller: pageController,
                  itemCount: onboardingItems.length,
                  onPageChanged: (index) {
                    setState(() {
                      isLastPage = index == onboardingItems.length - 1;
                    });
                    _resetAnimations();
                  },
                  itemBuilder: (context, index) {
                    return OnboardingPageItem(
                      onboardingItem: onboardingItems[index],
                      index: index,
                      itemCount: onboardingItems.length,
                      pageController: pageController,
                      fadeAnimation: _fadeAnimation,
                      slideAnimation: _slideAnimation,
                      scaleAnimation: _scaleAnimation,
                      fadeController: _fadeController,
                      slideController: _slideController,
                    );
                  },
                ),
              ),

              const Spacer(),

              OnboardingNavigationButtons(
                isLastPage: isLastPage,
                onSkip: submitOnboarding,
                onNext: () {
                  if (isLastPage) {
                    submitOnboarding();
                  } else {
                    pageController.nextPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeIn,
                    );
                  }
                },
                buttonController: _buttonController,
                buttonScaleAnimation: _buttonScaleAnimation,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
