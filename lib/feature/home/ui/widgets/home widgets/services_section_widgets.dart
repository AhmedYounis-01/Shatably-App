import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shatably_app/core/themes/colors_manager.dart';
import 'package:shatably_app/core/utils/app_icons.dart';
import 'package:shatably_app/core/themes/text_styles.dart';
import 'package:shatably_app/feature/home/ui/screens/browse_services_screen.dart';
import 'package:shatably_app/feature/services/ui/screens/carpentry_screen.dart';
import 'package:shatably_app/feature/services/ui/screens/cleaning_screen.dart';
import 'package:shatably_app/feature/services/ui/screens/electrician_screen.dart';
import 'package:shatably_app/feature/services/ui/screens/painting_screen.dart';
import 'package:shatably_app/feature/services/ui/screens/plumbing_screen.dart';

// Trending Services Section Widget
class TrendingServicesSection extends StatelessWidget {
  const TrendingServicesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const TrendingServicesHeader(),
        const SizedBox(height: 16),
        SizedBox(
          height: 95,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: ServiceCategories.trending.length,
            separatorBuilder: (context, index) => const SizedBox(width: 12),
            itemBuilder: (context, index) {
              final service = ServiceCategories.trending[index];
              return ServiceCategoryCard(
                title: service.title,
                imagePath: service.imagePath,
                onTap: () => service.navigate(context),
              );
            },
          ),
        ),
      ],
    );
  }
}

// Trending Services Header Widget
class TrendingServicesHeader extends StatelessWidget {
  const TrendingServicesHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Trending Services',
          style: TextStyles.styleRegular(
            context,
            fontSize: 14.sp,
            color: ColorsManager.primaryColor,
          ),
        ),
        InkWell(
          onTap: () => navigateToBrowseServices(context),
          child: Text(
            'View all',
            style: TextStyles.styleRegular(
              context,
              fontSize: 12.sp,
              color: ColorsManager.yellowTextColor,
            ),
          ),
        ),
      ],
    );
  }

  void navigateToBrowseServices(BuildContext context) {
    Navigator.of(context, rootNavigator: false).push(
      MaterialPageRoute(builder: (context) => const BrowseServicesScreen()),
    );
  }
}

// Service Category Card Widget
class ServiceCategoryCard extends StatelessWidget {
  const ServiceCategoryCard({
    super.key,
    required this.title,
    required this.imagePath,
    required this.onTap,
  });

  final String title;
  final String imagePath;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 95,
        height: 95,
        decoration: BoxDecoration(
          color: const Color(0XFFE5E3DB),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withAlpha((0.1 * 255).toInt()),
              spreadRadius: 1,
              blurRadius: 2,
            ),
          ],
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundColor: Colors.white,
                child: SvgPicture.asset(
                  imagePath,
                  width: 26.w,
                  height: 26.h,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 3),
              Text(title),
            ],
          ),
        ),
      ),
    );
  }
}

// Data Models and Constants
class ServiceCategory {
  final String title;
  final String imagePath;
  final void Function(BuildContext) navigate;

  const ServiceCategory({
    required this.title,
    required this.imagePath,
    required this.navigate,
  });
}

// Service Categories Data
class ServiceCategories {
  static List<ServiceCategory> get trending => [
    ServiceCategory(
      title: 'Electrician',
      imagePath: AppIcons.electricianIcon,
      navigate:
          (context) => Navigator.of(context, rootNavigator: false).push(
            MaterialPageRoute(
              builder: (context) => const ElectricianServiceScreen(),
            ),
          ),
    ),
    ServiceCategory(
      title: 'Carpenter',
      imagePath: AppIcons.carpenterIcon,
      navigate:
          (context) => Navigator.of(context, rootNavigator: false).push(
            MaterialPageRoute(
              builder: (context) => const CarpentryServiceScreen(),
            ),
          ),
    ),
    ServiceCategory(
      title: 'Painter',
      imagePath: AppIcons.painterIcon,
      navigate:
          (context) => Navigator.of(context, rootNavigator: false).push(
            MaterialPageRoute(
              builder: (context) => const PaintingServiceScreen(),
            ),
          ),
    ),
    ServiceCategory(
      title: 'Plumber',
      imagePath: AppIcons.lastPlumingIcon,
      navigate:
          (context) => Navigator.of(context, rootNavigator: false).push(
            MaterialPageRoute(
              builder: (context) => const PlumbingServiceScreen(),
            ),
          ),
    ),
    ServiceCategory(
      title: 'Cleaning',
      imagePath: AppIcons.housekeepingIcon,
      navigate:
          (context) => Navigator.of(context, rootNavigator: false).push(
            MaterialPageRoute(
              builder: (context) => const CleaningServiceScreen(),
            ),
          ),
    ),
  ];
}
