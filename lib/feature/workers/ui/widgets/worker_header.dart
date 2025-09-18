import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shatably_app/core/themes/text_styles.dart';
import 'package:shatably_app/core/utils/app_icons.dart';
import 'package:shatably_app/feature/workers/ui/widgets/dashed_border_painter.dart';

class WorkerHeader extends StatelessWidget {
  final String providerName;
  final String profession;
  final String profileImage;
  final int yearsOfExperience;
  final double rating;
  final int currentPrice;

  const WorkerHeader({
    super.key,
    required this.providerName,
    required this.profession,
    required this.profileImage,
    required this.yearsOfExperience,
    required this.rating,
    required this.currentPrice,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 450.h,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(profileImage),
              fit: BoxFit.cover,
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
                providerName,
                style: TextStyles.styleSemiBold(
                  context,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w500,
                  color: const Color(0XFF133741),
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                profession,
                style: TextStyles.styleMedium(
                  context,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                  color: const Color(0XFF133741),
                ),
              ),
              SizedBox(height: 16.h),
              Row(
                children: [
                  Text(
                    "$currentPrice EGP",
                    style: TextStyles.styleMedium(
                      context,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                      color: const Color(0XFFDDA853),
                    ),
                  ),
                  Text(
                    " / Hour",
                    style: TextStyles.styleMedium(
                      context,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: const Color(0XFF133741),
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
                                '$yearsOfExperience Years',
                                style: TextStyles.styleRegular(
                                  context,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xFF002A32),
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Experience',
                                style: TextStyles.styleRegular(
                                  context,
                                  fontSize: 8.sp,
                                  color: Colors.grey,
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
                                '$rating',
                                style: TextStyles.styleRegular(
                                  context,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xFF002A32),
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Rating',
                                style: TextStyles.styleRegular(
                                  context,
                                  fontSize: 8.sp,
                                  color: Colors.grey,
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
}
