import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shatably_app/core/helpers/extensions.dart';
import 'package:shatably_app/core/injection/injection_container.dart';
import 'package:shatably_app/core/routes/routes.dart';
import 'package:shatably_app/core/themes/colors_manager.dart';
import 'package:shatably_app/core/themes/text_styles.dart';
import 'package:shatably_app/core/utils/app_images.dart';
import 'package:shatably_app/core/widgets/custom_app_button1.dart';
import 'package:shatably_app/core/widgets/custom_build_input_field.dart';
import 'package:shatably_app/feature/auth/recover_password/data/repository/password_reset_repository.dart';
import 'package:shatably_app/feature/auth/recover_password/logic/password%20reset/password_reset_cubit.dart';

class PasswordResetScreen extends StatefulWidget {
  const PasswordResetScreen({super.key});

  @override
  State<PasswordResetScreen> createState() => _PasswordResetScreenState();
}

class _PasswordResetScreenState extends State<PasswordResetScreen> {
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PasswordResetCubit(sl<PasswordResetRepository>()),
      child: BlocConsumer<PasswordResetCubit, PasswordResetStates>(
        listener: (context, state) {},
        builder: (context, state) {
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
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: SingleChildScrollView(
                            physics: const ClampingScrollPhysics(),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: 40.w,
                                  height: 40.h,
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
                                    color: ColorsManager.primaryColor.withAlpha(
                                      (63 * 255).toInt(),
                                    ),
                                  ),
                                ),

                                SizedBox(height: 23.75.h),

                                LabeledInputField(
                                  labelText: 'Password',
                                  hintText: "Enter your new password",
                                  fontSize: 14.sp,
                                  textAlign: TextAlign.start,
                                  inputType: TextInputType.visiblePassword,
                                  controller: newPasswordController,
                                  isPassword: true,
                                ),

                                SizedBox(height: 8.h),

                                LabeledInputField(
                                  labelText: 'Confirm Password',
                                  hintText: "Re-enter password",
                                  fontSize: 14.sp,
                                  textAlign: TextAlign.start,
                                  inputType: TextInputType.visiblePassword,
                                  controller: confirmPasswordController,
                                  isPassword: true,
                                ),

                                SizedBox(height: 35.h),

                                // Update Password button
                                CustomAppButton1(
                                  width: double.infinity,
                                  height: 68.h,
                                  backgroundColor: ColorsManager.primaryColor,
                                  borderRadius: 25.r,
                                  hasShadow: true,
                                  onPressed: () {
                                    context
                                        .read<PasswordResetCubit>()
                                        .resetPassword(
                                          //!!!!!!!!!!!111111
                                          "email",
                                          "token", //? backend make not required
                                          //!!!!!!!!!!!111111
                                          newPasswordController.text.trim(),
                                          confirmPasswordController.text.trim(),
                                        );
                                    context.pushNamedAndRemoveUntil(
                                      Routes.newPasswordConfirmationScreen,
                                      predicate: (route) => false,
                                    );
                                  },
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
        },
      ),
    );
  }
}
