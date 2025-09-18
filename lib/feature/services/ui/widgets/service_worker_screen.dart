import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shatably_app/core/themes/text_styles.dart';
import 'package:shatably_app/feature/services/ui/widgets/worker_card.dart';
import 'package:shatably_app/feature/services/ui/widgets/worker_info.dart';

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
                                ...workers.map(
                                  (worker) => WorkerCard(
                                    worker: worker,
                                    jobTitle: jobTitle,
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
}
