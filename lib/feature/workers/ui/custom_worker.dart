import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shatably_app/core/themes/colors_manager.dart';
import 'package:shatably_app/core/themes/text_styles.dart';
import 'package:shatably_app/core/utils/app_icons.dart';

class CustomWorkerScreen extends StatefulWidget {
  final String providerName;
  //! profession not used now
  final String profession;
  final String profileImage;

  const CustomWorkerScreen({
    super.key,
    required this.providerName,
    required this.profession,
    required this.profileImage,
  });

  @override
  State<CustomWorkerScreen> createState() => _CustomWorkerScreenState();
}

class _CustomWorkerScreenState extends State<CustomWorkerScreen> {
  bool showBookNowButton = true;
  bool showRatingButton = false;

  // Sample data
  final int currentPrice = 350;
  final int? originalPrice = null;
  final String serviceDuration = "1 Hour";
  final int yearsOfExperience = 10;
  final double rating = 4.9;
  final String aboutText =
      "Mohamed is a skilled and reliable electrician with years of hands-on experience. From fixing power issues to installing lighting and sockets, he delivers clean, safe, and efficient work every time. Book Mohamed for professional service you can trust.";

  final List<ReviewModel> reviews = [
    ReviewModel(
      name: "Khaled R",
      rating: 5,
      comment:
          "I was really impressed with how fast and professional the handyman was. He fixed everything I needed in just one visit—no stress, no mess! Definitely looking hire again.",
      daysAgo: 2,
    ),
    ReviewModel(
      name: "Youssef K",
      rating: 5,
      comment:
          "Very convenient! The handyman arrived on time and handled all the small repairs around my apartment. It saved me so much time and effort.",
      daysAgo: 3,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
    );
    return Scaffold(
      backgroundColor: Color(0XFFD9D8DB),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                // SizedBox(height: 50.h),
                // Header Section with Image and Navigation
                _buildHeaderSection(),

                // Main Content
                Transform.translate(
                  offset: Offset(0, -20.h), // سالب = يطلع لفوق
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(0XFFD9D8DB),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25.r),
                        topRight: Radius.circular(25.r),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withAlpha((.25 * 255).toInt()),
                          blurRadius: 4,
                          offset: const Offset(0, -2),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // About Section
                          _buildAboutSection(),

                          SizedBox(height: 23.h),

                          // Reviews Section
                          _buildReviewsSection(),

                          SizedBox(height: 100.h),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Bottom Action Buttons
          _buildBottomActionButtons(),
        ],
      ),
    );
  }

  Widget _buildHeaderSection() {
    return Stack(
      children: [
        // Background Image
        Container(
          height: 450.h,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(widget.profileImage),
              fit: BoxFit.cover,
              // colorFilter: ColorFilter.mode(
              //   Colors.black.withAlpha((0.25 * 255).toInt()),
              //   BlendMode.darken,
              // ),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withAlpha((0.15 * 255).toInt()),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
        ),

        // Provider Info Section
        Positioned(
          top: 40.h,
          left: 16.w,
          right: 16.w,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () => Navigator.of(context).pop(),
                child: Container(
                  width: 32.w,
                  height: 32.h,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFF85A19C),
                  ),
                  child: Center(
                    child: Icon(
                      Icons.arrow_back_ios_new,
                      color: Colors.white,
                      size: 16.sp,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 25.h),
              Text(
                widget.providerName,
                style: TextStyles.styleSemiBold(
                  context,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w500,
                  color: Color(0XFF133741),
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                widget.profession,
                style: TextStyles.styleMedium(
                  context,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                  color: Color(0XFF133741),
                ),
              ),
              SizedBox(height: 16.h),
              Row(
                children: [
                  Text(
                    "350 EGP",
                    style: TextStyles.styleMedium(
                      context,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                      color: Color(0XFFDDA853),
                    ),
                  ),
                  Text(
                    " / Hour",
                    style: TextStyles.styleMedium(
                      context,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: Color(0XFF133741),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.h),

              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10.r),
                    child: BackdropFilter(
                      filter: ui.ImageFilter.blur(sigmaX: 4.h, sigmaY: 4.w),
                      child: CustomPaint(
                        painter: DashedBorderPainter(
                          color: const Color(0xFF133741),
                          strokeWidth: 3.w,
                          dashWidth: 20.0,
                          dashSpace: 25.0,
                          borderRadius: BorderRadius.circular(5.r),
                        ),
                        child: Container(
                          width: 130.w,
                          height: 90.h,
                          decoration: BoxDecoration(
                            color: const Color(
                              0XFFA6CDC6,
                            ).withAlpha((0.78 * 255).toInt()),
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Align(
                                alignment: Alignment.topRight,
                                child: SvgPicture.asset(AppIcons.qualityIcon),
                              ),
                              Text(
                                '10 Years',
                                style: TextStyles.styleRegular(
                                  context,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xFF002A32),
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                'Experience',
                                style: TextStyles.styleRegular(
                                  context,
                                  fontSize: 8.sp,
                                  color: Colors.grey[700],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 13.h),
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10.r),
                    child: BackdropFilter(
                      filter: ui.ImageFilter.blur(sigmaX: 4.5.h, sigmaY: 4.5.w),
                      child: CustomPaint(
                        painter: DashedBorderPainter(
                          color: const Color(0xFF133741),
                          strokeWidth: 3.w,
                          dashWidth: 20.0,
                          dashSpace: 25.0,
                          borderRadius: BorderRadius.circular(5.r),
                        ),
                        child: Container(
                          width: 130.w,
                          height: 90.h,
                          decoration: BoxDecoration(
                            color: const Color(
                              0XFFA6CDC6,
                            ).withAlpha((0.78 * 255).toInt()),
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Align(
                                alignment: Alignment.topRight,
                                child: SvgPicture.asset(AppIcons.starIcon),
                              ),
                              Text(
                                '4.9',
                                style: TextStyles.styleRegular(
                                  context,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xFF002A32),
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                'Rating',
                                style: TextStyles.styleRegular(
                                  context,
                                  fontSize: 8.sp,
                                  color: Colors.grey[700],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAboutSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: Container(
            width: 24.w,
            height: .5.h,
            color: ColorsManager.primaryColor.withAlpha((.5 * 255).toInt()),
          ),
        ),
        SizedBox(height: 15.h),
        Text(
          "About",
          style: TextStyles.styleSemiBold(
            context,
            fontSize: 16.sp,
            color: ColorsManager.primaryColor,
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          aboutText,
          style: TextStyles.styleRegular(
            context,
            fontSize: 14.sp,
            color: ColorsManager.primaryColor.withAlpha((.82 * 255).toInt()),
          ),
        ),
        SizedBox(height: 22.h),
        Center(
          child: Container(
            width: 20.w,
            height: .5.h,
            color: ColorsManager.primaryColor.withAlpha((.5 * 255).toInt()),
          ),
        ),
      ],
    );
  }

  Widget _buildReviewsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
          ...reviews.asMap().entries.map((entry) {
            final int index = entry.key;
            final ReviewModel review = entry.value;
            return Padding(
              padding: EdgeInsets.only(
                bottom: index < reviews.length - 1 ? 16.h : 0,
              ),
              child: _buildReviewItem(
                context,
                name: review.name,
                rating: review.rating,
                comment: review.comment,
                daysAgo: "${review.daysAgo} days ago",
                avatarPath: AppIcons.personIcon,
              ),
            );
          }),
        ],
      ],
    );
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

  Widget _buildBottomActionButtons() {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      child: _buildHiringNowButton(),
    );
  }

  Widget _buildHiringNowButton() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: const Color(0XFFE5F1EF),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15.r),
          topRight: Radius.circular(15.r),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha((.26 * 255).toInt()),
            blurRadius: 4,
            // spreadRadius: -5,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 279.w,
            height: 45.h,
            decoration: BoxDecoration(
              color: ColorsManager.primaryColor,
              borderRadius: BorderRadius.circular(15.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withAlpha((.26 * 255).toInt()),
                  blurRadius: 9.5,
                  spreadRadius: -1,
                  offset: const Offset(0, -4),
                ),
              ],
            ),
            child: Row(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(width: 20.w),
                Expanded(
                  child: Text(
                    "Hiring Now",
                    textAlign: TextAlign.center,
                    style: TextStyles.styleMedium(
                      context,
                      fontSize: 14.sp,
                      color: Colors.white,
                    ),
                  ),
                ),
                Container(
                  width: 28.w,
                  height: 28.h,
                  margin: EdgeInsets.only(right: 10.w),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.black, width: 1.r),
                    shape: BoxShape.circle,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: SvgPicture.asset(AppIcons.yellowArrow3),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 15.w),
          PhysicalModel(
            color: Colors.transparent,
            shadowColor: Colors.black,
            elevation: 30.r,
            // shape: BoxShape.circle,
            child: SvgPicture.asset(
              AppIcons.chatIcon,
              width: 48.w,
              height: 48.h,
            ),
          ),
        ],
      ),
    );
  }
}

// Review Model
class ReviewModel {
  final String name;
  final int rating;
  final String comment;
  final int daysAgo;

  ReviewModel({
    required this.name,
    required this.rating,
    required this.comment,
    required this.daysAgo,
  });
}

class DashedBorderPainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final double dashWidth;
  final double dashSpace;
  final BorderRadius borderRadius;

  DashedBorderPainter({
    this.color = Colors.black,
    this.strokeWidth = 1.0,
    this.dashWidth = 5.0,
    this.dashSpace = 5.0,
    required this.borderRadius,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint =
        Paint()
          ..color = color
          ..strokeWidth = strokeWidth
          ..style = PaintingStyle.stroke;

    final RRect rRect = RRect.fromRectAndCorners(
      Offset.zero & size,
      topLeft: borderRadius.topLeft,
      topRight: borderRadius.topRight,
      bottomLeft: borderRadius.bottomLeft,
      bottomRight: borderRadius.bottomRight,
    );

    final Path path = Path()..addRRect(rRect);

    for (ui.PathMetric metric in path.computeMetrics()) {
      double distance = 0;
      while (distance < metric.length) {
        final double start = distance;
        final double end = (distance + dashWidth).clamp(0.0, metric.length);
        canvas.drawPath(metric.extractPath(start, end), paint);
        distance += dashWidth + dashSpace;
      }
    }
  }

  @override
  bool shouldRepaint(covariant DashedBorderPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.strokeWidth != strokeWidth ||
        oldDelegate.dashWidth != dashWidth ||
        oldDelegate.dashSpace != dashSpace ||
        oldDelegate.borderRadius != borderRadius;
  }
}
