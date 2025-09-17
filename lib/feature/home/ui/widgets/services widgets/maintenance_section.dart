import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shatably_app/core/themes/colors_manager.dart';
import 'package:shatably_app/core/themes/text_styles.dart';
import 'package:shatably_app/core/utils/app_icons.dart';
import 'package:shatably_app/feature/maintenance%20work/ui/maintenance_work_screen.dart';

class MaintenanceSection extends StatelessWidget {
  const MaintenanceSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 18.h),
        Text(
          'Maintenance Work',
          style: TextStyles.styleSemiBold(
            context,
            fontSize: 14.sp,
            color: ColorsManager.primaryColor,
          ),
        ),
        SizedBox(height: 12.h),
        Wrap(
          spacing: 18.w,
          runSpacing: 18.h,
          children: const [
            MaintenanceItem(
              title: 'HVAC',
              icon: AppIcons.takyeefIcon,
              id: 'd893e691-1ee6-40d6-98b9-c46f4ab9b120',
            ),
            MaintenanceItem(
              title: 'Windows & Doors',
              icon: AppIcons.windowIcon,
              id: 'd893e691-1ee6-40d6-98b9-c46f4ab9b120',
            ),
            MaintenanceItem(
              title: 'Pest Control',
              icon: AppIcons.pestControlIcon,
              id: 'd8834625-486c-4471-8c06-557f41b1cf8d',
            ),
            MaintenanceItem(
              title: 'Water Purifier',
              icon: AppIcons.waterFilterIcon,
              id: '62b5bf31-8b8c-438a-8030-f5fd437bb354',
            ),
            MaintenanceItem(
              title: 'Surveillance Cameras',
              icon: AppIcons.surveillanceCameraIcon,
              id: '3d8ae543-7aaa-460d-b8a5-3e56dd55245e',
            ),
          ],
        ),
        SizedBox(height: 50.h),
      ],
    );
  }
}

class MaintenanceItem extends StatelessWidget {
  const MaintenanceItem({
    super.key,
    required this.title,
    required this.icon,
    required this.id,
  });

  final String title;
  final String icon;
  final String id;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context, rootNavigator: false).push(
          MaterialPageRoute(
            builder: (context) => MaintenanceWorkScreen(serviceId: id),
          ),
        );
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
