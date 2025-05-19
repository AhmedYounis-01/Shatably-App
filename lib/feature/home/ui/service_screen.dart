// Services Page
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Import for SystemUiOverlayStyle
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shatably_app/core/themes/colors_manager.dart';
import 'package:shatably_app/core/themes/text_styles.dart';
import 'package:shatably_app/core/utils/app_icons.dart';
import 'package:shatably_app/core/utils/app_images.dart';

class ServicesScreen extends StatelessWidget {
  const ServicesScreen({super.key});

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
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              child: Row(
                children: [
                  Container(
                    width: 30.w,
                    height: 30.h,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0XFFA6CDC6),
                    ),
                    child: Center(
                      child: SvgPicture.asset(
                        "assets/icons/arrow_ios.svg",
                        width: 15.w,
                        height: 15.h,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: Text(
                        'Browse Services',
                        style: TextStyles.styleMedium(
                          context,
                          fontSize: 18,
                          color: ColorsManager.primaryColor,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 41.w), // Balancing the back button width
                ],
              ),
            ),

            // Main content
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 27.h),

                    // Search bar
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 2),
                      child: Container(
                        // height: 54.h,
                        height: 50.h,
                        decoration: BoxDecoration(
                          color: Color(0xFFDADADA),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withAlpha(
                                (0.25 * 255).toInt(),
                              ),
                              spreadRadius: 2,
                              blurRadius: 10.4,
                            ),
                          ],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: TextField(
                          // controller: _searchController,
                          textInputAction: TextInputAction.search,
                          // onSubmitted: _searchLocation,
                          decoration: InputDecoration(
                            hintText: 'Search for service',
                            hintStyle: TextStyles.styleRegular(
                              context,
                              fontSize: 14.sp,
                              color: ColorsManager.geryIconColor,
                            ),
                            // prefixIcon: Icon(
                            //   Icons.location_on_outlined,
                            //   color: ColorsManager.geryIconColor,
                            // ),
                            suffixIcon: InkWell(
                              onTap: () {},
                              // onTap:
                              // () => _searchLocation(_searchController.text),
                              child: Padding(
                                padding: const EdgeInsets.all(12),

                                // child: SvgPicture.asset(
                                //   AppIcons.searchIcon1,

                                //   color: ColorsManager.geryIconColor,
                                // ),
                                child: Image.asset(
                                  // width: 14,
                                  // height: 14,
                                  AppIcons.searchIcon1,
                                  color: ColorsManager.geryIconColor,
                                ),
                              ),
                            ),
                            border: InputBorder.none,
                            // contentPadding: EdgeInsets.symmetric(vertical: 23.h),
                            contentPadding: EdgeInsets.symmetric(
                              vertical: 18.h,
                              horizontal: 16.w,
                            ),
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: 18.h),

                    // Small Services
                    Text(
                      'Small Services',
                      style: TextStyles.styleSemiBold(
                        context,
                        fontSize: 14.sp,
                        color: ColorsManager.primaryColor,
                      ),
                    ),

                    SizedBox(height: 11.h),
                    Wrap(
                      spacing: 12.w, // المسافة الأفقية بين العناصر
                      runSpacing: 12.h, // المسافة الرأسية بين الصفوف
                      children: [
                        _buildServiceCategory(
                          'Electrician',
                          Icons.electrical_services,
                        ),
                        _buildServiceCategory('Carpentry', Icons.handyman),
                        _buildServiceCategory('Painter', Icons.format_paint),
                        _buildServiceCategory('Plumber', Icons.plumbing),
                        _buildServiceCategory(
                          'Cleaning',
                          Icons.cleaning_services,
                        ),
                      ],
                    ),

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
                    Wrap(
                      spacing: 12.w, // المسافة الأفقية بين العناصر
                      runSpacing: 12.h, // المسافة الرأسية بين الصفوف
                      children: [
                        _buildMaintenanceItem('HVAC', Icons.air),
                        _buildMaintenanceItem('Windows & Doors', Icons.window),
                        _buildMaintenanceItem(
                          'Pest Control',
                          Icons.pest_control,
                        ),
                        _buildMaintenanceItem(
                          'Water Purifier',
                          Icons.water_drop,
                        ),
                        _buildMaintenanceItem(
                          'Surveillance Cameras',
                          Icons.videocam,
                        ),
                      ],
                    ),

                    SizedBox(height: 50.h), // Add space for bottom navigation
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildServiceCategory(String? title, IconData icon) {
    return Container(
      width: 95,
      height: 95,
      decoration: BoxDecoration(
        color: Color(0XFFE5E3DB),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 2,
          ),
        ],
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            CircleAvatar(
              backgroundColor: Colors.white,
              child: SvgPicture.asset(AppImages.electricianImage),
            ),
            SizedBox(height: 2.h),

            Text(
              textAlign: TextAlign.center,

              title ?? "Electrician",
              style: TextStyles.styleRegular(
                null,
                fontSize: 12,
                color: ColorsManager.primaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMaintenanceItem(String? title, IconData icon) {
    return Container(
      width: 95,
      height: 95,
      decoration: BoxDecoration(
        color: Color(0XFFE5E3DB),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 2,
          ),
        ],
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            CircleAvatar(
              backgroundColor: Colors.white,
              child: SvgPicture.asset(AppIcons.takyeefIcon),
            ),
            SizedBox(height: 2.h),

            Text(
              textAlign: TextAlign.center,
              title ?? "Electrician",
              style: TextStyles.styleRegular(
                null,
                fontSize: 12,
                color: ColorsManager.primaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
