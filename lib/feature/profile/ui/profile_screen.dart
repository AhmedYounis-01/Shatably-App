import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shatably_app/feature/profile/data/sample/profile_sample.dart';
import 'package:shatably_app/feature/profile/ui/widgets/profile_header.dart';
import 'package:shatably_app/feature/profile/ui/widgets/profile_menu_list.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0XFFE5F1EF),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              ProfileHeader(profile: kProfileData),
              SizedBox(height: 53.h),
              const ProfileMenuList(),
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }
}
