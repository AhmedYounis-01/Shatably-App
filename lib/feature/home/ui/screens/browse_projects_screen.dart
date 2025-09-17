import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shatably_app/core/themes/colors_manager.dart';
import 'package:shatably_app/core/themes/text_styles.dart';
import 'package:shatably_app/core/utils/app_icons.dart';
import 'package:shatably_app/core/utils/app_images.dart';
import 'package:shatably_app/core/widgets/custom_toast.dart';
import 'package:shatably_app/feature/projects/ui/projects_screen.dart';
import 'package:toastification/toastification.dart';
import 'package:shatably_app/feature/home/ui/widgets/projects widgets/projects_app_bar.dart';
import 'package:shatably_app/feature/home/ui/widgets/projects widgets/projects_search_bar.dart';

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
            const ProjectsAppBarRow(),

            // Search Bar
            const ProjectsSearchBar(),

            // Projects List
            Expanded(
              child: ListView(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                children: [
                  //!! General Projects Label
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

                  // General Projects
                  ListView.builder(
                    itemBuilder:
                        (context, index) => GeneralProjectItem(
                          project: generalProjects[index],
                          projectId: generalProjects[index]["id"]!,
                        ),
                    itemCount: generalProjects.length,
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
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
                    (project) => CoomingSoonItem(
                      project: project,
                      onPressed: () {
                        customToast(
                          context: context,
                          message: "Not Available Now",
                          type: ToastificationType.error,
                          icon: Icons.error,
                        );
                      },
                    ),
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

class GeneralProjectItem extends StatelessWidget {
  final Map<String, dynamic> project;
  final String projectId;

  const GeneralProjectItem({
    super.key,
    required this.project,
    required this.projectId,
  });

  @override
  Widget build(BuildContext context) {
    final bool isComingSoon = project['isComingSoon'] ?? false;
    final Color titleColor =
        isComingSoon
            ? const Color(0xFFDDA853).withAlpha((0.47 * 255).toInt())
            : const Color(0xFFDDA853);

    BoxDecoration decoration = BoxDecoration(
      color:
          isComingSoon
              ? const Color(0XFFF7FCFB).withAlpha((20 * 255).toInt())
              : const Color(0XFFF7FCFB),
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(color: Colors.black.withAlpha((0.25 * 255).toInt())),
      ],
      border:
          isComingSoon
              ? Border.all(
                color: const Color(0xFFA6CDC6).withAlpha((.07 * 255).toInt()),
                width: 1,
              )
              : Border.all(color: const Color(0xFFA6CDC6), width: 1),
    );

    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => ProjectsScreen(projectId: projectId),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 16.h),
        height: 110.h,
        decoration: decoration,
        child: Row(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                bottomLeft: Radius.circular(12),
              ),
              child: Image.asset(
                project['image'],
                width: 100.w,
                height: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
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
                              color: Colors.black.withAlpha(
                                (0.25 * 255).toInt(),
                              ),
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
      ),
    );
  }
}

class CoomingSoonItem extends StatelessWidget {
  final Map<String, dynamic> project;
  final void Function()? onPressed;

  const CoomingSoonItem({super.key, required this.project, this.onPressed});

  @override
  Widget build(BuildContext context) {
    final bool isComingSoon = project['isComingSoon'] ?? false;
    final Color titleColor =
        isComingSoon
            ? const Color(0xFFDDA853).withAlpha((0.47 * 255).toInt())
            : const Color(0xFFDDA853);

    BoxDecoration decoration = BoxDecoration(
      color:
          isComingSoon
              ? const Color(0XFFF7FCFB).withAlpha((20 * 255).toInt())
              : const Color(0XFFF7FCFB),
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(color: Colors.black.withAlpha((0.25 * 255).toInt())),
      ],
      border:
          isComingSoon
              ? Border.all(
                color: const Color(0xFFA6CDC6).withAlpha((.07 * 255).toInt()),
                width: 1,
              )
              : Border.all(color: const Color(0xFFA6CDC6), width: 1),
    );

    return GestureDetector(
      onTap: onPressed,
      child: Container(
        margin: EdgeInsets.only(bottom: 16.h),
        height: 110.h,
        decoration: decoration,
        child: Row(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                bottomLeft: Radius.circular(12),
              ),
              child: Image.asset(
                project['image'],
                width: 100.w,
                height: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
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
                              color: Colors.black.withAlpha(
                                (0.25 * 255).toInt(),
                              ),
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
      ),
    );
  }
}

// Sample data
final List<Map<String, dynamic>> generalProjects = [
  {
    "id": "faed0c7c-3e71-453d-9d27-aeaf0b4a1e42",
    'title': 'Handymen service package',
    'description': 'Reliable repair and maintenance services for your home.',
    'image': AppImages.browseBrojectImage,
    'isComingSoon': false,
  },
  {
    "id": "3f9f3c71-4f9e-4a7d-9820-b24e174d10eb",
    'title': 'Kitchen installation',
    'description':
        'Expert kitchen setup with precise fitting and smooth finishes.',
    'image': AppImages.browseBrojectImag1,
    'isComingSoon': false,
  },
  {
    "id": "836cf4d8-f804-4c63-90e0-040aa948a31c",
    'title': 'Elegant finishes',
    'description':
        'Refined details and stylish touches that bring a polished look to your space.',
    'image': AppImages.browseBrojectImag2,
    'isComingSoon': false,
  },
  {
    "id": "126d1f43-e166-4363-951f-fb6c3b8d2bd0",
    'title': 'Bathroom installation',
    'description':
        'Seamless bathroom setup with quality fixtures and a clean, modern look.',
    'image': AppImages.browseBrojectImag3,
    'isComingSoon': false,
  },
  {
    "id": "35d7e7be-4088-4525-9932-5bb551b27a5b",
    'title': 'Gas installation',
    'description':
        'Safe and efficient gas setup for kitchens, heating, and more — handled by experts.',
    'image': AppImages.browseBrojectImag4,
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
    'title': 'Air conditioning setup',
    'description':
        'Complete home transformation from ground to finish — we handle it all, start to end.',
    'image': "assets/images/comingSoonImage.png",
    'isComingSoon': true,
  },
  {
    'title': 'Door and window installation',
    'description':
        'Complete home transformation from ground to finish — we handle it all, start to end.',
    'image': "assets/images/comingSoonImage.png",
    'isComingSoon': true,
  },
];
