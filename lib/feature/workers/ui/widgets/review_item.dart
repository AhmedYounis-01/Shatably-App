import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shatably_app/core/themes/colors_manager.dart';
import 'package:shatably_app/core/themes/text_styles.dart';
import 'package:shatably_app/core/utils/app_icons.dart';

class ReviewItem extends StatelessWidget {
  final String name;
  final int rating;
  final String comment;
  final String daysAgo;
  final String? avatarPath;

  const ReviewItem({
    super.key,
    required this.name,
    required this.rating,
    required this.comment,
    required this.daysAgo,
    this.avatarPath,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(25.r),
          child: Center(
            child: Image.asset(
              avatarPath ?? AppIcons.personIcon,
              fit: BoxFit.cover,
              width: 30.w,
              height: 30.h,
            ),
          ),
        ),
        SizedBox(width: 10.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    name,
                    style: TextStyles.styleSemiBold(
                      context,
                      fontSize: 10.sp,
                      color: ColorsManager.primaryColor.withAlpha(
                        (.88 * 255).toInt(),
                      ),
                    ),
                  ),
                  Text(
                    daysAgo,
                    style: TextStyles.styleRegular(
                      context,
                      fontSize: 8.sp,
                      color: ColorsManager.primaryColor.withAlpha(
                        (.55 * 255).toInt(),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 4.h),
              Row(
                children: List.generate(
                  5,
                  (index) => Icon(
                    index < rating ? Icons.star : Icons.star_border,
                    color: ColorsManager.yellowTextColor,
                    size: 10.sp,
                  ),
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                '"$comment"',
                style: TextStyles.styleRegular(
                  context,
                  fontSize: 10.sp,
                  color: ColorsManager.primaryColor.withAlpha(
                    (.84 * 255).toInt(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
