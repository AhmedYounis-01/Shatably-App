// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:shatably_app/core/themes/colors_manager.dart';
// import 'package:shatably_app/core/themes/text_styles.dart';
// import 'package:shatably_app/core/utils/app_images.dart';
// import 'package:shatably_app/core/widgets/custom_app_button1.dart';
// import 'package:shatably_app/core/widgets/custom_text_form_feild.dart';

// class ForgotPasswordScreen extends StatelessWidget {
//   const ForgotPasswordScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // Set to true to allow screen to resize when keyboard appears
//       resizeToAvoidBottomInset: false,
//       body: Stack(
//         fit: StackFit.expand,
//         children: [
//           // Background image
//           Image.asset(
//             AppImages.loginImage,
//             fit: BoxFit.cover,
//             width: double.infinity,
//             height: double.infinity,
//           ),

//           // Content layer
//           SafeArea(
//             child: Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 30.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   // Top space
//                   SizedBox(height: 405.h),
//                   // This Expanded will make sure the content area scrolls
//                   Expanded(
//                     child: SingleChildScrollView(
//                       physics: const ClampingScrollPhysics(),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           // Title
//                           Text(
//                             'Forgot\nPassword?',
//                             style: TextStyles.styleBold(
//                               context,
//                               fontSize: 36.sp,
//                               fontWeight: FontWeight.bold,
//                               color: ColorsManager.primaryColor,
//                             ),
//                           ),

//                           SizedBox(height: 5.h),

//                           // Description text
//                           Text(
//                             'Don\'t worry ! It happens. Please enter the phone\nnumber we will send the OTP in this phone number.',
//                             style: TextStyles.styleRegular(
//                               context,
//                               fontSize: 14.sp,
//                               color: Color(0XFF5B5858),
//                             ),
//                           ),

//                           SizedBox(height: 25.h),

//                           // Phone number input field
//                           CustomTextFormField(
//                             hintText: 'Enter the phone Number',
//                             textAlign: TextAlign.start,
//                             inputType: TextInputType.phone,
//                           ),

//                           SizedBox(height: 40.h),

//                           // Continue button
//                           CustomAppButton1(
//                             width: double.infinity,
//                             height: 68.h,
//                             backgroundColor: ColorsManager.primaryColor,
//                             borderRadius: 25,
//                             hasShadow: true,
//                             onPressed: () {
//                               // Navigate to OTP verification screen
//                             },
//                             child: Center(
//                               child: Text(
//                                 "Continue",
//                                 style: TextStyles.styleSemiBold(
//                                   context,
//                                   fontSize: 18.sp,
//                                   color: ColorsManager.whiteButtonColor,
//                                 ),
//                               ),
//                             ),
//                           ),

//                           // Add some padding at the bottom to ensure visibility
//                           SizedBox(height: 45.h),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shatably_app/core/themes/colors_manager.dart';
import 'package:shatably_app/core/themes/text_styles.dart';
import 'package:shatably_app/core/utils/app_images.dart';
import 'package:shatably_app/core/widgets/custom_app_button1.dart';
import 'package:shatably_app/core/widgets/custom_text_form_feild.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final ScrollController _scrollController = ScrollController();
  final FocusNode _phoneFieldFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    // Listen to focus changes to scroll when text field is focused
    _phoneFieldFocusNode.addListener(_onFocusChange);
  }

  void _onFocusChange() {
    if (_phoneFieldFocusNode.hasFocus) {
      // Small delay to ensure keyboard is shown
      Future.delayed(const Duration(milliseconds: 300), () {
        if (mounted) {
          _scrollController.animateTo(
            150.0, // Adjust this value based on your design
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
        }
      });
    }
  }

  @override
  void dispose() {
    _phoneFieldFocusNode.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;

    return Scaffold(
      resizeToAvoidBottomInset: false, // Keep background fixed
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background image - stays fixed
          Image.asset(
            AppImages.loginImage,
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),

          // Content with animated positioning
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            margin: EdgeInsets.only(
              bottom: keyboardHeight > 0 ? keyboardHeight : 0,
            ),
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Dynamic top spacing based on keyboard state
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      height: keyboardHeight > 0 ? 200.h : 405.h,
                    ),

                    // Scrollable content area
                    Expanded(
                      child: SingleChildScrollView(
                        controller: _scrollController,
                        physics: const ClampingScrollPhysics(),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Title with animation
                            AnimatedOpacity(
                              duration: const Duration(milliseconds: 300),
                              opacity: keyboardHeight > 0 ? 0.8 : 1.0,
                              child: Text(
                                'Forgot\nPassword?',
                                style: TextStyles.styleBold(
                                  context,
                                  fontSize: keyboardHeight > 0 ? 28.sp : 36.sp,
                                  fontWeight: FontWeight.bold,
                                  color: ColorsManager.primaryColor,
                                ),
                              ),
                            ),

                            SizedBox(height: 5.h),

                            // Description text with animation
                            AnimatedOpacity(
                              duration: const Duration(milliseconds: 300),
                              opacity: keyboardHeight > 0 ? 0.7 : 1.0,
                              child: Text(
                                'Don\'t worry ! It happens. Please enter the phone\nnumber we will send the OTP in this phone number.',
                                style: TextStyles.styleRegular(
                                  context,
                                  fontSize: keyboardHeight > 0 ? 12.sp : 14.sp,
                                  color: Color(0XFF5B5858),
                                ),
                              ),
                            ),

                            SizedBox(height: 25.h),

                            // Phone number input field - always visible and focused
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                boxShadow:
                                    keyboardHeight > 0
                                        ? [
                                          BoxShadow(
                                            color: ColorsManager.primaryColor
                                                .withOpacity(0.1),
                                            blurRadius: 8,
                                            offset: const Offset(0, 2),
                                          ),
                                        ]
                                        : [],
                              ),
                              child: CustomTextFormField(
                                hintText: 'Enter the phone Number',
                                textAlign: TextAlign.start,
                                inputType: TextInputType.phone,
                                focusNode: _phoneFieldFocusNode,
                              ),
                            ),

                            SizedBox(height: 40.h),

                            // Continue button with animation
                            AnimatedScale(
                              duration: const Duration(milliseconds: 200),
                              scale: keyboardHeight > 0 ? 0.95 : 1.0,
                              child: CustomAppButton1(
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
                            ),

                            // Bottom padding
                            SizedBox(height: 45.h),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Optional: Add a subtle overlay when keyboard is open
          // if (keyboardHeight > 0)
          //   AnimatedOpacity(
          //     duration: const Duration(milliseconds: 300),
          //     opacity: 0.1,
          //     child: Container(color: Colors.black),
          //   ),
        ],
      ),
    );
  }
}
