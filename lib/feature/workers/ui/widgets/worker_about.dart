import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shatably_app/core/themes/colors_manager.dart';
import 'package:shatably_app/core/themes/text_styles.dart';

class WorkerAbout extends StatelessWidget {
  final String aboutText;
  const WorkerAbout({super.key, required this.aboutText});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: Container(
            width: 24.w,
            height: .5.h,
            color: ColorsManager.primaryColor.withAlpha((.5 * 255).toInt()),
          ),
        ),
        SizedBox(height: 15.h),
        Text(
          "About",
          style: TextStyles.styleSemiBold(
            context,
            fontSize: 16.sp,
            color: ColorsManager.primaryColor,
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          aboutText,
          style: TextStyles.styleRegular(
            context,
            fontSize: 14.sp,
            color: ColorsManager.primaryColor.withAlpha((.82 * 255).toInt()),
          ),
        ),
        SizedBox(height: 22.h),
        Center(
          child: Container(
            width: 20.w,
            height: .5.h,
            color: ColorsManager.primaryColor.withAlpha((.5 * 255).toInt()),
          ),
        ),
      ],
    );
  }
}
