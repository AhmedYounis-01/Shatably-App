// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shatably_app/core/themes/colors_manager.dart';
import 'package:shatably_app/core/themes/text_styles.dart';

class ServiceWorkerScreen extends StatelessWidget {
  final String title;
  final String backgroundImage;
  final Color backgroundColor;
  final double backgroundOpacity;
  final List<WorkerInfo> workers;
  final String workerIcon;

  const ServiceWorkerScreen({
    super.key,
    required this.title,
    required this.backgroundImage,
    required this.backgroundColor,
    this.backgroundOpacity = 0.227,
    required this.workers,
    required this.workerIcon,
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
          SafeArea(
            child: Column(
              children: [
                SizedBox(height: 30.h),
                // Back Button and Title
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {},
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
                      SizedBox(width: 30.w), // Balance the spacing
                    ],
                  ),
                ),

                Expanded(
                  child: Container(),
                ), // Push the worker list to the bottom
                // Workers Available Container
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 25.w,
                    vertical: 10.h,
                  ),
                  decoration: BoxDecoration(
                    color: backgroundColor.withOpacity(backgroundOpacity),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30.r),
                      topRight: Radius.circular(30.r),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.40),
                        offset: const Offset(0, -3),
                        blurRadius: 4,
                        // spreadRadius: 10,
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
                          // svg here
                          SvgPicture.asset(
                            workerIcon,
                            // AppIcons.electricianIcon,
                            width: 14.w,
                            height: 14.h,
                          ),
                          SizedBox(width: 4.w),
                          Text(
                            "Workers Available",
                            style: TextStyles.styleRegular(
                              context,
                              fontSize: 18.sp,
                              // fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 24.h),
                      // Workers List
                      ...workers
                          .map((worker) => _buildWorkerCard(context, worker))
                          .toList(),
                      SizedBox(height: 50.h), // Space for bottom navigation
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWorkerCard(BuildContext context, WorkerInfo worker) {
    return Container(
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
                  // color: Colors.red,
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
                          style: TextStyle(fontSize: 12.sp, color: Colors.grey),
                        ),
                        Spacer(),
                        Padding(
                          padding: EdgeInsets.only(top: 10.h),
                          child: Align(
                            alignment: Alignment.bottomRight,
                            child: InkWell(
                              onTap: () {},
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
    );
  }
}

class WorkerInfo {
  final String name;
  final String imagePath;
  final int rating;
  final int reviewCount;

  WorkerInfo({
    required this.name,
    required this.imagePath,
    required this.rating,
    required this.reviewCount,
  });
}
