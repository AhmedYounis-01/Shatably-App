// Services Page
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Import for SystemUiOverlayStyle
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shatably_app/core/helpers/extensions.dart';
import 'package:shatably_app/core/routes/routes.dart';
import 'package:shatably_app/core/themes/colors_manager.dart';
import 'package:shatably_app/core/themes/text_styles.dart';
import 'package:shatably_app/core/utils/app_icons.dart';

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
                  GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: Container(
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

                            suffixIcon: InkWell(
                              onTap: () {},

                              child: Padding(
                                padding: const EdgeInsets.all(12),

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
                          AppIcons.electricianIcon,
                        ),
                        _buildServiceCategory(
                          'Carpentry',
                          AppIcons.carpenterIcon,
                        ),
                        _buildServiceCategory('Painter', AppIcons.painterIcon),
                        _buildServiceCategory('Plumber', AppIcons.plumberIcon),
                        _buildServiceCategory(
                          'Cleaning',
                          AppIcons.housekeepingIcon,
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
                      spacing: 12.w,
                      runSpacing: 12.h,
                      children: [
                        _buildMaintenanceItem(
                          context,
                          'HVAC',
                          AppIcons.takyeefIcon,
                          "d893e691-1ee6-40d6-98b9-c46f4ab9b120",
                        ),
                        _buildMaintenanceItem(
                          context,
                          'Windows & Doors',
                          AppIcons.windowIcon,
                          "d893e691-1ee6-40d6-98b9-c46f4ab9b120",
                        ),
                        _buildMaintenanceItem(
                          context,
                          'Pest Control',
                          AppIcons.pestControlIcon,
                          "d8834625-486c-4471-8c06-557f41b1cf8d",
                        ),
                        _buildMaintenanceItem(
                          context,
                          'Water Purifier',
                          AppIcons.waterFilterIcon,
                          "62b5bf31-8b8c-438a-8030-f5fd437bb354",
                        ),
                        _buildMaintenanceItem(
                          context,
                          'Surveillance Cameras',
                          AppIcons.surveillanceCameraIcon,
                          "3d8ae543-7aaa-460d-b8a5-3e56dd55245e",
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

  Widget _buildServiceCategory(String? title, String icon) {
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
              child: SvgPicture.asset(icon, width: 26.w, height: 26.h),
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

  Widget _buildMaintenanceItem(
    BuildContext context,
    String? title,
    String icon,
    String? id,
  ) {
    return InkWell(
      onTap: () {
        context.pushNamed(Routes.maintenanceWorkScreen, arguments: id);
      },
      child: Container(
        width: 95,
        height: 95,
        decoration: BoxDecoration(
          color: Color(0XFFE5E3DB),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withAlpha((0.1 * 255).toInt()),
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
                child: SvgPicture.asset(icon, width: 26.w, height: 26.h),
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
      ),
    );
  }
}
