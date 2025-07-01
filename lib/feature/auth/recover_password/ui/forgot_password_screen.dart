import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shatably_app/core/helpers/extensions.dart';
import 'package:shatably_app/core/injection/injection_container.dart';
import 'package:shatably_app/core/routes/routes.dart';
import 'package:shatably_app/core/themes/colors_manager.dart';
import 'package:shatably_app/core/themes/text_styles.dart';
import 'package:shatably_app/core/utils/app_images.dart';
import 'package:shatably_app/core/widgets/custom_app_button1.dart';
import 'package:shatably_app/core/widgets/custom_text_form_feild.dart';
import 'package:shatably_app/core/widgets/custom_toast.dart';
import 'package:shatably_app/feature/auth/recover_password/data/repository/forgot_password_repository.dart';
import 'package:shatably_app/feature/auth/recover_password/logic/forgot%20password/forgot_password_cubit.dart';
import 'package:toastification/toastification.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final ScrollController _scrollController = ScrollController();
  final FocusNode __emailFocusNode = FocusNode();
  final TextEditingController _emailTextController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    // Listen to focus changes to scroll when text field is focused
    __emailFocusNode.addListener(_onFocusChange);
  }

  void _onFocusChange() {
    if (__emailFocusNode.hasFocus) {
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
    __emailFocusNode.dispose();
    _scrollController.dispose();
    _emailTextController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;

    return BlocProvider(
      create: (context) => ForgotPasswordCubit(sl<ForgotPasswordRepository>()),
      child: BlocConsumer<ForgotPasswordCubit, ForgotPasswordStates>(
        listener: (context, state) {
          // if (state is ForgotPasswordLoading) {

          // }
          if (state is ForgotPasswordSuccess) {
            customToast(
              context: context,
              message: state.seuccessMessage,
              type: ToastificationType.success,
              icon: Icons.check,
            );

            Future.delayed(const Duration(seconds: 2), () {
              if (!context.mounted) return;
              context.pushNamed(
                Routes.passwordResetScreen,
                arguments: state.email,
              );
            });
          }

          if (state is ForgotPasswordError) {
            customToast(
              context: context,
              message: state.errMessage,
              type: ToastificationType.error,
              icon: Icons.error,
            );
          }
        },
        builder: (context, state) {
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
                      child: SingleChildScrollView(
                        controller: _scrollController,
                        physics: const ClampingScrollPhysics(),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Dynamic top spacing based on keyboard state
                              AnimatedContainer(
                                duration: const Duration(milliseconds: 300),
                                height: keyboardHeight > 0 ? 200.h : 405.h,
                              ),

                              // Scrollable content area
                              Column(
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
                                        fontSize:
                                            keyboardHeight > 0 ? 28.sp : 36.sp,
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
                                      'Don\'t worry ! It happens. Please enter the email\naddress we used to send you your password reset instructions.',
                                      style: TextStyles.styleRegular(
                                        context,
                                        fontSize:
                                            keyboardHeight > 0 ? 12.sp : 14.sp,
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
                                                  color: ColorsManager
                                                      .primaryColor
                                                      .withAlpha(
                                                        (0.1 * 255).toInt(),
                                                      ),
                                                  blurRadius: 8,
                                                  offset: const Offset(0, 2),
                                                ),
                                              ]
                                              : [],
                                    ),
                                    child: CustomTextFormField(
                                      hintText: 'Enter Your E-mail',
                                      textAlign: TextAlign.start,
                                      inputType: TextInputType.emailAddress,
                                      controller: _emailTextController,
                                      focusNode: __emailFocusNode,
                                      validator: (value) {
                                        if (value == null ||
                                            value.trim().isEmpty) {
                                          return 'Please enter your email';
                                        }

                                        final emailRegex = RegExp(
                                          r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                                        );

                                        if (!emailRegex.hasMatch(
                                          value.trim(),
                                        )) {
                                          return 'Please enter a valid email';
                                        }

                                        return null;
                                      },
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
                                      backgroundColor:
                                          ColorsManager.primaryColor,
                                      borderRadius: 25,
                                      hasShadow: true,
                                      onPressed: () {
                                        if (_formKey.currentState!.validate()) {
                                          context
                                              .read<ForgotPasswordCubit>()
                                              .forgotPassword(
                                                _emailTextController.text
                                                    .trim(),
                                              );
                                        }
                                      },
                                      child: Center(
                                        child:
                                            state is ForgotPasswordLoading
                                                ? CircularProgressIndicator(
                                                  strokeWidth: 2.5,
                                                  color: Colors.white,
                                                )
                                                : Text(
                                                  "Continue",
                                                  style: TextStyles.styleSemiBold(
                                                    context,
                                                    fontSize: 18.sp,
                                                    color:
                                                        ColorsManager
                                                            .whiteButtonColor,
                                                  ),
                                                ),
                                      ),
                                    ),
                                  ),

                                  // Bottom padding
                                  SizedBox(height: 45.h),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
