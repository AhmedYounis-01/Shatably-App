import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shatably_app/core/themes/colors_manager.dart';
import 'package:shatably_app/core/themes/text_styles.dart';

class PaymentSummary extends StatelessWidget {
  final double amount;
  const PaymentSummary({super.key, required this.amount});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              "Method",
              style: TextStyles.styleMedium(
                context,
                fontSize: 14.sp,
                color: ColorsManager.primaryColor.withAlpha(
                  (.50 * 255).toInt(),
                ),
              ),
            ),
            const Spacer(),
            Text(
              "Visa Card",
              style: TextStyles.styleMedium(
                context,
                fontSize: 14.sp,
                color: ColorsManager.primaryColor,
              ),
            ),
          ],
        ),
        SizedBox(height: 8.h),
        Row(
          children: [
            Text(
              "Account name:",
              style: TextStyles.styleMedium(
                context,
                fontSize: 14.sp,
                color: ColorsManager.primaryColor.withAlpha(
                  (.50 * 255).toInt(),
                ),
              ),
            ),
            const Spacer(),
            Text(
              "Abdelrahman Morgan",
              style: TextStyles.styleMedium(
                context,
                fontSize: 14.sp,
                color: ColorsManager.primaryColor,
              ),
            ),
          ],
        ),
        SizedBox(height: 8.h),
        Row(
          children: [
            Text(
              "Discount:",
              style: TextStyles.styleMedium(
                context,
                fontSize: 14.sp,
                color: ColorsManager.primaryColor.withAlpha(
                  (.50 * 255).toInt(),
                ),
              ),
            ),
            const Spacer(),
            Text(
              "25%",
              style: TextStyles.styleMedium(
                context,
                fontSize: 14.sp,
                color: ColorsManager.primaryColor,
              ),
            ),
          ],
        ),
        SizedBox(height: 8.h),
        Row(
          children: [
            Text(
              "Total:",
              style: TextStyles.styleMedium(
                context,
                fontSize: 14.sp,
                color: ColorsManager.primaryColor.withAlpha(
                  (.50 * 255).toInt(),
                ),
              ),
            ),
            const Spacer(),
            Text(
              amount.toString(),
              style: TextStyles.styleMedium(
                context,
                fontSize: 14.sp,
                color: ColorsManager.primaryColor,
              ).copyWith(
                shadows: [
                  Shadow(
                    blurRadius: 4.3,
                    color: Colors.black.withAlpha((.25 * 255).toInt()),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
