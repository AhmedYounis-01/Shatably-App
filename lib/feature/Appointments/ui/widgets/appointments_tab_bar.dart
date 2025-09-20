import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shatably_app/core/themes/colors_manager.dart';

class AppointmentsTabBar extends StatelessWidget {
  final TabController tabController;

  const AppointmentsTabBar({super.key, required this.tabController});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35.h,
      width: 200.w,
      margin: EdgeInsets.symmetric(horizontal: 16.0.w),
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 3.h),
      decoration: BoxDecoration(
        color: const Color(0XFFE5F1EF),
        borderRadius: BorderRadius.circular(25.r),
        border: Border.all(color: ColorsManager.primaryColor),
      ),
      child: TabBar(
        controller: tabController,
        labelColor: Colors.white,
        unselectedLabelColor: ColorsManager.primaryColor,
        indicator: BoxDecoration(
          borderRadius: BorderRadius.circular(25.r),
          color: ColorsManager.primaryColor,
        ),
        indicatorSize: TabBarIndicatorSize.tab,
        dividerColor: Colors.transparent,
        labelStyle: TextStyle(fontSize: 11.5.sp, fontWeight: FontWeight.w500),
        unselectedLabelStyle: TextStyle(
          fontSize: 11.5.sp,
          fontWeight: FontWeight.w500,
        ),
        tabs: const [Tab(text: 'Up Coming'), Tab(text: 'Completed')],
      ),
    );
  }
}
