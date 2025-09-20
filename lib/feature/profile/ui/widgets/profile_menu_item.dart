import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shatably_app/core/themes/colors_manager.dart';
import 'package:shatably_app/feature/profile/data/models/profile_model.dart';

class ProfileMenuItemWidget extends StatelessWidget {
  final ProfileMenuItem item;

  const ProfileMenuItemWidget({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 48.h,
      padding: EdgeInsets.only(left: 10.w, right: 18.w),
      margin: EdgeInsets.only(bottom: 12.h),
      decoration: BoxDecoration(
        color: ColorsManager.backGroundFormsColor,
        border: Border.all(color: ColorsManager.yellowTextColor),
        borderRadius: BorderRadius.circular(15.r),
      ),
      child: InkWell(
        onTap: item.onTap,
        borderRadius: BorderRadius.circular(15.r),
        child: Row(
          children: [
            SvgPicture.asset(item.icon),
            SizedBox(width: 8.w),
            Text(
              item.title,
              style: TextStyle(
                color: ColorsManager.primaryColor,
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            const Spacer(),
            if (!item.isLogout)
              Icon(
                Icons.arrow_forward_ios,
                size: 16.sp,
                color: ColorsManager.primaryColor,
              ),
          ],
        ),
      ),
    );
  }
}
