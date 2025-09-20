import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shatably_app/core/themes/colors_manager.dart';
import 'package:shatably_app/core/themes/text_styles.dart';
import 'package:shatably_app/feature/profile/data/models/profile_model.dart';

class ProfileHeader extends StatelessWidget {
  final ProfileModel profile;

  const ProfileHeader({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 50.h),
        Center(
          child: Text(
            "Profile",
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w500,
              color: ColorsManager.primaryColor,
            ),
          ),
        ),
        SizedBox(height: 18.h),
        Container(
          width: 85.r,
          height: 85.r,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              image: AssetImage(profile.backgroundImage),
              fit: BoxFit.cover,
            ),
          ),
          child: Center(
            child: Container(
              width: 70.r,
              height: 70.r,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withAlpha((25 * 255).toInt()),
                    blurRadius: 4.r,
                    offset: const Offset(0, 1),
                  ),
                ],
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: AssetImage(profile.profileImage),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 10.h),
        Text(
          profile.name,
          style: TextStyles.styleMedium(
            context,
            fontSize: 13.sp,
            color: ColorsManager.primaryColor,
          ),
        ),
        Text(
          profile.email,
          style: TextStyles.styleMedium(
            context,
            fontSize: 12.sp,
            color: ColorsManager.primaryColor.withAlpha((64 * 255).toInt()),
          ),
        ),
      ],
    );
  }
}
