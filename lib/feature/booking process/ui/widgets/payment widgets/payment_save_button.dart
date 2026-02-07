import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shatably_app/core/themes/text_styles.dart';
import 'package:shatably_app/core/widgets/custom_app_button1.dart';

class PaymentSaveButton extends StatelessWidget {
  final VoidCallback onPressed;

  const PaymentSaveButton({required this.onPressed, super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CustomAppButton1(
        onPressed: onPressed,
        width: 145.w,
        height: 50.h,
        borderRadius: 25.r,
        child: Text(
          "Save",
          style: TextStyles.styleMedium(
            context,
            fontSize: 16.sp,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
