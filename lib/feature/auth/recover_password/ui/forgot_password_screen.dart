import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shatably_app/core/themes/colors_manager.dart';
import 'package:shatably_app/core/themes/text_styles.dart';
import 'package:shatably_app/core/utils/app_images.dart';
import 'package:shatably_app/core/widgets/custom_app_button1.dart';
import 'package:shatably_app/core/widgets/custom_text_form_feild.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

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
            AppImages.loginImage,
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),

          // Content layer
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Top space
                  SizedBox(height: 405.h),
                  // This Expanded will make sure the content area scrolls
                  Expanded(
                    child: SingleChildScrollView(
                      physics: const ClampingScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Title
                          Text(
                            'Forgot\nPassword?',
                            style: TextStyles.styleBold(
                              context,
                              fontSize: 36.sp,
                              fontWeight: FontWeight.bold,
                              color: ColorsManager.primaryColor,
                            ),
                          ),

                          SizedBox(height: 5.h),

                          // Description text
                          Text(
                            'Don\'t worry ! It happens. Please enter the phone\nnumber we will send the OTP in this phone number.',
                            style: TextStyles.styleRegular(
                              context,
                              fontSize: 14.sp,
                              color: Color(0XFF5B5858),
                            ),
                          ),

                          SizedBox(height: 25.h),

                          // Phone number input field
                          CustomTextFormField(
                            hintText: 'Enter the phone Number',
                            textAlign: TextAlign.start,
                            inputType: TextInputType.phone,
                          ),

                          SizedBox(height: 40.h),

                          // Continue button
                          CustomAppButton1(
                            width: double.infinity,
                            height: 68.h,
                            backgroundColor: ColorsManager.primaryColor,
                            borderRadius: 25,
                            hasShadow: true,
                            onPressed: () {
                              // Navigate to OTP verification screen
                            },
                            child: Center(
                              child: Text(
                                "Continue",
                                style: TextStyles.styleSemiBold(
                                  context,
                                  fontSize: 18.sp,
                                  color: ColorsManager.whiteButtonColor,
                                ),
                              ),
                            ),
                          ),

                          // Add some padding at the bottom to ensure visibility
                          SizedBox(height: 45.h),
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
