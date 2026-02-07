import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shatably_app/core/themes/colors_manager.dart';
import 'package:shatably_app/core/themes/text_styles.dart';
import 'package:shatably_app/core/utils/app_icons.dart';
import 'package:shatably_app/core/utils/app_images.dart';

class LocationCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final VoidCallback? onTap;

  const LocationCard({
    super.key,
    required this.title,
    required this.subtitle,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: const Color(0XFFF7FCFB),
          borderRadius: BorderRadius.circular(15.r),
          border: Border.all(color: const Color(0xFFA6CDC6), width: 1),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha((0.25 * 255).toInt()),
              blurRadius: 4,
            ),
          ],
        ),
        child: Row(
          children: [
            // Map Icon Container
            SizedBox(
              width: 68.w,
              height: 70.h,
              child: Image.asset(AppImages.mapImage, fit: BoxFit.fill),
            ),
            const SizedBox(width: 16),
            // Text Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyles.styleBold(
                      context,
                      fontSize: 16,
                      color: ColorsManager.primaryColor,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyles.styleBold(
                      context,
                      fontSize: 12,
                      color: ColorsManager.primaryColor.withAlpha(
                        (.50 * 255).toInt(),
                      ),
                    ),
                  ), // Arrow Icon
                  Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      child: SvgPicture.asset(
                        AppIcons.yellowArrowIcon2,
                        width: 18.w,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
