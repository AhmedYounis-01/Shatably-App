import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shatably_app/core/themes/colors_manager.dart';
import 'package:shatably_app/core/themes/text_styles.dart';
import 'package:shatably_app/core/utils/app_images.dart';
import 'package:shatably_app/core/widgets/custom_app_button1.dart';
import 'package:shatably_app/core/widgets/custom_text_form_feild.dart';
import 'package:shatably_app/feature/auth/login/ui/login_screen.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Remove any background color from the scaffold
      backgroundColor: Colors.transparent,
      // Use resizeToAvoidBottomInset to prevent keyboard from pushing up the content
      resizeToAvoidBottomInset: false,
      body: Stack(
        fit: StackFit.expand, // Make stack fill the entire screen
        children: [
          // Background image - fixed and covers the entire screen
          Image.asset(
            AppImages
                .registerImage, // You may need to add this image to your assets
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),

          // Content layer - scrollable but with transparent background
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: SingleChildScrollView(
                physics: const ClampingScrollPhysics(), // Smoother scrolling
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Fixed height to position content properly on the design
                    SizedBox(height: 250.h),
                    Text(
                      'Register',
                      style: TextStyles.styleBold(
                        context,
                        fontSize: 44.sp,
                        fontWeight: FontWeight.bold,
                        color: ColorsManager.primaryColor,
                      ),
                    ),

                    SizedBox(height: 30.h),

                    // First Name and Last Name in a row
                    Row(
                      children: [
                        // First Name
                        Expanded(
                          child: CustomTextFormField(
                            hintText: 'First Name*',
                            fontSize: 14.sp,
                            textAlign: TextAlign.start,
                          ),
                        ),
                        SizedBox(width: 12.w),
                        // Last Name
                        Expanded(
                          child: CustomTextFormField(
                            hintText: 'Last Name*',
                            fontSize: 14.sp,

                            textAlign: TextAlign.start,
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 23.h),

                    // Email
                    CustomTextFormField(
                      hintText: 'E-mail',
                      textAlign: TextAlign.start,
                      fontSize: 14.sp,

                      inputType: TextInputType.emailAddress,
                      // keyboardType: TextInputType.emailAddress,
                    ),

                    SizedBox(height: 23.h),

                    // Phone Number
                    CustomTextFormField(
                      hintText: 'Phone Number*',
                      fontSize: 14.sp,

                      textAlign: TextAlign.start,
                      inputType: TextInputType.phone,
                    ),

                    SizedBox(height: 23.h),

                    // Password with visibility toggle
                    CustomTextFormField(
                      hintText: 'Password*',
                      textAlign: TextAlign.start,
                      fontSize: 14.sp,

                      isPassword: true,
                      suffixIcon: Icon(
                        Icons.visibility_outlined,
                        // ignore: deprecated_member_use
                        color: ColorsManager.primaryColor.withOpacity(0.5),
                      ),
                    ),

                    SizedBox(height: 35.h),

                    // Register Button
                    CustomAppButton1(
                      width: double.infinity,
                      height: 60,
                      backgroundColor: ColorsManager.primaryColor,
                      borderRadius: 25,
                      hasShadow: true,
                      onPressed: () {
                        // Handle registration logic
                      },
                      child: Center(
                        child: Text(
                          "Get Started",
                          style: TextStyles.styleBold(
                            context,
                            fontSize: 20.sp,
                            color: ColorsManager.whiteButtonColor,
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: 11.h),

                    // Sign In text
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Already have an account? ',
                          style: TextStyles.styleMedium(
                            context,
                            fontSize: 16.sp,
                            color: Color.fromRGBO(22, 64, 77, 0.4),
                          ),
                        ),
                        SizedBox(width: 5.w),
                        InkWell(
                          onTap: () {
                            // Navigate to login screen
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const LoginScreen(),
                              ),
                            );
                          },
                          child: Text(
                            'Sign In',
                            style: TextStyles.styleBold(
                              context,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold,
                              color: ColorsManager.primaryColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    // Add extra space at the bottom to ensure everything is visible when keyboard appears
                    SizedBox(height: 20.h),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
