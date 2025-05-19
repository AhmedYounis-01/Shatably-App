import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shatably_app/core/themes/colors_manager.dart';
import 'package:shatably_app/core/themes/text_styles.dart';
import 'package:shatably_app/core/utils/app_images.dart';
import 'package:shatably_app/core/widgets/custom_app_button1.dart';
import 'package:shatably_app/core/widgets/custom_text_form_feild.dart';
import 'package:shatably_app/feature/auth/login/ui/password_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

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
            AppImages.loginImage,
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
                    SizedBox(height: 450.h),

                    Text(
                      'Login',
                      style: TextStyles.styleBold(
                        context,
                        fontSize: 44.sp,
                        fontWeight: FontWeight.bold,
                        color: ColorsManager.primaryColor,
                      ),
                    ),

                    SizedBox(height: 1.h),

                    Text(
                      'Good to see you back!',
                      style: TextStyles.styleBold(
                        context,
                        fontSize: 18.sp,
                        color: ColorsManager.primaryColor,
                      ),
                    ),

                    SizedBox(height: 23.h),

                    CustomTextFormField(
                      hintText: 'Email or phone',
                      textAlign: TextAlign.start,
                    ),

                    SizedBox(height: 23.h),

                    CustomAppButton1(
                      width: double.infinity,
                      height: 60,
                      backgroundColor: ColorsManager.primaryColor,
                      borderRadius: 25,
                      hasShadow: true,
                      onPressed: () {
                        // Navigate to password screen
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const PasswordScreen(),
                          ),
                        );
                      },
                      child: Center(
                        child: Text(
                          "Next",
                          style: TextStyles.styleBold(
                            context,
                            fontSize: 20.sp,
                            color: ColorsManager.whiteButtonColor,
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: 12.h),

                    // Sign up text
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Don\'t have an account? ',
                          style: TextStyles.styleMedium(
                            context,
                            fontSize: 16.sp,
                            color: Color.fromRGBO(22, 64, 77, 0.4),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            // Navigate to sign up screen
                          },
                          child: Text(
                            'Sign up',
                            style: TextStyles.styleMedium(
                              context,
                              fontSize: 14.sp,
                              color: ColorsManager.primaryColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    //! need to change
                    // Add extra space at the bottom to ensure everything is visible when keyboard appears
                    // SizedBox(height: 100.h),
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
