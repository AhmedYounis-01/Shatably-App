import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shatably_app/core/themes/colors_manager.dart';
import 'package:shatably_app/core/themes/text_styles.dart';
import 'package:shatably_app/core/utils/app_images.dart';
import 'package:shatably_app/core/widgets/custom_app_button1.dart';
import 'package:shatably_app/core/widgets/custom_build_input_field.dart';

class PasswordResetScreen extends StatelessWidget {
  const PasswordResetScreen({super.key});

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

          // Content layer
          SafeArea(
            child: Padding(
              padding: EdgeInsets.only(
                left: 25.w,
                right: 43.w,
                top: 20.h,
                // horizontal: 10.0,
                // vertical: 20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Top space
                  // SizedBox(height: 405.h),

                  // Scrollable content
                  Expanded(
                    child: SingleChildScrollView(
                      physics: const ClampingScrollPhysics(),
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
                          SizedBox(height: 25.h),
                          // Title
                          Text(
                            'Set a new password',
                            style: TextStyles.styleBold(
                              context,
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold,
                              color: ColorsManager.primaryColor,
                            ),
                          ),

                          SizedBox(height: 16.5.h),

                          // Description text
                          Text(
                            'Create a new password. Ensure it differs\nfrom previous ones for security.',
                            style: TextStyles.styleRegular(
                              context,
                              fontSize: 14.sp,
                              color: Color(0XFF5B5858),
                            ),
                          ),

                          SizedBox(height: 23.75.h),

                          LabeledInputField(
                            labelText: 'Password',
                            hintText: "Enter your new password",
                            textAlign: TextAlign.start,
                            inputType: TextInputType.visiblePassword,
                            isPassword: true,
                          ),
                          // New Password input field
                          // CustomTextFormField(
                          //   hintText: 'Enter your new password',
                          //   textAlign: TextAlign.start,
                          //   inputType: TextInputType.visiblePassword,
                          //   isPassword: true,
                          //   // obscureText: true,
                          // ),
                          SizedBox(height: 8.h),

                          LabeledInputField(
                            labelText: 'Confirm Password',
                            hintText: "Re-enter password",
                            textAlign: TextAlign.start,
                            inputType: TextInputType.visiblePassword,
                            isPassword: true,
                          ),

                          SizedBox(height: 35.h),

                          // Update Password button
                          CustomAppButton1(
                            width: double.infinity,
                            height: 68.h,
                            backgroundColor: ColorsManager.primaryColor,
                            borderRadius: 25,
                            hasShadow: true,
                            onPressed: () {},
                            child: Center(
                              child: Text(
                                "Update Password",
                                style: TextStyles.styleSemiBold(
                                  context,
                                  fontSize: 16.sp,
                                  color: ColorsManager.whiteButtonColor,
                                ),
                              ),
                            ),
                          ),

                          // Add some padding at the bottom to ensure visibility
                          // SizedBox(height: 45.h),
                        ],
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
