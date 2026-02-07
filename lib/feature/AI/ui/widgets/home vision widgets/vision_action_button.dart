import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shatably_app/core/themes/text_styles.dart';

class VisionActionButton extends StatelessWidget {
  final String text;
  final String iconPath;
  final VoidCallback onPressed;
  final Color textColor;
  final bool isUser;

  const VisionActionButton({
    super.key,
    required this.text,
    required this.iconPath,
    required this.onPressed,
    required this.textColor,
    required this.isUser,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(8.r),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              iconPath,
              colorFilter: ColorFilter.mode(textColor, BlendMode.srcIn),
              width: 20.sp,
              height: 20.sp,
            ),
            SizedBox(width: 8.w),
            Text(
              text,
              style: TextStyles.styleRegular(
                context,
                fontSize: 14.sp,
                color: isUser ? const Color(0XFF776F69) : Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
