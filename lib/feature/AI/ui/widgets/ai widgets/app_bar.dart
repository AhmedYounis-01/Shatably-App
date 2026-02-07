import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shatably_app/core/themes/colors_manager.dart';
import 'package:shatably_app/core/themes/text_styles.dart';
class AppBar extends StatelessWidget {
  const AppBar({
    super.key,
  });

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
              "Shatably AI",
              style: TextStyles.styleRegular(
                context,
                fontSize: 20.sp,
                color: Color(0XFF0A252E),
              ),
            ),
          ),
        ),
        SizedBox(width: 24),
      ],
    );
  }
}
