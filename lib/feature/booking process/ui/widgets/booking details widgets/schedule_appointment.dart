import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shatably_app/core/themes/colors_manager.dart';
import 'package:shatably_app/core/themes/text_styles.dart';

class ScheduleAppointment extends StatelessWidget {
  const ScheduleAppointment({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              "Date:",
              style: TextStyles.styleMedium(
                context,
                fontSize: 14.sp,
                color: ColorsManager.primaryColor.withAlpha(
                  (.50 * 255).toInt(),
                ),
              ),
            ),
            const Spacer(),
            Text(
              "16 June 2025",
              style: TextStyles.styleMedium(
                context,
                fontSize: 14.sp,
                color: ColorsManager.primaryColor,
              ),
            ),
          ],
        ),
        SizedBox(height: 16.h),
        Row(
          children: [
            Text(
              "Time:",
              style: TextStyles.styleMedium(
                context,
                fontSize: 14.sp,
                color: ColorsManager.primaryColor.withAlpha(
                  (.50 * 255).toInt(),
                ),
              ),
            ),
            const Spacer(),
            Text(
              "2PM to 5PM",
              style: TextStyles.styleMedium(
                context,
                fontSize: 14.sp,
                color: ColorsManager.primaryColor,
              ),
            ),
          ],
        ),
        SizedBox(height: 16.h),
        Row(
          children: [
            Text(
              "Duration:",
              style: TextStyles.styleMedium(
                context,
                fontSize: 14.sp,
                color: ColorsManager.primaryColor.withAlpha(
                  (.50 * 255).toInt(),
                ),
              ),
            ),
            const Spacer(),
            Text(
              "3 Hours",
              style: TextStyles.styleMedium(
                context,
                fontSize: 14.sp,
                color: ColorsManager.primaryColor,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
