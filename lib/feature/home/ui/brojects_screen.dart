import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shatably_app/core/themes/colors_manager.dart';
import 'package:shatably_app/core/themes/text_styles.dart';
import 'package:shatably_app/core/utils/app_icons.dart';
import 'package:shatably_app/core/utils/app_images.dart';

class BrowseProjectsScreen extends StatelessWidget {
  const BrowseProjectsScreen({super.key});

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
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // App Bar
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
                        'Browse Projects',
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

            // Search Bar
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 15.h),
              child: Container(
                height: 50.h,
                decoration: BoxDecoration(
                  color: const Color(0xFFDADADA),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withAlpha((0.25 * 255).toInt()),
                      spreadRadius: 2,
                      blurRadius: 10.4,
                    ),
                  ],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextField(
                  textInputAction: TextInputAction.search,
                  decoration: InputDecoration(
                    hintText: 'Search for Projects',
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
                          AppIcons.searchIcon1,
                          color: ColorsManager.geryIconColor,
                        ),
                      ),
                    ),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 18.h,
                      horizontal: 16.w,
                    ),
                  ),
                ),
              ),
            ),

            // General Projects Label
            Padding(
              padding: EdgeInsets.only(left: 16.w, bottom: 10.h),
              child: Text(
                'General Projects',
                style: TextStyles.styleMedium(
                  context,
                  fontSize: 14.sp,
                  color: ColorsManager.primaryColor,
                ),
              ),
            ),

            // Projects List
            Expanded(
              child: ListView(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                children: [
                  // General Projects
                  ...generalProjects.map(
                    (project) => ProjectItem(project: project),
                  ),

                  // Coming Soon Label
                  Padding(
                    padding: EdgeInsets.only(top: 16.h, bottom: 8.h),
                    child: Text(
                      'Coming soon',
                      style: TextStyles.styleSemiBold(
                        context,
                        fontSize: 14.sp,
                        color: ColorsManager.primaryColor,
                      ),
                    ),
                  ),

                  // Coming Soon Projects
                  ...comingSoonProjects.map(
                    (project) => ProjectItem(project: project),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProjectItem extends StatelessWidget {
  final Map<String, dynamic> project;

  const ProjectItem({super.key, required this.project});

  @override
  Widget build(BuildContext context) {
    final bool isComingSoon = project['isComingSoon'] ?? false;
    final Color titleColor =
        isComingSoon
            ? Color(0xFFDDA853).withAlpha((0.47 * 255).toInt())
            : Color(0xFFDDA853);

    BoxDecoration decoration = BoxDecoration(
      color:
          isComingSoon
              ? Color(0XFFF7FCFB).withAlpha((20 * 255).toInt())
              : Color(0XFFF7FCFB),
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withAlpha((0.25 * 255).toInt()),
          // spreadRadius: 2,
          // blurRadius: 4,
          // offset: const Offset(0, 4),
        ),
      ],
      border:
          isComingSoon
              ? Border.all(
                color: Color(0xFFA6CDC6).withAlpha((.07 * 255).toInt()),
                width: 1,
              )
              : Border.all(color: Color(0xFFA6CDC6), width: 1),
    );

    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      height: 110.h, // حدّد ارتفاع الكارد
      decoration: decoration,
      child: Row(
        children: [
          // الصورة تأخذ مساحة العرض الثابتة وارتفاع كامل
          ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12),
              bottomLeft: Radius.circular(12),
            ),
            child: Image.asset(
              project['image'],
              width: 100.w,
              height: double.infinity, // هنا الصورة تمتد كامل الارتفاع
              fit: BoxFit.cover,
            ),
          ),

          // باقي البيانات
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    project['title'],
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyles.styleMedium(
                      context,
                      fontSize: 16.sp,
                      color: titleColor,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    project['description'],
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyles.styleRegular(
                      context,
                      fontSize: 10.sp,
                      color:
                          isComingSoon
                              ? ColorsManager.geryIconColor.withAlpha(
                                (.5 * 255).toInt(),
                              )
                              : ColorsManager.geryIconColor,
                    ),
                  ),
                  // Spacer(), // يدفع السهم لأسفل
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Container(
                      width: 25.w,
                      height: 25.h,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color:
                            isComingSoon
                                ? Colors.white.withAlpha((.5 * 255).toInt())
                                : Colors.white,

                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withAlpha((0.25 * 255).toInt()),
                            blurRadius: 4,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: SvgPicture.asset(AppIcons.yellowArrow),
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

// Sample data
final List<Map<String, dynamic>> generalProjects = [
  {
    'title': 'Handymen service package',
    'description': 'Reliable repair and maintenance services for your home.',
    'image': AppImages.browseBrojectImag,
    'isComingSoon': false,
  },
  {
    'title': 'Kitchen installation',
    'description':
        'Expert kitchen setup with precise fitting and smooth finishes.',
    'image': AppImages.browseBrojectImag,
    'isComingSoon': false,
  },
  {
    'title': 'Elegant finishes',
    'description':
        'Refined details and stylish touches that bring a polished look to your space.',
    'image': AppImages.browseBrojectImag,
    'isComingSoon': false,
  },
  {
    'title': 'Bathroom installation',
    'description':
        'Seamless bathroom setup with quality fixtures and a clean, modern look.',
    'image': AppImages.browseBrojectImag,
    'isComingSoon': false,
  },
  {
    'title': 'Gas installation',
    'description':
        'Safe and efficient gas setup for kitchens, heating, and more — handled by experts.',
    'image': AppImages.browseBrojectImag,
    'isComingSoon': false,
  },
];

final List<Map<String, dynamic>> comingSoonProjects = [
  {
    'title': 'Preparing the infrastructure',
    'description':
        'Foundational work to ensure your space is ready for safe and smooth installations.',
    'image': "assets/images/comingSoonImage.png",
    'isComingSoon': true,
  },
  {
    'title': 'Zero TO Hero',
    'description':
        'Complete home transformation from ground to finish — we handle it all, start to end.',
    'image': "assets/images/comingSoonImage.png",
    'isComingSoon': true,
  },
  {
    'title': 'Zero TO Hero',
    'description':
        'Complete home transformation from ground to finish — we handle it all, start to end.',
    'image': "assets/images/comingSoonImage.png",
    'isComingSoon': true,
  },
  {
    'title': 'Zero TO Hero',
    'description':
        'Complete home transformation from ground to finish — we handle it all, start to end.',
    'image': "assets/images/comingSoonImage.png",
    'isComingSoon': true,
  },
];
