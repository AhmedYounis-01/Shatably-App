import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shatably_app/core/themes/colors_manager.dart';
import 'package:shatably_app/core/themes/text_styles.dart';

class PaymentMethodWidget extends StatelessWidget {
  final String payIcon;
  final String title;
  final bool isSelected;
  final void Function()? onSelected;
  final IconData selectedRadioIcon;
  final IconData unselectedRadioIcon;

  const PaymentMethodWidget({
    super.key,
    required this.payIcon,
    required this.title,
    required this.isSelected,
    required this.onSelected,
    this.selectedRadioIcon = Icons.radio_button_checked,
    this.unselectedRadioIcon = Icons.radio_button_unchecked,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onSelected,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0XFFCCDBDF) : const Color(0XFFF7FCFB),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: const Color(0xFFA6CDC6), width: 1),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha((0.25 * 255).toInt()),
              blurRadius: 4,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 20.r,
              backgroundColor: const Color(0XFFBBBBBB),
              child: SvgPicture.asset(payIcon),
            ),
            SizedBox(width: 8.w),
            Text(
              title,
              style: TextStyles.styleMedium(
                context,
                fontSize: 12.sp,
                color:
                    isSelected
                        ? ColorsManager.primaryColor
                        : ColorsManager.primaryColor.withAlpha(
                          (.68 * 255).toInt(),
                        ),
              ),
            ),
            const Spacer(),
            Icon(
              isSelected ? selectedRadioIcon : unselectedRadioIcon,
              color: ColorsManager.primaryColor,
            ),
          ],
        ),
      ),
    );
  }
}
