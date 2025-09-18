import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shatably_app/core/themes/colors_manager.dart';
import 'package:shatably_app/core/themes/text_styles.dart';

class MaintenanceDetailsSection extends StatelessWidget {
  final BuildContext parentContext;
  final String description;
  final String details;

  const MaintenanceDetailsSection({
    super.key,
    required this.parentContext,
    required this.description,
    required this.details,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 26.w),
          child: Text(
            description,
            style: TextStyles.styleMedium(
              parentContext,
              fontSize: 16.sp,
              color: const Color(0xFF1C4857),
            ),
          ),
        ),
        SizedBox(height: 20.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 26.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Details',
                style: TextStyles.styleMedium(
                  parentContext,
                  fontSize: 16.sp,
                  color: ColorsManager.primaryColor,
                ),
              ),
              SizedBox(height: 8.h),
              RichText(
                text: TextSpan(
                  text: details,
                  style: TextStyles.styleRegular(
                    parentContext,
                    fontSize: 14.sp,
                    color: const Color(
                      0XFF16404D,
                    ).withAlpha((.8 * 255).toInt()),
                  ),
                  children: [
                    TextSpan(
                      text: 'Read more',
                      style: TextStyles.styleBold(
                        parentContext,
                        fontSize: 14.sp,
                        color: const Color(0XFF003076),
                      ),
                      recognizer: TapGestureRecognizer()..onTap = () {},
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
