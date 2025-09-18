import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shatably_app/core/themes/colors_manager.dart';
import 'package:shatably_app/core/themes/text_styles.dart';

class ProjectHeaderBar extends StatelessWidget {
  final String title;
  final bool isCompleted;
  final VoidCallback? onBackPressed;

  const ProjectHeaderBar({
    super.key,
    required this.title,
    required this.isCompleted,
    this.onBackPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: onBackPressed ?? () => Navigator.of(context).pop(),
          child: Container(
            width: 30.w,
            height: 30.h,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xFFA6CDC6),
            ),
            child: Center(
              child: SvgPicture.asset(
                "assets/icons/arrow_ios.svg",
                width: 15.w,
                height: 15.h,
              ),
            ),
          ),
        ),
        SizedBox(width: 45.w),
        Expanded(
          child: Center(
            child: Text(
              title,
              style: TextStyles.styleRegular(
                context,
                fontSize: 16.sp,
                color: ColorsManager.primaryColor,
              ),
            ),
          ),
        ),
        if (isCompleted)
          Center(
            child: Text(
              "Completed",
              style: TextStyles.styleRegular(
                context,
                fontSize: 10.sp,
                color: ColorsManager.yellowTextColor,
              ),
            ),
          ),
        if (!isCompleted) Container(width: 47.w),
      ],
    );
  }
}
