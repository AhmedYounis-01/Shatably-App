import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shatably_app/core/themes/colors_manager.dart';
import 'package:shatably_app/core/themes/text_styles.dart';
import 'package:shatably_app/core/utils/app_images.dart';
import 'package:shatably_app/core/widgets/custom_app_button1.dart';

class PasswordResetConfirmationScreen extends StatelessWidget {
  const PasswordResetConfirmationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Set to true to allow screen to resize when keyboard appears
      resizeToAvoidBottomInset: false,
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background image
          Image.asset(
            AppImages.newPasswordImage,
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),

          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10.0,
                vertical: 20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 30.w,
                    height: 30.h,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0XFFA6CDC6),
                    ),
                    child: Center(
                      child: SvgPicture.asset(
                        "assets/icons/arrow_ios.svg",
                        width: 15.w,
                        height: 15.h,
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Text(
                    'Password reset',
                    style: TextStyles.styleSemiBold(
                      context,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: ColorsManager.primaryColor,
                    ),
                  ),

                  SizedBox(height: 16.h),

                  // Description text
                  Text(
                    'Your password has been successfully reset.Click\n confirm to set a new password',
                    textAlign: TextAlign.start,
                    style: TextStyles.styleRegular(
                      context,
                      fontSize: 14.sp,
                      color: Color.fromRGBO(22, 64, 77, 0.63),
                    ),
                  ),

                  SizedBox(height: 32.h),

                  // Confirm button
                  Center(
                    child: CustomAppButton1(
                      width: 150.w,
                      height: 48.h,
                      backgroundColor: ColorsManager.primaryColor,
                      borderRadius: 25,
                      hasShadow: true,
                      onPressed: () {},
                      child: Text(
                        "Confirm",
                        style: TextStyles.styleSemiBold(
                          context,
                          fontSize: 16.sp,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
