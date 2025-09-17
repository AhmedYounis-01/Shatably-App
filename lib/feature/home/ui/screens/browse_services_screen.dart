import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shatably_app/core/themes/colors_manager.dart';
import 'package:shatably_app/core/themes/text_styles.dart';
import 'package:shatably_app/feature/home/ui/widgets/services widgets/services_app_bar.dart';
import 'package:shatably_app/feature/home/ui/widgets/services widgets/services_search_bar.dart';
import 'package:shatably_app/feature/home/ui/widgets/services widgets/small_services_section.dart';
import 'package:shatably_app/feature/home/ui/widgets/services widgets/maintenance_section.dart';

class BrowseServicesScreen extends StatelessWidget {
  const BrowseServicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Set system UI overlay style
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Color(0xFFE5F1EF),
        statusBarIconBrightness: Brightness.dark,
      ),
    );

    return Scaffold(
      backgroundColor: const Color(0xFFE5F1EF),
      // Use SafeArea to prevent content from overlapping with system UI
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 16.h),
            // Custom AppBar that respects status bar
            const ServicesAppBarRow(),
            // Main content
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 27.h),

                    // Search bar
                    const ServicesSearchBar(),

                    SizedBox(height: 18.h),

                    // Small Services
                    const SmallServicesSection(),

                    SizedBox(height: 18.h),

                    // Maintenance Work
                    Text(
                      'Maintenance Work',
                      style: TextStyles.styleSemiBold(
                        context,
                        fontSize: 14.sp,
                        color: ColorsManager.primaryColor,
                      ),
                    ),

                    SizedBox(height: 12.h),

                    // Maintenance Services Grid
                    const MaintenanceSection(),
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
