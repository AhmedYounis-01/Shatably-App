import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shatably_app/core/themes/colors_manager.dart';
import 'package:shatably_app/core/themes/text_styles.dart';
import 'package:shatably_app/core/widgets/custom_toast.dart';
import 'package:shatably_app/feature/booking%20process/ui/screens/book_screen.dart';
import 'package:shatably_app/feature/projects/data/model/projects_model.dart';
import 'package:shatably_app/feature/projects/logic/cubit/projects_cubit.dart';
import 'package:shatably_app/feature/projects/logic/cubit/projects_state.dart';
import 'package:toastification/toastification.dart';
import 'package:shatably_app/feature/projects/ui/widgets/project_header_bar.dart';
import 'package:shatably_app/feature/projects/ui/widgets/project_gallery.dart';
import 'package:shatably_app/feature/projects/ui/widgets/project_reviews.dart';
import 'package:shatably_app/feature/projects/ui/widgets/project_bottom_bar.dart';
import 'package:shatably_app/feature/projects/ui/widgets/project_shimmer.dart';

class ProjectsScreen extends StatelessWidget {
  final String projectId;
  final double? originalPrice;
  final bool isCompleted;

  // final List<ReviewItemModel>? reviews;

  final VoidCallback? onBackPressed;
  final VoidCallback? onBookNowPressed;
  final VoidCallback? onGiveRatingPressed;

  final bool showBookNowButton;
  final bool showRatingButton;

  const ProjectsScreen({
    super.key,
    required this.projectId,
    // this.reviews,
    this.onBackPressed,
    this.onBookNowPressed,
    this.originalPrice,
    this.isCompleted = false,
    this.onGiveRatingPressed,
    this.showBookNowButton = true,
    this.showRatingButton = false,
  });

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
    );
    return Scaffold(
      backgroundColor: const Color(0xFFE5F1EF),
      body: BlocConsumer<ProjectsCubit, ProjectsState>(
        listener: (context, state) {
          if (state.status == ServicesStatus.error) {
            customToast(
              context: context,
              message: state.errorMessage ?? 'Failed to load project details.',
              type: ToastificationType.error,
              icon: Icons.error,
            );
          }
        },
        builder: (context, state) {
          if (state.projectsModel == null &&
              state.status != ServicesStatus.loading &&
              state.status != ServicesStatus.success) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              context.read<ProjectsCubit>().getProjectDetails(projectId);
            });
          }

          if (state.status == ServicesStatus.loading ||
              (state.projectsModel == null &&
                  state.status != ServicesStatus.error)) {
            return const ProjectDetailsShimmer();
          }
          if (state.status == ServicesStatus.error) {
            return Center(
              child: Text(
                state.errorMessage ?? 'Failed to load project details.',
              ),
            );
          }
          if (state.projectsModel == null) {
            return const Center(
              child: Text('Don\'t have any projects details yet.'),
            );
          }

          final ProjectsModel project = state.projectsModel!;

          return SafeArea(
            child: Stack(
              children: [
                SingleChildScrollView(
                  padding: EdgeInsets.only(bottom: 80.h),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 30.h),
                        ProjectHeaderBar(
                          title: project.title,
                          isCompleted: isCompleted,
                          onBackPressed: onBackPressed,
                        ),
                        SizedBox(height: 27.h),
                        ProjectGallery(
                          mainImageUrl: project.mainImageUrl,
                          imageUrls: project.imageUrls,
                        ),
                        SizedBox(height: 28.h),
                        Text(
                          project.title,
                          style: TextStyles.styleSemiBold(
                            context,
                            fontSize: 16.sp,
                            color: ColorsManager.primaryColor,
                          ),
                        ),
                        SizedBox(height: 12.h),
                        Text(
                          project.description,
                          style: TextStyles.styleRegular(
                            context,
                            fontSize: 14.sp,
                            color: ColorsManager.primaryColor.withAlpha(
                              (.82 * 255).toInt(),
                            ),
                          ),
                        ),
                        SizedBox(height: 22.h),
                        Center(
                          child: Container(
                            width: 20.w,
                            height: .5.h,
                            color: ColorsManager.primaryColor.withAlpha(
                              (.5 * 255).toInt(),
                            ),
                          ),
                        ),
                        SizedBox(height: 23.h),
                        ProjectReviews(
                          reviews: project.ratingReview,
                          reviewerNames:
                              feedBackNames.map((e) => e.name).toList(),
                        ),
                        SizedBox(height: 80.h),
                      ],
                    ),
                  ),
                ),
                if (showBookNowButton)
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: ProjectBottomBar(
                      title: project.title,
                      hourServiceDisplay: project.hourServiceDisplay,
                      price: state.projectsModel!.price,
                      originalPrice: originalPrice,
                      onBookNow: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder:
                                (context) => BookingScreen(
                                  image: state.projectsModel!.mainImageUrl,
                                  id: projectId,
                                  serviceType: "Projects",
                                ),
                          ),
                        );
                      },
                    ),
                  ),
                if (showRatingButton && onGiveRatingPressed != null)
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      decoration: const BoxDecoration(color: Color(0xFFE5F1EF)),
                      child: GestureDetector(
                        onTap: onGiveRatingPressed,
                        child: Container(
                          width: double.infinity,
                          height: 50.h,
                          decoration: BoxDecoration(
                            color: const Color(0xFFE5F1EF),
                            borderRadius: BorderRadius.circular(10.r),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withAlpha(
                                  (.25 * 255).toInt(),
                                ),
                                offset: const Offset(0, -4),
                                blurRadius: 9.5,
                                spreadRadius: -1,
                              ),
                            ],
                          ),
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(width: 10.w),
                                // review icon kept inside header imports originally
                                SizedBox(width: 11.w),
                                Text(
                                  "Give Rating & Review",
                                  style: TextStyles.styleRegular(
                                    context,
                                    fontSize: 14.sp,
                                    color: ColorsManager.primaryColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}

// model for feedback names
class FeedBackNamesModel {
  final String name;

  FeedBackNamesModel(this.name);
}

//class for data
final List<FeedBackNamesModel> feedBackNames = [
  FeedBackNamesModel('Mohamed Ali'),
  FeedBackNamesModel('Ahmed Fady'),
  FeedBackNamesModel('Mona Ahmed'),
  FeedBackNamesModel('Dina Mohamed'),
  FeedBackNamesModel('Mohamed Ali'),
  FeedBackNamesModel('Ahmed Fady'),
  FeedBackNamesModel('Mona Ahmed'),
  FeedBackNamesModel('Dina Mohamed'),
];
