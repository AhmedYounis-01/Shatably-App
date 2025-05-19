import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shatably_app/core/localization/localization_extension.dart';
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

class OnboardingScreenState extends State<OnboardingScreen> {
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

  void submitOnboarding() {
    // CacheHelper.saveData(key: Constant.onboardingSeen, value: true);
    // context.pushReplacementNamed(Routes.loginScreen);
    // Logger().i('Onboarding Done');
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
                flex: 4,
                child: PageView.builder(
                  controller: pageController,
                  itemCount: onboardingItems.length,
                  onPageChanged: (index) {
                    setState(() {
                      isLastPage = index == onboardingItems.length - 1;
                    });
                  },
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.only(top: 100.h),
                      child: Column(
                        children: [
                          Image.asset(
                            width: 383.w,
                            height: 241.h,
                            onboardingItems[index].imagePath,
                            fit: BoxFit.contain,
                          ),
                          SizedBox(height: 27.h),
                          Text(
                            onboardingItems[index].title.t(context),
                            textAlign: TextAlign.center,
                            style: TextStyles.styleMedium(
                              context,
                              fontSize: 24.sp,
                              fontFamily: "Inter_24pt",
                            ),
                          ),
                          SizedBox(height: 8.h),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 40.w),
                            child: Text(
                              onboardingItems[index].description.t(context),
                              textAlign: TextAlign.center,
                              style: TextStyles.styleRegular(
                                context,
                                fontSize: 13.sp,
                              ),
                            ),
                          ),
                          SizedBox(height: 35.h),
                          SmoothPageIndicator(
                            controller: pageController,
                            count: onboardingItems.length,
                            effect: SlideEffect(
                              activeDotColor: Color(0xffDDA853),
                              dotColor: Color(0xffDDA853).withAlpha(51),
                              dotHeight: 10.h,
                              dotWidth: 10.w,
                              spacing: 10.w,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),

              Spacer(),
              Column(
                children: [
                  if (isLastPage)
                    Center(
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
                    )
                  else
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          onPressed: () {
                            submitOnboarding();
                          },
                          child: Text(
                            'Skip',
                            style: TextStyles.styleRegular(
                              context,
                              fontSize: 14.sp,
                            ),
                          ),
                        ),
                        CustomAppButton1(
                          width: 50.w,
                          height: 50.h,
                          isCircular: true,
                          child: SvgPicture.asset(
                            AppIcons.arrowIcon,
                            width: 18.w,
                            height: 12.h,
                          ),
                          onPressed: () {
                            if (isLastPage) {
                              submitOnboarding();
                            } else {
                              pageController.nextPage(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeIn,
                              );
                            }
                          },
                        ),
                      ],
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
