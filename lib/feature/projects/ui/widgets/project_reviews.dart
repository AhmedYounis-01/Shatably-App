import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shatably_app/core/themes/colors_manager.dart';
import 'package:shatably_app/core/themes/text_styles.dart';
import 'package:shatably_app/core/utils/app_icons.dart';
import 'package:shatably_app/feature/projects/data/model/projects_model.dart';

class ProjectReviews extends StatelessWidget {
  final List<RatingReview> reviews;
  final List<String> reviewerNames;

  const ProjectReviews({
    super.key,
    required this.reviews,
    required this.reviewerNames,
  });

  @override
  Widget build(BuildContext context) {
    if (reviews.isEmpty) return const SizedBox.shrink();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Feedback and reviews",
          style: TextStyles.styleMedium(
            context,
            fontSize: 16.sp,
            color: ColorsManager.primaryColor,
          ),
        ),
        SizedBox(height: 17.h),
        ...reviews.asMap().entries.map((entry) {
          final int index = entry.key;
          final RatingReview review = entry.value;
          final String name =
              index < reviewerNames.length ? reviewerNames[index] : 'Anonymous';
          return Padding(
            padding: EdgeInsets.only(
              bottom: index < reviews.length - 1 ? 16.h : 0,
            ),
            child: _buildReviewItem(
              context,
              name: name,
              rating: review.rating.toInt(),
              comment: review.comment,
              daysAgo: _formatDateToDaysAgo(review.createdAt),
              avatarPath: AppIcons.personIcon,
            ),
          );
        }),
      ],
    );
  }

  String _formatDateToDaysAgo(DateTime date) {
    final Duration diff = DateTime.now().difference(date);
    if (diff.inDays > 0) {
      return '${diff.inDays} days ago';
    } else if (diff.inHours > 0) {
      return '${diff.inHours} hours ago';
    } else if (diff.inMinutes > 0) {
      return '${diff.inMinutes} minutes ago';
    } else {
      return 'just now';
    }
  }
}

Widget _buildReviewItem(
  BuildContext context, {
  required String name,
  required int rating,
  required String comment,
  required String daysAgo,
  String? avatarPath,
}) {
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
