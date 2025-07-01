import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shatably_app/core/themes/colors_manager.dart';
import 'package:shatably_app/core/themes/text_styles.dart';
import 'package:shatably_app/core/utils/app_icons.dart';
import 'package:shatably_app/core/utils/app_images.dart';

class AppointmentsScreen extends StatefulWidget {
  const AppointmentsScreen({super.key});

  @override
  State<AppointmentsScreen> createState() => _AppointmentsScreenState();
}

class _AppointmentsScreenState extends State<AppointmentsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0XFFE5F1EF),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 30.h),
            // Header
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0.w),
              child: Center(
                child: Text(
                  "All Appointments",
                  style: TextStyles.styleMedium(
                    context,
                    fontSize: 16.sp,
                    color: ColorsManager.primaryColor,
                  ),
                ),
              ),
            ),

            SizedBox(height: 19.h),
            // TabBar
            Container(
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
                controller: _tabController,
                labelColor: Colors.white,
                unselectedLabelColor: ColorsManager.primaryColor,
                indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(25.r),
                  color: ColorsManager.primaryColor,
                ),
                indicatorSize: TabBarIndicatorSize.tab,
                dividerColor: Colors.transparent,
                labelStyle: TextStyle(
                  fontSize: 11.5.sp,
                  fontWeight: FontWeight.w500,
                ),
                unselectedLabelStyle: TextStyle(
                  fontSize: 11.5.sp,
                  fontWeight: FontWeight.w500,
                ),
                tabs: const [Tab(text: 'Up Coming'), Tab(text: 'Completed')],
              ),
            ),
            SizedBox(height: 22.h),
            // TabBarView
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: const [
                  UpcomingAppointments(),
                  CompletedAppointments(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class UpcomingAppointments extends StatelessWidget {
  const UpcomingAppointments({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0.w),
      child: ListView(
        children: [
          AppointmentCard(
            name: "Mohamed Ahmed",
            profession: "Electrician · Plumber",
            date: "16 June 2025",
            time: "2PM to 5PM",
            duration: "3 Hours",
            profileImage: AppImages.menWorkerImage2,
            isUpcoming: true,
          ),
          SizedBox(height: 16.h),
          AppointmentCard(
            name: "Yasmen Karim",
            profession: "Carpenter",
            date: "16 June 2025",
            time: "2PM to 5PM",
            duration: "3 Hours",
            profileImage: AppImages.womanWorkerImage2,
            isUpcoming: true,
          ),
        ],
      ),
    );
  }
}

class CompletedAppointments extends StatelessWidget {
  const CompletedAppointments({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0.w),
      child: ListView(
        children: [
          AppointmentCard(
            name: "Mohamed Ahmed",
            profession: "Electrician · Plumber",
            date: "16 June 2025",
            time: "2PM to 5PM",
            duration: "3 Hours",
            profileImage: AppImages.menWorkerImage3,
            isUpcoming: false,
          ),
          SizedBox(height: 16.h),
          AppointmentCard(
            name: "Yasmen Karim",
            profession: "Carpenter",
            date: "16 June 2025",
            time: "2PM to 5PM",
            duration: "3 Hours",
            profileImage: AppImages.womanWorkerImage2,
            isUpcoming: false,
          ),
        ],
      ),
    );
  }
}

// AppointmentCard remains the same
class AppointmentCard extends StatelessWidget {
  final String name;
  final String profession;
  final String date;
  final String time;
  final String duration;
  final String profileImage;
  final bool isUpcoming;

