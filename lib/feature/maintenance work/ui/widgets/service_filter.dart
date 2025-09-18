import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shatably_app/core/themes/colors_manager.dart';
import 'package:shatably_app/core/themes/text_styles.dart';

class ServiceFilter extends StatelessWidget {
  final String icon;
  final String label;
  final bool isLast;

  const ServiceFilter({
    super.key,
    required this.icon,
    required this.label,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(icon, width: 20.w, height: 20.h),
        SizedBox(width: 8.w),
        Text(
          label,
          style: TextStyles.styleRegular(
            context,
            fontSize: 14.sp,
            color: ColorsManager.primaryColor,
          ),
        ),
        SizedBox(width: 17.w),
        if (!isLast) ...[
          SizedBox(width: 8.w),
          Container(
            width: 1.w,
            height: 12.h,
            decoration: const BoxDecoration(color: Colors.amber),
          ),
          SizedBox(width: 16.w),
        ],
      ],
    );
  }
}
