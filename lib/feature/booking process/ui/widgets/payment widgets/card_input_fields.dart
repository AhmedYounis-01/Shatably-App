import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shatably_app/core/themes/colors_manager.dart';
import 'package:shatably_app/core/themes/text_styles.dart';
import 'package:shatably_app/core/utils/app_icons.dart';
import 'package:shatably_app/core/widgets/custom_text_form_field2.dart';

class CardInputFields extends StatelessWidget {
  const CardInputFields({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Cardholder Name*",
                    style: TextStyles.styleMedium(
                      context,
                      fontSize: 14.sp,
                      color: ColorsManager.primaryColor,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  SizedBox(
                    height: 32.h,
                    child: CustomTextFormField2(
                      hintText: "Abdelrahman Morgan",
                      fontSize: 11.sp,
                      textAlign: TextAlign.start,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 14.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "CVV*",
                    style: TextStyles.styleMedium(
                      context,
                      fontSize: 14.sp,
                      color: ColorsManager.primaryColor,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  SizedBox(
                    height: 32.h,
                    child: CustomTextFormField2(
                      hintText: "035",
                      fontSize: 11.sp,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 11.h),
        SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Card Number*",
                style: TextStyles.styleMedium(
                  context,
                  fontSize: 14.sp,
                  color: ColorsManager.primaryColor,
                ),
              ),
              SizedBox(height: 4.h),
              SizedBox(
                height: 32.h,
                child: CustomTextFormField2(
                  hintText: "0000 0000 0000 0000",
                  fontSize: 11.sp,
                  textAlign: TextAlign.start,
                  hintWordSpacing: 10.w,
                  textWordSpacing: 10.w,
                  suffixIcon: AppIcons.bocketCard,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
