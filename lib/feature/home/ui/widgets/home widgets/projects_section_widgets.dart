import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shatably_app/core/injection/injection_container.dart';
import 'package:shatably_app/core/themes/colors_manager.dart';
import 'package:shatably_app/core/utils/app_icons.dart';
import 'package:shatably_app/core/utils/app_images.dart';
import 'package:shatably_app/core/themes/text_styles.dart';
import 'package:shatably_app/feature/home/ui/screens/browse_projects_screen.dart';
import 'package:shatably_app/feature/projects/data/repository/projects_repository.dart';
import 'package:shatably_app/feature/projects/logic/cubit/projects_cubit.dart';
import 'package:shatably_app/feature/projects/ui/projects_screen.dart';

// Explore Projects Section Widget
class ExploreProjectsSection extends StatelessWidget {
  const ExploreProjectsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const ExploreProjectsHeader(),
        SizedBox(height: 12.h),
        SizedBox(
          height: 164.h,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: ProjectCategories.all.length,
            separatorBuilder: (context, index) => SizedBox(width: 12.5.w),
            itemBuilder: (context, index) {
              final project = ProjectCategories.all[index];
              return ProjectCategoryCard(
                project: project,
                onTap: () => navigateToProject(context, project.id),
              );
            },
          ),
        ),
      ],
    );
  }

  void navigateToProject(BuildContext context, String projectId) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder:
            (context) => BlocProvider(
              create: (context) => ProjectsCubit(sl<ProjectsRepository>()),
              child: ProjectsScreen(projectId: projectId),
            ),
      ),
    );
  }
}

// Explore Projects Header Widget
class ExploreProjectsHeader extends StatelessWidget {
  const ExploreProjectsHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Explore\nOur Projects',
          style: TextStyles.styleRegular(
            context,
            fontSize: 16.sp,
            color: ColorsManager.primaryColor,
          ),
        ),
        InkWell(
          onTap: () => navigateToBrowseProjects(context),
          child: Text(
            'View all',
            style: TextStyles.styleRegular(
              context,
              fontSize: 12.sp,
              color: ColorsManager.yellowTextColor,
            ),
          ),
        ),
      ],
    );
  }

  void navigateToBrowseProjects(BuildContext context) {
    Navigator.of(context, rootNavigator: false).push(
      MaterialPageRoute(builder: (context) => const BrowseProjectsScreen()),
    );
  }
}

// Project Category Card Widget
class ProjectCategoryCard extends StatelessWidget {
  const ProjectCategoryCard({
    super.key,
    required this.project,
    required this.onTap,
  });

  final ProjectCategory project;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 210.w,
        height: 164.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          image: DecorationImage(
            image: AssetImage(project.image),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            ProjectCardGradient(),
            ProjectCardDetails(project: project),
          ],
        ),
      ),
    );
  }
}

// Project Card Gradient Widget
class ProjectCardGradient extends StatelessWidget {
  const ProjectCardGradient({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.transparent,
            Colors.black.withAlpha((0.4 * 255).toInt()),
          ],
        ),
      ),
    );
  }
}

// Project Card Details Widget
class ProjectCardDetails extends StatelessWidget {
  const ProjectCardDetails({super.key, required this.project});

  final ProjectCategory project;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 10,
      left: 5,
      right: 5,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 5),
        decoration: BoxDecoration(
          color: Colors.grey.withAlpha((0.81 * 255).toInt()),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha((0.25 * 255).toInt()),
              blurRadius: 4,
            ),
          ],
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ProjectInfo(project: project),
            const SizedBox(width: 8),
            const ProjectArrowButton(),
          ],
        ),
      ),
    );
  }
}

// Project Info Widget
class ProjectInfo extends StatelessWidget {
  const ProjectInfo({super.key, required this.project});

  final ProjectCategory project;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Image.asset(AppImages.boltImage, width: 12.w, height: 12.h),
              const SizedBox(width: 2),
              Text(
                "From ${project.price}",
                style: TextStyles.styleRegular(
                  context,
                  fontSize: 10.sp,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          const SizedBox(height: 3),
          Text(
            project.title,
            style: TextStyles.styleRegular(
              context,
              fontSize: 12.sp,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

// Project Arrow Button Widget
class ProjectArrowButton extends StatelessWidget {
  const ProjectArrowButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 22.w,
      height: 22.h,
      decoration: const BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
      ),
      child: Padding(
        padding: EdgeInsets.all(5.sp),
        child: SvgPicture.asset(AppIcons.arrowRightIcon),
      ),
    );
  }
}

// Project Category Data Model
class ProjectCategory {
  final String id;
  final String title;
  final String image;
  final String price;

  const ProjectCategory({
    required this.id,
    required this.title,
    required this.image,
    required this.price,
  });
}

// Project Categories Data
class ProjectCategories {
  static List<ProjectCategory> get all => [
    const ProjectCategory(
      id: "faed0c7c-3e71-453d-9d27-aeaf0b4a1e42",
      title: "Handymen service package",
      image: AppImages.browseBrojectImage,
      price: "3000 EGP",
    ),
    const ProjectCategory(
      id: "3f9f3c71-4f9e-4a7d-9820-b24e174d10eb",
      title: "Kitchen installation",
      image: AppImages.browseBrojectImag1,
      price: "8000 EGP",
    ),
    const ProjectCategory(
      id: "836cf4d8-f804-4c63-90e0-040aa948a31c",
      title: "Elegant finishes",
      image: AppImages.browseBrojectImag2,
      price: "2000 EGP",
    ),
    const ProjectCategory(
      id: "126d1f43-e166-4363-951f-fb6c3b8d2bd0",
      title: "Bathroom installation",
      image: AppImages.browseBrojectImag3,
      price: "4000 EGP",
    ),
    const ProjectCategory(
      id: "35d7e7be-4088-4525-9932-5bb551b27a5b",
      title: "Gas installation",
      image: AppImages.browseBrojectImag4,
      price: "15000 EGP",
    ),
  ];
}
