import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:shatably_app/core/themes/text_styles.dart';
import '../../data/models/onboarding_item.dart';

class OnboardingPageItem extends StatelessWidget {
  final OnboardingItem onboardingItem;
  final int index;
  final int itemCount;
  final PageController pageController;
  final Animation<double> fadeAnimation;
  final Animation<Offset> slideAnimation;
  final Animation<double> scaleAnimation;
  final AnimationController fadeController;
  final AnimationController slideController;

  const OnboardingPageItem({
    super.key,
    required this.onboardingItem,
    required this.index,
    required this.itemCount,
    required this.pageController,
    required this.fadeAnimation,
    required this.slideAnimation,
    required this.scaleAnimation,
    required this.fadeController,
    required this.slideController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Top spacing - flexible
        const Spacer(flex: 2),

        // Animated Image - flexible to shrink if needed
        Flexible(
          flex: 8,
          child: AnimatedBuilder(
            animation: scaleAnimation,
            builder: (context, child) {
              return Transform.scale(
                scale: scaleAnimation.value,
                child: FadeTransition(
                  opacity: fadeAnimation,
                  child: Hero(
                    tag: 'onboarding_image_$index',
                    child: Container(
                      constraints: BoxConstraints(
                        maxWidth: 383.w,
                        maxHeight: 241.h,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.r),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withAlpha((0.02 * 255).toInt()),
                            blurRadius: 20,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20.r),
                        child: Image.asset(
                          onboardingItem.imagePath,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),

        const Spacer(flex: 1),

        // Animated Title
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: SlideTransition(
            position: slideAnimation,
            child: FadeTransition(
              opacity: fadeAnimation,
              child: AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 300),
                style: TextStyles.styleMedium(
                  context,
                  fontSize: 24.sp,
                  fontFamily: "Inter_24pt",
                ),
                child: Text(
                  onboardingItem.title,
                  textAlign: TextAlign.center,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ),
        ),

        SizedBox(height: 8.h),

        // Animated Description
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 40.w),
          child: SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0, 0.5),
              end: Offset.zero,
            ).animate(
              CurvedAnimation(
                parent: slideController,
                curve: const Interval(0.3, 1.0, curve: Curves.easeOut),
              ),
            ),
            child: FadeTransition(
              opacity: Tween<double>(begin: 0.0, end: 1.0).animate(
                CurvedAnimation(
                  parent: fadeController,
                  curve: const Interval(0.4, 1.0),
                ),
              ),
              child: AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 300),
                style: TextStyles.styleRegular(context, fontSize: 13.sp),
                child: Text(
                  onboardingItem.description,
                  textAlign: TextAlign.center,
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ),
        ),

        const Spacer(flex: 1),

        // Animated Page Indicator
        SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0, 1.0),
            end: Offset.zero,
          ).animate(
            CurvedAnimation(
              parent: slideController,
              curve: const Interval(0.6, 1.0, curve: Curves.bounceOut),
            ),
          ),
          child: AnimatedSmoothIndicator(
            activeIndex:
                pageController.hasClients
                    ? pageController.page?.round() ?? 0
                    : 0,
            count: itemCount,
            effect: SlideEffect(
              activeDotColor: const Color(0xffDDA853),
              dotColor: const Color(0xffDDA853).withAlpha(51),
              dotHeight: 10.h,
              dotWidth: 10.w,
              spacing: 10.w,
            ),
          ),
        ),

        const Spacer(flex: 1),
      ],
    );
  }
}