  const AppointmentCard({
    super.key,
    required this.name,
    required this.profession,
    required this.date,
    required this.time,
    required this.duration,
    required this.profileImage,
    required this.isUpcoming,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0XFFE4E4E4),
        borderRadius: BorderRadius.circular(15.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha((0.25 * 255).toInt()),
            blurRadius: 2.3,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Profile Section
          Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: const Color(0xFFD7D7D7),
              borderRadius: BorderRadius.circular(10.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withAlpha((0.25 * 255).toInt()),
                  blurRadius: 2,
                ),
              ],
            ),
            child: Row(
              children: [
                // Profile Image
                Container(
                  width: 50.w,
                  height: 50.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0.r),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withAlpha((0.25 * 255).toInt()),
                        blurRadius: 1.2,
                        offset: const Offset(0, 1),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15.0.r),
                    child: Image.asset(profileImage, fit: BoxFit.cover),
                  ),
                ),
                SizedBox(width: 5.w),
                // Name and Profession
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        profession,
                        style: TextStyles.styleMedium(
                          context,
                          fontSize: 8.sp,
                          color: const Color(0XFF133741),
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        name,
                        style: TextStyles.styleMedium(
                          context,
                          fontSize: 13.sp,
                          color: const Color(
                            0XFF133741,
                          ).withAlpha((.67 * 255).toInt()),
                        ),
                      ),
                    ],
                  ),
                ),
                // Completed Status (only for completed appointments)
                if (!isUpcoming)
                  Text(
                    "Completed",
                    style: TextStyles.styleMedium(
                      context,
                      fontSize: 10.sp,
                      color: ColorsManager.yellowTextColor,
                    ),
                  ),
              ],
            ),
          ),

          isUpcoming ? SizedBox(height: 9.h) : SizedBox(height: 13.h),

          // Appointment Details
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // Date
              Row(
                children: [
                  SvgPicture.asset(
                    AppIcons.schedualeIcon,
                    width: 18.w,
                    height: 18.h,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(width: 4.w),
                  Text(
                    date,
                    style: TextStyles.styleMedium(
                      context,
                      fontSize: 10.sp,
                      color: ColorsManager.primaryColor.withAlpha(
                        (0.80 * 255).toInt(),
                      ),
                    ),
                  ),
                ],
              ),

              // Time
              Row(
                children: [
                  SvgPicture.asset(
                    AppIcons.clockIcon1,
                    width: 18.w,
                    height: 18.h,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(width: 4.w),
                  Text(
                    time,
                    style: TextStyles.styleMedium(
                      context,
                      fontSize: 10.sp,
                      color: ColorsManager.primaryColor.withAlpha(
                        (0.80 * 255).toInt(),
                      ),
                    ),
                  ),
                ],
              ),

              // Duration
              Row(
                children: [
                  SvgPicture.asset(
                    AppIcons.clockIcon2,
                    width: 18.w,
                    height: 18.h,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(width: 4.w),
                  Text(
                    duration,
                    style: TextStyles.styleMedium(
                      context,
                      fontSize: 10.sp,
                      color: ColorsManager.primaryColor.withAlpha(
                        (0.80 * 255).toInt(),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),

          // Action Buttons (only for upcoming appointments)
          if (isUpcoming) ...[
            SizedBox(height: 16.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Cancel Button
                Container(
                  width: 130.w,
                  height: 45.h,
                  decoration: BoxDecoration(
                    color: const Color(0XFFE4E4E4),
                    borderRadius: BorderRadius.circular(10.r),
                    border: Border.all(
                      color: const Color(0XFF6C5127),
                      width: 1,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withAlpha((0.25 * 255).toInt()),
                        blurRadius: 3.5,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: TextButton(
                    onPressed: () {},
                    child: Text(
                      "Cancel",
                      style: TextStyles.styleMedium(
                        context,
                        fontSize: 14.sp,
                        color: const Color(0XFF6C5127),
                      ),
                    ),
                  ),
                ),

                // Reschedule Button
                Container(
                  width: 130.w,
                  height: 45.h,
                  decoration: BoxDecoration(
                    color: ColorsManager.primaryColor,
                    borderRadius: BorderRadius.circular(10.r),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withAlpha((0.25 * 255).toInt()),
                        blurRadius: 3.5,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: TextButton(
                    onPressed: () {},
                    child: Text(
                      "Rescheduale",
                      style: TextStyles.styleMedium(
                        context,
                        fontSize: 14.sp,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}
