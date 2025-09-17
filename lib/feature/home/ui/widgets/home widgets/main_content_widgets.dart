import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shatably_app/core/themes/colors_manager.dart';
import 'package:shatably_app/core/utils/app_images.dart';
import 'package:shatably_app/core/themes/text_styles.dart';
import 'package:shatably_app/feature/home/ui/widgets/home widgets/services_section_widgets.dart';
import 'package:shatably_app/feature/home/ui/widgets/home widgets/projects_section_widgets.dart';

// Main Content Section Widget
class MainContentSection extends StatelessWidget {
  const MainContentSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),
          const TimelessOfferSection(),
          const SizedBox(height: 24),
          const TrendingServicesSection(),
          SizedBox(height: 20.h),
          const ExploreProjectsSection(),
          SizedBox(height: 40.h),
        ],
      ),
    );
  }
}

// Timeless Offer Section Widget
class TimelessOfferSection extends StatelessWidget {
  const TimelessOfferSection({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [TimelessOfferHeader(), SizedBox(height: 16), PromotionCard()],
    );
  }
}

// Timeless Offer Header Widget
class TimelessOfferHeader extends StatelessWidget {
  const TimelessOfferHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Timeless offer',
          style: TextStyles.styleRegular(
            context,
            fontSize: 14.sp,
            color: ColorsManager.primaryColor,
          ),
        ),
        Text(
          '18:32:14 h',
          style: TextStyles.styleRegular(
            context,
            fontSize: 12.sp,
            color: ColorsManager.yellowTextColor,
          ),
        ),
      ],
    );
  }
}

// Promotion Card Widget
class PromotionCard extends StatelessWidget {
  const PromotionCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFF0B4A6F),
            borderRadius: BorderRadius.circular(16),
          ),
          child: const Row(
            children: [
              PromotionCardContent(),
              Expanded(flex: 2, child: SizedBox()),
            ],
          ),
        ),
        const PromotionCardBackground(),
        const PromotionCardImage(),
      ],
    );
  }
}

// Promotion Card Content Widget
class PromotionCardContent extends StatelessWidget {
  const PromotionCardContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 3,
      child: Padding(
        padding: EdgeInsetsDirectional.only(
          top: 16.h,
          start: 13.w,
          bottom: 18.h,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  '25% ',
                  style: TextStyles.styleMedium(
                    context,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                    color: ColorsManager.yellowTextColor,
                  ),
                ),
                Icon(
                  Icons.local_fire_department,
                  color: ColorsManager.yellowTextColor,
                ),
              ],
            ),
            SizedBox(height: 20.h),
            Text(
              'Today\'s special!',
              style: TextStyles.styleBold(
                context,
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              'Get discount for every\nservice,only valid for today',
              style: TextStyles.styleRegular(
                context,
                fontSize: 13.sp,
                color: Colors.white.withAlpha((0.25 * 255).toInt()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Promotion Card Background Widget
class PromotionCardBackground extends StatelessWidget {
  const PromotionCardBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 0,
      bottom: 0,
      child: ClipRRect(
        borderRadius: const BorderRadius.only(bottomRight: Radius.circular(16)),
        child: Image.asset(
          AppImages.homeBackgroundImage,
          width: MediaQuery.of(context).size.width * 0.4,
          height: 120.h,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

// Promotion Card Image Widget
class PromotionCardImage extends StatelessWidget {
  const PromotionCardImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 0,
      bottom: 0,
      child: Image.asset(
        AppImages.plumberImage,
        width: MediaQuery.of(context).size.width * 0.4,
        height: 180.h,
        fit: BoxFit.contain,
      ),
    );
  }
}
