import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:logger/logger.dart';
import 'package:shatably_app/core/helpers/cache/storage_manager.dart';
import 'package:shatably_app/core/helpers/extensions.dart';
import 'package:shatably_app/core/routes/routes.dart';
import 'package:shatably_app/core/themes/colors_manager.dart';
import 'package:shatably_app/core/utils/app_icons.dart';
import 'package:shatably_app/core/utils/app_images.dart';
import 'package:shatably_app/core/widgets/custom_app_button.dart';
import 'package:shatably_app/core/widgets/custom_app_button1.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../../core/themes/text_styles.dart';
import '../data/models/onboarding_item.dart';

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
    super.dispose();
  }

  void submitOnboarding() {
    StorageManager.instance.setHasSeenOnboarding();
    context.pushReplacementNamed(Routes.typeScreen);
    Logger().i('Onboarding Done');
  }

  @override
  Widget build(BuildContext context) {
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
                    return Padding(
                      padding: EdgeInsets.only(top: 100.h),
                      child: Column(
                        children: [
                          // Animated Image
                          AnimatedBuilder(
                            animation: _scaleAnimation,
                            builder: (context, child) {
                              return Transform.scale(
                                scale: _scaleAnimation.value,
                                child: FadeTransition(
                                  opacity: _fadeAnimation,
                                  child: Hero(
                                    tag: 'onboarding_image_$index',
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                          20.r,
                                        ),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black.withAlpha(
                                              (0.02 * 255).toInt(),
                                            ),
                                            blurRadius: 20,
                                            offset: const Offset(0, 10),
                                          ),
                                        ],
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(
                                          20.r,
                                        ),
                                        child: Image.asset(
                                          width: 383.w,
                                          height: 241.h,
                                          onboardingItems[index].imagePath,
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),

                          SizedBox(height: 27.h),

                          // Animated Title
                          SlideTransition(
                            position: _slideAnimation,
                            child: FadeTransition(
                              opacity: _fadeAnimation,
                              child: AnimatedDefaultTextStyle(
                                duration: const Duration(milliseconds: 300),
                                style: TextStyles.styleMedium(
                                  context,
                                  fontSize: 24.sp,
                                  fontFamily: "Inter_24pt",
                                ),
                                child: Text(
                                  onboardingItems[index].title,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),

                          SizedBox(height: 8.h),

                          // Animated Description
                          SlideTransition(
                            position: Tween<Offset>(
                              begin: const Offset(0, 0.5),
                              end: Offset.zero,
                            ).animate(
                              CurvedAnimation(
                                parent: _slideController,
                                curve: const Interval(
                                  0.3,
                                  1.0,
                                  curve: Curves.easeOut,
                                ),
                              ),
                            ),
                            child: FadeTransition(
                              opacity: Tween<double>(
                                begin: 0.0,
                                end: 1.0,
                              ).animate(
                                CurvedAnimation(
                                  parent: _fadeController,
                                  curve: const Interval(0.4, 1.0),
                                ),
                              ),
                              child: Container(
                                margin: EdgeInsets.symmetric(horizontal: 40.w),
                                child: AnimatedDefaultTextStyle(
                                  duration: const Duration(milliseconds: 300),
                                  style: TextStyles.styleRegular(
                                    context,
                                    fontSize: 13.sp,
                                  ),
                                  child: Text(
                                    onboardingItems[index].description,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ),
                          ),

                          SizedBox(height: 35.h),

                          // Animated Page Indicator
                          SlideTransition(
                            position: Tween<Offset>(
                              begin: const Offset(0, 1.0),
                              end: Offset.zero,
                            ).animate(
                              CurvedAnimation(
                                parent: _slideController,
                                curve: const Interval(
                                  0.6,
                                  1.0,
                                  curve: Curves.bounceOut,
                                ),
                              ),
                            ),
                            child: AnimatedSmoothIndicator(
                              activeIndex:
                                  pageController.hasClients
                                      ? pageController.page?.round() ?? 0
                                      : 0,
                              count: onboardingItems.length,
                              effect: SlideEffect(
                                activeDotColor: const Color(0xffDDA853),
                                dotColor: const Color(0xffDDA853).withAlpha(51),
                                dotHeight: 10.h,
                                dotWidth: 10.w,
                                spacing: 10.w,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),

              const Spacer(),

              // Animated Bottom Section
              AnimatedBuilder(
                animation: _buttonController,
                builder: (context, child) {
                  return Transform.scale(
                    scale: _buttonScaleAnimation.value,
                    child: FadeTransition(
                      opacity: Tween<double>(begin: 0.0, end: 1.0).animate(
                        CurvedAnimation(
                          parent: _buttonController,
                          curve: Curves.easeInOut,
                        ),
                      ),
                      child: Column(
                        children: [
                          AnimatedSwitcher(
                            duration: const Duration(milliseconds: 500),
                            transitionBuilder: (
                              Widget child,
                              Animation<double> animation,
                            ) {
                              return FadeTransition(
                                opacity: animation,
                                child: SlideTransition(
                                  position: Tween<Offset>(
                                    begin: const Offset(0, 0.3),
                                    end: Offset.zero,
                                  ).animate(animation),
                                  child: child,
                                ),
                              );
                            },
                            child:
                                isLastPage
                                    ? Center(
                                      key: const ValueKey('last_page_button'),
                                      child: TweenAnimationBuilder<double>(
                                        duration: const Duration(
                                          milliseconds: 300,
                                        ),
                                        tween: Tween(begin: 0.95, end: 1.0),
                                        builder: (context, scale, child) {
                                          return Transform.scale(
                                            scale: scale,
                                            child: CustomAppButton(
                                              width: 145.w,
                                              height: 48.h,
                                              borderRadius: 50,
                                              child: Text(
                                                "Let's Start",
                                                style: TextStyles.styleSemiBold(
                                                  context,
                                                  fontSize: 14.sp,
                                                  color: Colors.white,
                                                ),
                                              ),
                                              onPressed: () {
                                                submitOnboarding();
                                              },
                                            ),
                                          );
                                        },
                                      ),
                                    )
                                    : Row(
                                      key: const ValueKey('navigation_buttons'),
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        // Skip Button with hover animation
                                        TweenAnimationBuilder<double>(
                                          duration: const Duration(
                                            milliseconds: 200,
                                          ),
                                          tween: Tween(begin: 1.0, end: 1.0),
                                          builder: (context, scale, child) {
                                            return Transform.scale(
                                              scale: scale,
                                              child: TextButton(
                                                onPressed: () {
                                                  submitOnboarding();
                                                },
                                                style: TextButton.styleFrom(
                                                  foregroundColor: Colors.grey,
                                                  overlayColor: Colors.grey
                                                      .withAlpha(
                                                        (0.1 * 255).toInt(),
                                                      ),
                                                ),
                                                child: Text(
                                                  'Skip',
                                                  style:
                                                      TextStyles.styleRegular(
                                                        context,
                                                        fontSize: 14.sp,
                                                      ),
                                                ),
                                              ),
                                            );
                                          },
                                        ),

                                        // Next Button with pulse animation
                                        TweenAnimationBuilder<double>(
                                          duration: const Duration(
                                            milliseconds: 1500,
                                          ),
                                          tween: Tween(begin: 1.0, end: 1.05),
                                          builder: (context, scale, child) {
                                            return Transform.scale(
                                              scale: scale,
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                        25.r,
                                                      ),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: ColorsManager
                                                          .primaryColor
                                                          .withAlpha(
                                                            (0.10 * 255)
                                                                .toInt(),
                                                          ),
                                                      blurRadius: 10,
                                                      spreadRadius: 2,
                                                    ),
                                                  ],
                                                ),
                                                child: CustomAppButton1(
                                                  width: 50.w,
                                                  height: 50.h,
                                                  isCircular: true,
                                                  child: TweenAnimationBuilder<
                                                    double
                                                  >(
                                                    duration: const Duration(
                                                      milliseconds: 300,
                                                    ),
                                                    tween: Tween(
                                                      begin: 0.0,
                                                      end: 1.0,
                                                    ),
                                                    builder: (
                                                      context,
                                                      value,
                                                      child,
                                                    ) {
                                                      return Transform.translate(
                                                        offset: Offset(
                                                          value * 2,
                                                          0,
                                                        ),
                                                        child: SvgPicture.asset(
                                                          AppIcons.arrowIcon,
                                                          width: 18.w,
                                                          height: 12.h,
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                  onPressed: () {
                                                    if (isLastPage) {
                                                      submitOnboarding();
                                                    } else {
                                                      pageController.nextPage(
                                                        duration:
                                                            const Duration(
                                                              milliseconds: 300,
                                                            ),
                                                        curve: Curves.easeIn,
                                                      );
                                                    }
                                                  },
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
