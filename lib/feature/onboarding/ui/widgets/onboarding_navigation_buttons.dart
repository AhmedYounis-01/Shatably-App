import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shatably_app/core/themes/colors_manager.dart';
import 'package:shatably_app/core/themes/text_styles.dart';
import 'package:shatably_app/core/utils/app_icons.dart';
import 'package:shatably_app/core/widgets/custom_app_button.dart';
import 'package:shatably_app/core/widgets/custom_app_button1.dart';

class OnboardingNavigationButtons extends StatelessWidget {
  final bool isLastPage;
  final VoidCallback onSkip;
  final VoidCallback onNext;
  final AnimationController buttonController;
  final Animation<double> buttonScaleAnimation;

  const OnboardingNavigationButtons({
    super.key,
    required this.isLastPage,
    required this.onSkip,
    required this.onNext,
    required this.buttonController,
    required this.buttonScaleAnimation,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: buttonController,
      builder: (context, child) {
        return Transform.scale(
          scale: buttonScaleAnimation.value,
          child: FadeTransition(
            opacity: Tween<double>(begin: 0.0, end: 1.0).animate(
              CurvedAnimation(
                parent: buttonController,
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
                              duration: const Duration(milliseconds: 300),
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
                                    onPressed: onSkip,
                                  ),
                                );
                              },
                            ),
                          )
                          : Row(
                            key: const ValueKey('navigation_buttons'),
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // Skip Button with hover animation
                              TweenAnimationBuilder<double>(
                                duration: const Duration(milliseconds: 200),
                                tween: Tween(begin: 1.0, end: 1.0),
                                builder: (context, scale, child) {
                                  return Transform.scale(
                                    scale: scale,
                                    child: TextButton(
                                      onPressed: onSkip,
                                      style: TextButton.styleFrom(
                                        foregroundColor: Colors.grey,
                                        overlayColor: Colors.grey.withAlpha(
                                          (0.1 * 255).toInt(),
                                        ),
                                      ),
                                      child: Text(
                                        'Skip',
                                        style: TextStyles.styleRegular(
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
                                duration: const Duration(milliseconds: 1500),
                                tween: Tween(begin: 1.0, end: 1.05),
                                builder: (context, scale, child) {
                                  return Transform.scale(
                                    scale: scale,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                          25.r,
                                        ),
                                        boxShadow: [
                                          BoxShadow(
                                            color: ColorsManager.primaryColor
                                                .withAlpha(
                                                  (0.10 * 255).toInt(),
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
                                        child: TweenAnimationBuilder<double>(
                                          duration: const Duration(
                                            milliseconds: 300,
                                          ),
                                          tween: Tween(begin: 0.0, end: 1.0),
                                          builder: (context, value, child) {
                                            return Transform.translate(
                                              offset: Offset(value * 2, 0),
                                              child: SvgPicture.asset(
                                                AppIcons.arrowIcon,
                                                width: 18.w,
                                                height: 12.h,
                                              ),
                                            );
                                          },
                                        ),
                                        onPressed: onNext,
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
    );
  }
}
