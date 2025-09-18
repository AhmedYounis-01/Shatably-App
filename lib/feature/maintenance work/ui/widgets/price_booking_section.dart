import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shatably_app/core/themes/colors_manager.dart';
import 'package:shatably_app/core/themes/text_styles.dart';
import 'package:shatably_app/core/widgets/custom_app_button1.dart';

class MaintenancePriceAndBook extends StatelessWidget {
  final BuildContext parentContext;
  final String priceText;
  final VoidCallback onBook;

  const MaintenancePriceAndBook({
    super.key,
    required this.parentContext,
    required this.priceText,
    required this.onBook,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 10.h),
      decoration: BoxDecoration(
        color: const Color(0xFFE4EFED),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25.r),
          topRight: Radius.circular(25.r),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha((.25 * 255).toInt()),
            offset: const Offset(0, -4),
            spreadRadius: -1,
            blurRadius: 4.8,
          ),
        ],
      ),
      child: Column(
        children: [
          SizedBox(height: 20.h),
          Center(
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: priceText,
                    style: TextStyles.styleMedium(
                      parentContext,
                      fontSize: 16.sp,
                      color: ColorsManager.primaryColor,
                    ),
                  ),
                  TextSpan(
                    text: ' Per Hour',
                    style: TextStyles.styleMedium(
                      parentContext,
                      fontSize: 14.sp,
                      color: ColorsManager.primaryColor.withAlpha(
                        (.53 * 255).toInt(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 12.h),
          Center(
            child: CustomAppButton1(
              width: 145.w,
              height: 50.h,
              onPressed: onBook,
              backgroundColor: const Color(0xFF1C4857),
              borderRadius: 25.r,
              hasShadow: true,
              child: Text(
                'Book Now',
                style: TextStyles.styleMedium(
                  parentContext,
                  fontSize: 16.sp,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          SizedBox(height: 80.h),
        ],
      ),
    );
  }
}
