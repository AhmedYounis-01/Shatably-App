import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shatably_app/core/themes/colors_manager.dart';
import 'package:shatably_app/core/themes/text_styles.dart';
import 'package:shatably_app/feature/workers/data/models/review_model.dart';
import 'package:shatably_app/feature/workers/ui/widgets/review_item.dart';

class WorkerReviews extends StatelessWidget {
  final List<ReviewModel> reviews;

  const WorkerReviews({super.key, required this.reviews});

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
          final ReviewModel review = entry.value;
          return Padding(
            padding: EdgeInsets.only(
              bottom: index < reviews.length - 1 ? 16.h : 0,
            ),
            child: ReviewItem(
              name: review.name,
              rating: review.rating,
              comment: review.comment,
              daysAgo: "${review.daysAgo} days ago",
            ),
          );
        }),
      ],
    );
  }
}
