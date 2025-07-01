import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shatably_app/core/themes/colors_manager.dart';
import 'package:shatably_app/core/themes/text_styles.dart';
import 'dart:ui';
import 'dart:math';
import 'package:shatably_app/feature/workers/ui/screens/worker_screen.dart';

class ServiceWorkerScreen extends StatelessWidget {
  final String title;
  final String backgroundImage;
  final Color backgroundColor;
  final double backgroundOpacity;
  final List<WorkerInfo> workers;
  final String workerIcon;
  final String jobTitle;
  final String workerProfileImage;

  const ServiceWorkerScreen({
    super.key,
    required this.title,
    required this.backgroundImage,
    required this.backgroundColor,
    this.backgroundOpacity = 0.227,
    required this.workers,
    required this.workerIcon,
    required this.jobTitle,
    required this.workerProfileImage,
  });

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
    );

    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Image.asset(backgroundImage, fit: BoxFit.cover),
          ),

          // Content
          Transform.translate(
            offset: Offset(0, 15.h),
            child: SafeArea(
              child: Column(
                children: [
                  SizedBox(height: 15.h),
                  // Back Button and Title
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
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
                        Expanded(
                          child: Center(
                            child: Text(
                              title,
                              style: TextStyle(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 30.w),
                      ],
                    ),
                  ),

                  Expanded(child: Container()),

                  ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30.r),
                      topRight: Radius.circular(30.r),
                    ),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 22.7, sigmaY: 22.7),
                      child: Stack(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 25.w,
                              vertical: 10.h,
                            ),
                            decoration: BoxDecoration(
                              color: backgroundColor.withAlpha(
                                (backgroundOpacity * 255).toInt(),
                                // backgroundOpacity,
                              ),

                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(30.r),
                                topRight: Radius.circular(30.r),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withAlpha(
                                    (0.25 * 255).toInt(),
                                  ),
                                  offset: const Offset(0, -3),
                                  blurRadius: 4,
                                  spreadRadius: 0,
                                ),
                              ],
                            ),

                            child: Column(
                              children: [
                                Container(
                                  width: 25.w,
                                  height: 1.h,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFE5F1EF),
                                    borderRadius: BorderRadius.circular(10.r),
                                  ),
                                ),
                                SizedBox(height: 12.5.h),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(
                                      workerIcon,
                                      width: 14.w,
                                      height: 14.h,
                                    ),
                                    SizedBox(width: 4.w),
                                    Text(
                                      "Workers Available",
                                      style: TextStyles.styleRegular(
                                        context,
                                        fontSize: 18.sp,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 24.h),
                                // Updated worker cards with navigation
                                ...workers.map(
                                  (worker) => _buildWorkerCard(
                                    context,
                                    worker,
                                    jobTitle: jobTitle,
                                    workerProfileImage: worker.imagePath,
                                  ),
                                ),
                                SizedBox(height: 25.h),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // First, update your _buildWorkerCard method to accept additional parameters
  Widget _buildWorkerCard(
    BuildContext context,
    WorkerInfo worker, {
    required String jobTitle,
    required String workerProfileImage,
  }) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context, rootNavigator: true).push(
          MaterialPageRoute(
            builder:
                (context) => WorkerScreen(
                  workerName: worker.name,
                  workerProf: jobTitle,
                  workerImage: workerProfileImage,
                ),
          ),
        );
        print(worker.name);
        print(jobTitle);
        print(workerProfileImage);
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 16.h),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 13.h),
        decoration: BoxDecoration(
          color: Color(0XFFF7FCFB),
          borderRadius: BorderRadius.circular(15.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top row with worker image and info
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Worker Image
                ClipRRect(
                  borderRadius: BorderRadius.circular(6.r),
                  child: Image.asset(
                    worker.imagePath,
                    width: 48.w,
                    height: 48.h,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(width: 10.w),
                // Worker Info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        worker.name,
                        style: TextStyles.styleRegular(
                          context,
                          fontSize: 16.sp,
                          color: ColorsManager.primaryColor,
                        ),
                      ),
                      Row(
                        children: [
                          // Rating Stars
                          ...List.generate(5, (index) {
                            return Icon(
                              index < worker.rating
                                  ? Icons.star
                                  : Icons.star_border,
                              color: const Color(0xFFDDA853),
                              size: 16.h,
                            );
                          }),
                          SizedBox(width: 4.w),
                          Text(
                            "(${worker.reviewCount})",
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: Colors.grey,
                            ),
                          ),
                          Spacer(),
                          Padding(
                            padding: EdgeInsets.only(top: 10.h),
                            child: Align(
                              alignment: Alignment.bottomRight,
                              child: Text(
                                "Book Now",
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w500,
                                  color: const Color(
                                    0xFFDDA853,
                                  ), // Golden yellow color
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
            ),
          ],
        ),
      ),
    );
  }
}

class WorkerInfo {
  final String name;
  final String imagePath;
  // final String profession;
  final int rating;
  final int reviewCount;

  WorkerInfo({
    required this.name,
    required this.imagePath,
    required this.rating,
    required this.reviewCount,
  });
}

// CustomPainter
class GrainyOverlayPainter extends CustomPainter {
  final Color grainColor;
  final double grainOpacity;
  final int density;

  GrainyOverlayPainter({
    this.grainColor = Colors.white,
    this.grainOpacity = 0.05,
    this.density = 2000,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final random = Random();
    final paint =
        Paint()
          ..color = grainColor.withAlpha(grainOpacity.toInt() * 255)
          ..strokeWidth = 1.0;

    for (int i = 0; i < density; i++) {
      final x = random.nextDouble() * size.width;
      final y = random.nextDouble() * size.height;
      canvas.drawPoints(PointMode.points, [Offset(x, y)], paint);
    }
  }

  @override
  bool shouldRepaint(covariant GrainyOverlayPainter oldDelegate) {
    return oldDelegate.grainColor != grainColor ||
        oldDelegate.grainOpacity != grainOpacity ||
        oldDelegate.density != density;
  }
}
