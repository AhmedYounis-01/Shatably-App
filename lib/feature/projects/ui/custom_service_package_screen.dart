// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shatably_app/core/themes/colors_manager.dart';
import 'package:shatably_app/core/themes/text_styles.dart';
import 'package:shatably_app/core/utils/app_icons.dart';
import 'package:shatably_app/core/utils/app_images.dart';
import 'package:shatably_app/core/widgets/custom_app_button1.dart';

class CustomServicePackageScreen extends StatelessWidget {
  // Service Details
  final String title;
  final String description;
  final String imagePath;
  final List<String>? thumbnailImages;

  // إضافة معاملات منفصلة للصور الثلاث
  final String firstThumbnail;
  final String secondThumbnail;
  final String thirdThumbnail;

  final String serviceDuration;
  final double currentPrice;
  final double? originalPrice;
  final bool isCompleted;

  // Review Data
  final List<ReviewItemModel> reviews;

  // Callbacks
  final VoidCallback onBackPressed;
  final VoidCallback onBookNowPressed;
  final VoidCallback? onGiveRatingPressed;

  // Control flags
  final bool showBookNowButton;
  final bool showRatingButton;

  const CustomServicePackageScreen({
    super.key,
    required this.title,
    required this.description,
    required this.imagePath,
    this.thumbnailImages,
    // إضافة المعاملات الجديدة للصور
    required this.firstThumbnail,
    required this.secondThumbnail,
    required this.thirdThumbnail,
    required this.serviceDuration,
    required this.currentPrice,
    this.originalPrice,
    this.isCompleted = false,
    required this.reviews,
    required this.onBackPressed,
    required this.onBookNowPressed,
    this.onGiveRatingPressed,
    this.showBookNowButton = true,
    this.showRatingButton = false,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE5F1EF),
      body: SafeArea(
        child: Stack(
          children: [
            // Scrollable content
            SingleChildScrollView(
              padding: EdgeInsets.only(
                bottom: 80.h,
              ), // Add padding for the fixed button
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 30.h),
                    // Back Button and Title
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: onBackPressed,
                          child: Container(
                            width: 30.w,
                            height: 30.h,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0xFFA6CDC6),
                            ),
                            child: Center(
                              child: SvgPicture.asset(
                                "assets/icons/arrow_ios.svg",
                                width: 15.w,
                                height: 15.h,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 45.w),
                        Expanded(
                          child: Center(
                            child: Text(
                              title,
                              style: TextStyles.styleRegular(
                                context,
                                fontSize: 16.sp,
                                color: ColorsManager.primaryColor,
                              ),
                            ),
                          ),
                        ),
                        if (isCompleted)
                          Center(
                            child: Text(
                              "Completed",
                              style: TextStyles.styleRegular(
                                context,
                                fontSize: 10.sp,
                                color: ColorsManager.yellowTextColor,
                              ),
                            ),
                          ),
                        if (isCompleted == false) Container(width: 47.w),
                      ],
                    ),

                    SizedBox(height: 27.h),
                    // Main image with thumbnails
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(15.r),
                          child: Container(
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withAlpha(
                                    (.25 * 255).toInt(),
                                  ),
                                  blurRadius: 4.2,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            width: 282.w,
                            height: 179.h,
                            child: Image.asset(imagePath, fit: BoxFit.cover),
                          ),
                        ),
                        SizedBox(width: 16.w),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            _buildThumbnail(firstThumbnail),
                            SizedBox(height: 16.h),
                            _buildThumbnail(secondThumbnail),
                            SizedBox(height: 16.h),
                            _buildThumbnail(thirdThumbnail),
                          ],
                        ),
                      ],
                    ),

                    SizedBox(height: 28.h),

                    // Service Title
                    Text(
                      title,
                      style: TextStyles.styleSemiBold(
                        context,
                        fontSize: 16.sp,
                        color: ColorsManager.primaryColor,
                      ),
                    ),

                    SizedBox(height: 12.h),

                    // Service Description
                    Text(
                      description,
                      style: TextStyles.styleRegular(
                        context,
                        fontSize: 14.sp,
                        color: ColorsManager.primaryColor.withAlpha(
                          (.82 * 255).toInt(),
                        ),
                      ),
                    ),

                    SizedBox(height: 22.h),
                    // line divider
                    Center(
                      child: Container(
                        width: 20.w,
                        height: .5.h,
                        color: ColorsManager.primaryColor.withAlpha(
                          (.5 * 255).toInt(),
                        ),
                      ),
                    ),
                    SizedBox(height: 23.h),

                    // Feedback and Reviews Section
                    if (reviews.isNotEmpty) ...[
                      Text(
                        "Feedback and reviews",
                        style: TextStyles.styleMedium(
                          context,
                          fontSize: 16.sp,
                          color: ColorsManager.primaryColor,
                        ),
                      ),

                      SizedBox(height: 17.h),

                      // Reviews list
                      ...reviews.asMap().entries.map((entry) {
                        final int index = entry.key;
                        final ReviewItemModel review = entry.value;
                        return Padding(
                          padding: EdgeInsets.only(
                            bottom: index < reviews.length - 1 ? 16.h : 0,
                          ),
                          child: _buildReviewItem(
                            context,
                            name: review.name,
                            rating: review.rating,
                            comment: review.comment,
                            daysAgo: review.daysAgo,
                            avatarPath: review.avatarPath,
                          ),
                        );
                      }),
                    ],

                    SizedBox(height: 30.h),
                  ],
                ),
              ),
            ),

            // Bottom Buttons - Choose between Book Now or Give Rating based on flags
            if (showBookNowButton)
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: Center(
                  // "Book Now" Button at bottom
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(
                        0XFFE5F1EF,
                      ).withAlpha((.78 * 255).toInt()),
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
                        /// Left Side: Title and Time
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
                                  serviceDuration,
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

                        /// Right Side: Button and Price
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            CustomAppButton1(
                              onPressed: onBookNowPressed,
                              width: 100.w,
                              height: 35.h,
                              backgroundColor: ColorsManager.primaryColor,
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
                                  '${currentPrice.toInt()} EGP',
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
                                      color: ColorsManager.primaryColor
                                          .withAlpha((.55 * 255).toInt()),
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
                ),
              ),

            // "Give Rating & Review" button (shown after service completion)
            if (showRatingButton && onGiveRatingPressed != null)
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  decoration: const BoxDecoration(color: Color(0xFFE5F1EF)),
                  child: GestureDetector(
                    onTap: onGiveRatingPressed,
                    child: Container(
                      width: double.infinity,
                      height: 50.h,
                      decoration: BoxDecoration(
                        color: const Color(0xFFE5F1EF),
                        borderRadius: BorderRadius.circular(10.r),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withAlpha((.25 * 255).toInt()),
                            offset: const Offset(0, -4),
                            blurRadius: 9.5,
                            spreadRadius: -1,
                          ),
                        ],
                      ),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(width: 10.w),
                            SvgPicture.asset(
                              AppIcons.reviewIcon,
                              width: 20.w,
                              height: 20.h,
                            ),
                            SizedBox(width: 11.w),
                            Text(
                              "Give Rating & Review",
                              style: TextStyles.styleRegular(
                                context,
                                fontSize: 14.sp,
                                color: ColorsManager.primaryColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildThumbnail(String imagePath) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8.r),
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha((.25 * 255).toInt()),
              blurRadius: 4,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        width: 50.w,
        height: 50.h,
        child: Image.asset(imagePath, fit: BoxFit.cover),
      ),
    );
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
      // User Avatar
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
            // Name and Date
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
            // Stars
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
            // Comment
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

// Model class for review items
class ReviewItemModel {
  final String name;
  final int rating;
  final String comment;
  final String daysAgo;
  final String? avatarPath;

  ReviewItemModel({
    required this.name,
    required this.rating,
    required this.comment,
    required this.daysAgo,
    this.avatarPath,
  });
}

 