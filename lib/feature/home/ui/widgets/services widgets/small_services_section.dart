import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shatably_app/core/themes/colors_manager.dart';
import 'package:shatably_app/core/themes/text_styles.dart';
import 'package:shatably_app/core/utils/app_icons.dart';
import 'package:shatably_app/feature/services/ui/screens/carpentry_screen.dart';
import 'package:shatably_app/feature/services/ui/screens/cleaning_screen.dart';
import 'package:shatably_app/feature/services/ui/screens/electrician_screen.dart';
import 'package:shatably_app/feature/services/ui/screens/painting_screen.dart';
import 'package:shatably_app/feature/services/ui/screens/plumbing_screen.dart';

class SmallServicesSection extends StatelessWidget {
  const SmallServicesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 18.h),
        Text(
          'Small Services',
          style: TextStyles.styleSemiBold(
            context,
            fontSize: 14.sp,
            color: ColorsManager.primaryColor,
          ),
        ),
        SizedBox(height: 11.h),
        Wrap(
          spacing: 18.w,
          runSpacing: 18.h,
          children: const [
            SmallServiceItem(
              title: 'Electrician',
              icon: AppIcons.electricianIcon,
              destination: ElectricianServiceScreen(),
            ),
            SmallServiceItem(
              title: 'Carpentry',
              icon: AppIcons.carpenterIcon,
              destination: CarpentryServiceScreen(),
            ),
            SmallServiceItem(
              title: 'Painter',
              icon: AppIcons.painterIcon,
              destination: PaintingServiceScreen(),
            ),
            SmallServiceItem(
              title: 'Plumber',
              icon: AppIcons.lastPlumingIcon,
              destination: PlumbingServiceScreen(),
            ),
            SmallServiceItem(
              title: 'Cleaning',
              icon: AppIcons.housekeepingIcon,
              destination: CleaningServiceScreen(),
            ),
          ],
        ),
      ],
    );
  }
}

class SmallServiceItem extends StatelessWidget {
  const SmallServiceItem({
    super.key,
    required this.title,
    required this.icon,
    required this.destination,
  });

  final String title;
  final String icon;
  final Widget destination;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(
          context,
          rootNavigator: false,
        ).push(MaterialPageRoute(builder: (context) => destination));
      },
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
                child: SvgPicture.asset(icon, width: 26.w, height: 26.h),
              ),
              SizedBox(height: 2.h),
              Text(
                textAlign: TextAlign.center,
                title,
                style: TextStyles.styleRegular(
                  context,
                  fontSize: 12,
                  color: ColorsManager.primaryColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
