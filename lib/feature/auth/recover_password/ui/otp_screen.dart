import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shatably_app/core/themes/colors_manager.dart';
import 'package:shatably_app/core/themes/text_styles.dart';
import 'package:shatably_app/core/utils/app_images.dart';

class OtpScreen extends StatelessWidget {
  const OtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsetsDirectional.only(top: 47.h),
          child: Column(
            children: [
              Center(
                child: Image.asset(
                  AppImages.otpImage,
                  width: 258.w,
                  height: 307.h,
                ),
              ),
              SizedBox(height: 51.h),
              Text(
                "OTP VERIFICATION",
                style: TextStyles.styleMedium(context, fontSize: 18.sp),
              ),
              SizedBox(height: 14.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Enter the OTP sent to ",
                    style: TextStyles.styleRegular(context, fontSize: 14.sp),
                  ),
                  Text(
                    "- +20-1211099745",
                    style: TextStyles.styleMedium(context, fontSize: 14.sp),
                  ),
                ],
              ),
              SizedBox(height: 42.h),
              Padding(
                padding: const EdgeInsetsDirectional.symmetric(horizontal: 40),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 58,
                      height: 58,
                      decoration: BoxDecoration(
                        color: ColorsManager.backGroundFormsColor,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.12),
                            offset: Offset(2, 2),
                            blurRadius: 4,
                            spreadRadius: 0,
                            // هذا يمثل الـ inner shadow لكن للأسف Flutter لا يدعم مباشرة الـ inner shadow،
                            // هنستخدم Stack مع حيلة لو محتاج نفس التأثير.
                          ),
                        ],
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        '2',
                        style: TextStyles.styleMedium(
                          context,
                          fontSize: 20.sp,
                          color: ColorsManager.primaryColor,
                        ),
                      ),
                    ),
                    Container(
                      width: 58,
                      height: 58,
                      decoration: BoxDecoration(
                        color: ColorsManager.backGroundFormsColor,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.12),
                            offset: Offset(2, 2),
                            blurRadius: 4,
                            spreadRadius: 0,
                            // هذا يمثل الـ inner shadow لكن للأسف Flutter لا يدعم مباشرة الـ inner shadow،
                            // هنستخدم Stack مع حيلة لو محتاج نفس التأثير.
                          ),
                        ],
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        '2',
                        style: TextStyles.styleMedium(
                          context,
                          fontSize: 20.sp,
                          color: ColorsManager.primaryColor,
                        ),
                      ),
                    ),
                    Container(
                      width: 58,
                      height: 58,
                      decoration: BoxDecoration(
                        color: ColorsManager.backGroundFormsColor,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.12),
                            offset: Offset(2, 2),
                            blurRadius: 4,
                            spreadRadius: 0,
                            // هذا يمثل الـ inner shadow لكن للأسف Flutter لا يدعم مباشرة الـ inner shadow،
                            // هنستخدم Stack مع حيلة لو محتاج نفس التأثير.
                          ),
                        ],
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        '2',
                        style: TextStyles.styleMedium(
                          context,
                          fontSize: 20.sp,
                          color: ColorsManager.primaryColor,
                        ),
                      ),
                    ),
                    Container(
                      width: 58,
                      height: 58,
                      decoration: BoxDecoration(
                        color: ColorsManager.backGroundFormsColor,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.12),
                            offset: Offset(2, 2),
                            blurRadius: 4,
                            spreadRadius: 0,
                            // هذا يمثل الـ inner shadow لكن للأسف Flutter لا يدعم مباشرة الـ inner shadow،
                            // هنستخدم Stack مع حيلة لو محتاج نفس التأثير.
                          ),
                        ],
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        '2',
                        style: TextStyles.styleMedium(
                          context,
                          fontSize: 20.sp,
                          color: ColorsManager.primaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 27.h),
              Text(
                "00:120 Sec",
                style: TextStyles.styleMedium(
                  context,
                  fontSize: 16.sp,
                  color: Color(0XFF464646),
                ),
              ),
              SizedBox(height: 26.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don’t receive code ? ",
                    style: TextStyles.styleMedium(
                      context,
                      fontSize: 16.sp,
                      color: Color(0XFF5A5A5A),
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Text(
                      "Re-send",
                      style: TextStyles.styleMedium(
                        context,
                        fontSize: 16.sp,
                        color: Color(0XFF5A5A5A),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
