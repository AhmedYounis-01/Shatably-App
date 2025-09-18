import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class MaintenanceShimmerLoading extends StatelessWidget {
  const MaintenanceShimmerLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 400.h,
              color: Colors.white,
            ),
            Transform.translate(
              offset: Offset(0, -30.h),
              child: Container(
                padding: EdgeInsets.only(top: 12.h),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.r),
                    topRight: Radius.circular(30.r),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Container(
                        width: 25.w,
                        height: 2.h,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                      ),
                    ),
                    SizedBox(height: 14.5.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 26.w),
                      child: Container(
                        width: double.infinity,
                        height: 20.h,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 5.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 23.w),
                      child: Row(
                        children: [
                          ...List.generate(
                            5,
                            (index) => Container(
                              width: 20.h,
                              height: 20.h,
                              color: Colors.white,
                              margin: EdgeInsets.only(right: 4.w),
                            ),
                          ),
                          Container(
                            width: 50.w,
                            height: 15.h,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 28.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 26.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: const [
                          Expanded(child: _ShimmerFilterItem()),
                          Expanded(child: _ShimmerFilterItem()),
                          Expanded(child: _ShimmerFilterItem()),
                        ],
                      ),
                    ),
                    SizedBox(height: 20.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 26.w),
                      child: Container(
                        width: 80.w,
                        height: 20.h,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 26.w),
                      child: Column(
                        children: [
                          Container(
                            width: double.infinity,
                            height: 15.h,
                            color: Colors.white,
                            margin: EdgeInsets.only(bottom: 8.h),
                          ),
                          Container(
                            width: double.infinity,
                            height: 15.h,
                            color: Colors.white,
                            margin: EdgeInsets.only(bottom: 8.h),
                          ),
                          Container(
                            width: 150.w,
                            height: 15.h,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 40.h),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(vertical: 10.h),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(25.r),
                          topRight: Radius.circular(25.r),
                        ),
                      ),
                      child: Column(
                        children: [
                          SizedBox(height: 20.h),
                          Container(
                            width: 100.w,
                            height: 20.h,
                            color: Colors.white,
                          ),
                          SizedBox(height: 12.h),
                          Center(
                            child: Container(
                              width: 145.w,
                              height: 50.h,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(25.r),
                              ),
                            ),
                          ),
                          SizedBox(height: 80.h),
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
    );
  }
}

class _ShimmerFilterItem extends StatelessWidget {
  const _ShimmerFilterItem();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(width: 20.w, height: 20.h, color: Colors.white),
        SizedBox(width: 8.w),
        Container(width: 60.w, height: 15.h, color: Colors.white),
      ],
    );
  }
}
