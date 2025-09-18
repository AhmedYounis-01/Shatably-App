import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shatably_app/core/themes/colors_manager.dart';
import 'package:shatably_app/core/themes/text_styles.dart';
import 'package:shatably_app/core/utils/app_icons.dart';
import 'package:shatably_app/core/widgets/custom_app_button1.dart';

class ProjectBottomBar extends StatelessWidget {
  final String title;
  final String hourServiceDisplay;
  final double price;
  final double? originalPrice;
  final VoidCallback onBookNow;

  const ProjectBottomBar({
    super.key,
    required this.title,
    required this.hourServiceDisplay,
    required this.price,
    required this.onBookNow,
    this.originalPrice,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: const Color(0XFFE5F1EF).withAlpha((.78 * 255).toInt()),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25.r),
            topRight: Radius.circular(25.r),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha((.26 * 255).toInt()),
              blurRadius: 11.2,
              spreadRadius: -5,
              offset: const Offset(0, -3),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyles.styleRegular(
                    context,
                    fontSize: 16,
                    color: ColorsManager.primaryColor,
                  ),
                ),
                const SizedBox(height: 7),
                Row(
                  children: [
                    const Icon(
                      Icons.access_time,
                      size: 18,
                      color: Colors.black54,
                    ),
                    const SizedBox(width: 2),
                    Text(
                      hourServiceDisplay,
                      style: TextStyles.styleRegular(
                        context,
                        fontSize: 16,
                        color: ColorsManager.primaryColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                CustomAppButton1(
                  onPressed: onBookNow,
                  width: 100.w,
                  height: 35.h,
                  backgroundColor: ColorsManager.primaryColor,
                  borderRadius: 25.r,
                  hasShadow: true,
                  child: Text(
                    'Book Now',
                    style: TextStyles.styleMedium(
                      context,
                      fontSize: 14.sp,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(height: 2.h),
                Row(
                  children: [
                    SvgPicture.asset(
                      AppIcons.discountIcon,
                      width: 25.w,
                      height: 25.h,
                    ),
                    Text(
                      '${price.toStringAsFixed(0)} EGP',
                      style: TextStyles.styleRegular(
                        context,
                        fontSize: 12.sp,
                        color: ColorsManager.primaryColor,
                      ),
                    ),
                    if (originalPrice != null) ...[
                      const SizedBox(width: 6),
                      Text(
                        '${originalPrice!.toInt()} EGP',
                        style: TextStyle(
                          fontSize: 10.sp,
                          color: ColorsManager.primaryColor.withAlpha(
                            (.55 * 255).toInt(),
                          ),
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
