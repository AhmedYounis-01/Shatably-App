import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shatably_app/core/themes/colors_manager.dart';

class PaymentMethodSelection extends StatelessWidget {
  final List<Map<String, dynamic>> paymentMethods;
  final int? selectedIndex;
  final void Function(int) onSelect;

  const PaymentMethodSelection({
    super.key,
    required this.paymentMethods,
    required this.selectedIndex,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(
        paymentMethods.length,
        (index) => Expanded(
          child: GestureDetector(
            onTap: () => onSelect(index),
            child: Container(
              height: 50.h,
              margin: EdgeInsets.only(
                right: index < paymentMethods.length - 1 ? 8.w : 0,
              ),
              decoration: BoxDecoration(
                color:
                    selectedIndex == index
                        ? ColorsManager.primaryColor
                        : Colors.transparent,
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(
                  color: ColorsManager.primaryColor,
                  width: selectedIndex == index ? 1.w : .5.w,
                ),
              ),
              child: Center(
                child: SvgPicture.asset(
                  paymentMethods[index]["icon"],
                  colorFilter:
                      index == 0
                          ? null
                          : ColorFilter.mode(
                            selectedIndex == index
                                ? Colors.white
                                : ColorsManager.primaryColor,
                            BlendMode.srcIn,
                          ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
