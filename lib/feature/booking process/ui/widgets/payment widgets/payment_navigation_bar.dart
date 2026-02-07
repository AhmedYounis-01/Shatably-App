import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shatably_app/core/themes/colors_manager.dart';
import 'package:shatably_app/core/themes/text_styles.dart';

class PaymentNavigationBar extends StatelessWidget {
  final String title;

  const PaymentNavigationBar({required this.title, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: Container(
            width: 32.w,
            height: 32.h,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xFFBEE1DB),
            ),
            child: Center(
              child: Icon(
                Icons.arrow_back_ios_new,
                color: ColorsManager.primaryColor,
                size: 16.sp,
              ),
            ),
          ),
        ),
        Expanded(
          child: Center(
            child: Text(
              title,
              style: TextStyles.styleMedium(
                context,
                fontSize: 18.sp,
                color: ColorsManager.primaryColor,
              ),
            ),
          ),
        ),
        SizedBox(width: 32.w),
      ],
    );
  }
}
