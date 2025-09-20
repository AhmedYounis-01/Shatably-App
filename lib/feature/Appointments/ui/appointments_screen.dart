import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shatably_app/core/themes/colors_manager.dart';
import 'package:shatably_app/core/themes/text_styles.dart';
import 'package:shatably_app/feature/Appointments/ui/widgets/appointments_tab_bar.dart';
import 'package:shatably_app/feature/Appointments/ui/widgets/upcoming_appointments.dart';
import 'package:shatably_app/feature/Appointments/ui/widgets/completed_appointments.dart';

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
            AppointmentsTabBar(tabController: _tabController),
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
