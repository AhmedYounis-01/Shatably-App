import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shatably_app/core/helpers/extensions.dart';
import 'package:shatably_app/core/routes/routes.dart';
import 'package:shatably_app/core/themes/colors_manager.dart';
import 'package:shatably_app/core/themes/text_styles.dart';
import 'package:shatably_app/core/utils/app_images.dart';

class TypeScreen extends StatelessWidget {
  const TypeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 100.h),
            Center(
              child: Text(
                "Continue as",
                style: TextStyles.styleBold(
                  context,
                  fontSize: 24.sp,
                  color: ColorsManager.primaryColor,
                ),
              ),
            ),
            SizedBox(height: 50.h),
            InkWell(
              onTap: () {
                context.pushReplacementNamed(Routes.loginScreen);
              },
              child: Stack(
                alignment: Alignment.bottomCenter,
                clipBehavior: Clip.none,
                children: [
                  Container(
                    width: 315.w,
                    decoration: BoxDecoration(
                      color: Color(0xFFD6EEEA),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(25),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsetsDirectional.only(top: 11),
                      child: Image.asset(
                        AppImages.userImage,
                        width: 151.w,
                        height: 151.h,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: -35.h,
                    child: Container(
                      width: 315.w,
                      height: 54.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(25),
                          bottomLeft: Radius.circular(25),
                        ),
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [Color(0xFF2B7991), Color(0xFFA6CDC6)],
                        ),
                      ),
                      child: Center(
                        child: Text(
                          "User",
                          style: TextStyles.styleBold(
                            context,
                            fontSize: 24.sp,
                            color: Color(0XFF091B20),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 90.h),
            InkWell(
              onTap: () {
                context.pushReplacementNamed(Routes.loginScreen);
              },
              child: Stack(
                alignment: Alignment.bottomCenter,
                clipBehavior: Clip.none,
                children: [
                  Container(
                    width: 315.w,
                    decoration: BoxDecoration(
                      color: Color(0xFFD6EEEA),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(25),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsetsDirectional.only(top: 11),
                      child: Image.asset(
                        AppImages.workerImage,
                        width: 151.w,
                        height: 151.h,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: -35.h,
                    child: Container(
                      width: 315.w,
                      height: 54.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(25),
                          bottomLeft: Radius.circular(25),
                        ),
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [Color(0xFFDDA853), Color(0xFFA6CDC6)],
                        ),
                      ),
                      child: Center(
                        child: Text(
                          "Worker",
                          style: TextStyles.styleBold(
                            context,
                            fontSize: 24.sp,
                            color: Color(0XFF091B20),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
