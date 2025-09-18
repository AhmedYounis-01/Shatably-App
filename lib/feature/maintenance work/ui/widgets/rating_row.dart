import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shatably_app/core/themes/text_styles.dart';

class MaintenanceRatingRow extends StatelessWidget {
  final BuildContext parentContext;
  final int? averageRating;
  final int? reviewCount;

  const MaintenanceRatingRow({
    super.key,
    required this.parentContext,
    required this.averageRating,
    required this.reviewCount,
  });

  @override
  Widget build(BuildContext context) {
    if (reviewCount == null || reviewCount == 0) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 23.w),
        child: Text(
          'No rating available',
          style: TextStyles.styleRegular(
            parentContext,
            fontSize: 14.sp,
            color: const Color(0XFF16404D).withAlpha((.5 * 255).toInt()),
          ),
        ),
      );
    }

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 23.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ...List.generate(5, (index) {
            return Icon(
              index < (averageRating ?? 0) ? Icons.star : Icons.star_border,
              color: const Color(0xFFDDA853),
              size: 20.h,
            );
          }),
          SizedBox(width: 4.w),
          Text(
            "(${reviewCount ?? 0})",
            style: TextStyles.styleRegular(
              parentContext,
              fontSize: 14.sp,
              color: const Color(0XFF16404D).withAlpha((.5 * 255).toInt()),
            ),
          ),
        ],
      ),
    );
  }
}
