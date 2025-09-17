import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shatably_app/core/themes/colors_manager.dart';
import 'package:shatably_app/core/themes/text_styles.dart';

class ServicesAppBarRow extends StatelessWidget {
  const ServicesAppBarRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: Container(
              width: 30.w,
              height: 30.h,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0XFFA6CDC6),
              ),
              child: Center(
                child: SvgPicture.asset(
                  'assets/icons/arrow_ios.svg',
                  width: 15.w,
                  height: 15.h,
                ),
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: Text(
                'Browse Services',
                style: TextStyles.styleMedium(
                  context,
                  fontSize: 18,
                  color: ColorsManager.primaryColor,
                ),
              ),
            ),
          ),
          SizedBox(width: 41.w),
        ],
      ),
    );
  }
}
