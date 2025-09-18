import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class ProjectDetailsShimmer extends StatelessWidget {
  const ProjectDetailsShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 30.h),
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                width: 30.w,
                height: 30.h,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(height: 27.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 282.w,
                  height: 179.h,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15.r),
                  ),
                ),
                SizedBox(width: 16.w),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: 50.w,
                      height: 50.h,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                    ),
                    SizedBox(height: 16.h),
                    Container(
                      width: 50.w,
                      height: 50.h,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                    ),
                    SizedBox(height: 16.h),
                    Container(
                      width: 50.w,
                      height: 50.h,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 28.h),
            Container(width: 150.w, height: 16.h, color: Colors.white),
            SizedBox(height: 12.h),
            Container(
              width: double.infinity,
              height: 14.h,
              color: Colors.white,
            ),
            SizedBox(height: 8.h),
            Container(
              width: double.infinity,
              height: 14.h,
              color: Colors.white,
            ),
            SizedBox(height: 8.h),
            Container(width: 200.w, height: 14.h, color: Colors.white),
            SizedBox(height: 22.h),
            Center(
              child: Container(width: 20.w, height: .5.h, color: Colors.white),
            ),
            SizedBox(height: 23.h),
            Container(width: 200.w, height: 16.h, color: Colors.white),
            SizedBox(height: 17.h),
            _buildShimmerReviewItem(),
            SizedBox(height: 16.h),
            _buildShimmerReviewItem(),
          ],
        ),
      ),
    );
  }

  Widget _buildShimmerReviewItem() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 30.w,
          height: 30.h,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
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
                  Container(width: 100.w, height: 10.h, color: Colors.white),
                  Container(width: 50.w, height: 8.h, color: Colors.white),
                ],
              ),
              SizedBox(height: 4.h),
              Row(
                children: List.generate(
                  5,
                  (index) => Padding(
                    padding: const EdgeInsets.only(right: 2.0),
                    child: Container(
                      width: 10.w,
                      height: 10.h,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 8.h),
              Container(
                width: double.infinity,
                height: 10.h,
                color: Colors.white,
              ),
              SizedBox(height: 4.h),
              Container(width: 150.w, height: 10.h, color: Colors.white),
            ],
          ),
        ),
      ],
    );
  }
}
