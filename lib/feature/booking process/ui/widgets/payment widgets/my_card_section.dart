import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shatably_app/core/themes/colors_manager.dart';
import 'package:shatably_app/core/themes/text_styles.dart';
import 'package:shatably_app/core/utils/app_images.dart';

class MyCardSection extends StatelessWidget {
  const MyCardSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "My Card",
          style: TextStyles.styleMedium(
            context,
            fontSize: 16.sp,
            color: ColorsManager.primaryColor,
          ),
        ),
        SizedBox(height: 10.h),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(20.w),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20.r)),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF000000).withAlpha((0.22 * 255).toInt()),
                offset: const Offset(0, 1),
                blurRadius: 34.4.r,
                spreadRadius: 0,
              ),
            ],
            gradient: LinearGradient(
              begin: Alignment.bottomRight,
              end: Alignment.topLeft,
              colors: [
                Color(0xFF77A4B3).withAlpha((0.7 * 255).toInt()),
                Color(0xFF16404D).withAlpha((0.7 * 255).toInt()),
              ],
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(AppImages.visaIcon, width: 80.w, height: 30.h),
              SizedBox(height: 21.h),
              Image.asset(AppImages.visaIcon2, width: 25.w, height: 19.h),
              SizedBox(height: 7.5.h),
              Text(
                "0000 0000 0000 0000",
                style: TextStyles.styleRegular(
                  context,
                  fontSize: 20.sp,
                  color: Colors.white,
                ).copyWith(wordSpacing: 10.w),
              ),
              Text(
                "Abdelrahman Morgan",
                style: TextStyles.styleRegular(
                  context,
                  fontSize: 14.sp,
                  color: Colors.white,
                ),
              ),
              Text(
                "09/26",
                style: TextStyles.styleRegular(
                  context,
                  fontSize: 10.sp,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
