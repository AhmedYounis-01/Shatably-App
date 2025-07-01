import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shatably_app/core/themes/colors_manager.dart';
import 'package:shatably_app/core/themes/text_styles.dart';
import 'package:shatably_app/core/utils/app_icons.dart';
import 'package:shatably_app/core/widgets/custom_app_button1.dart';
import 'package:shatably_app/core/widgets/custom_toast.dart';
import 'package:shatably_app/feature/booking%20process/ui/screens/book_screen.dart';
import 'package:shatably_app/feature/projects/data/model/projects_model.dart';
import 'package:shatably_app/feature/projects/logic/cubit/projects_cubit.dart';
import 'package:shatably_app/feature/projects/logic/cubit/projects_state.dart';
import 'package:shimmer/shimmer.dart';
import 'package:toastification/toastification.dart';

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
            return _buildShimmerLoading(context);
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap:
                                  onBackPressed ??
                                  () => Navigator.of(context).pop(),
                              child: Container(
                                width: 30.w,
                                height: 30.h,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color(0xFFA6CDC6),
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
                            SizedBox(width: 45.w),
                            Expanded(
                              child: Center(
                                child: Text(
                                  project.title,
                                  style: TextStyles.styleRegular(
                                    context,
                                    fontSize: 16.sp,
                                    color: ColorsManager.primaryColor,
                                  ),
                                ),
                              ),
                            ),
                            if (isCompleted)
                              Center(
                                child: Text(
                                  "Completed",
                                  style: TextStyles.styleRegular(
                                    context,
                                    fontSize: 10.sp,
                                    color: ColorsManager.yellowTextColor,
                                  ),
                                ),
                              ),
                            if (!isCompleted) Container(width: 47.w),
                          ],
                        ),
                        SizedBox(height: 27.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(15.r),
                              child: Container(
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withAlpha(
                                        (.25 * 255).toInt(),
                                      ),
                                      blurRadius: 4.2,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
                                width: 282.w,
                                height: 179.h,
                                child: CachedNetworkImage(
                                  imageUrl: project.mainImageUrl,
                                  placeholder:
                                      (context, url) => Shimmer.fromColors(
                                        baseColor: Colors.grey[300]!,
                                        highlightColor: Colors.grey[100]!,
                                        child: Container(
                                          width: 282.w,
                                          height: 179.h,
                                          color: Colors.white,
                                        ),
                                      ),
                                  errorWidget:
                                      (context, url, error) =>
                                          const Icon(Icons.error),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            SizedBox(width: 16.w),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                if (project.imageUrls.isNotEmpty)
                                  _buildThumbnail(project.imageUrls[0]),
                                SizedBox(height: 16.h),
                                if (project.imageUrls.length > 1)
                                  _buildThumbnail(project.imageUrls[1]),
                                SizedBox(height: 16.h),
                                if (project.imageUrls.length > 2)
                                  _buildThumbnail(project.imageUrls[2]),
                              ],
                            ),
                          ],
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
                        if (project.ratingReview.isNotEmpty) ...[
                          Text(
                            "Feedback and reviews",
                            style: TextStyles.styleMedium(
                              context,
                              fontSize: 16.sp,
                              color: ColorsManager.primaryColor,
                            ),
                          ),
                          SizedBox(height: 17.h),
                          ...project.ratingReview.asMap().entries.map((entry) {
                            final int index = entry.key;
                            final RatingReview review = entry.value;
                            return Padding(
                              padding: EdgeInsets.only(
                                bottom:
                                    index < project.ratingReview.length - 1
                                        ? 16.h
                                        : 0,
                              ),
                              child: _buildReviewItem(
                                context,
                                name: feedBackNames[index].name,
                                rating: review.rating.toInt(),
                                comment: review.comment,
                                daysAgo: _formatDateToDaysAgo(review.createdAt),
                                avatarPath: AppIcons.personIcon,
                              ),
                            );
                          }),
                        ],
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
                    child: Center(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(
                            0XFFE5F1EF,
                          ).withAlpha((.78 * 255).toInt()),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(25.r),
                            topRight: Radius.circular(25.r),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withAlpha(
                                (.26 * 255).toInt(),
                              ),
                              blurRadius: 11.2,
                              spreadRadius: -5,
                              offset: const Offset(0, -3),
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  project.title,
                                  style: TextStyles.styleRegular(
                                    context,
                                    fontSize: 16,
                                    color: ColorsManager.primaryColor,
                                  ),
                                ),
                                const SizedBox(height: 7),
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.access_time,
                                      size: 18,
                                      color: Colors.black54,
                                    ),
                                    const SizedBox(width: 2),
                                    Text(
                                      project.hourServiceDisplay,
                                      style: TextStyles.styleRegular(
                                        context,
                                        fontSize: 16,
                                        color: ColorsManager.primaryColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                CustomAppButton1(
                                  onPressed: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder:
                                            (context) => BookingScreen(
                                              image:
                                                  state
                                                      .projectsModel!
                                                      .mainImageUrl,
                                              id: projectId,
                                              serviceType: "Projects",
                                            ),
                                      ),
                                    );
                                    print(
                                      'Book Now Button Tapped_____________________',
                                    );
                                    print('Project ID: $projectId');
                                    print(
                                      'Image URL: ${state.projectsModel!.mainImageUrl}',
                                    );
                                  },
                                  width: 100.w,
                                  height: 35.h,
                                  backgroundColor: ColorsManager.primaryColor,
                                  borderRadius: 25.r,
                                  hasShadow: true,
                                  child: Text(
                                    'Book Now',
                                    style: TextStyles.styleMedium(
                                      context,
                                      fontSize: 14.sp,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 2.h),
                                Row(
                                  children: [
                                    SvgPicture.asset(
                                      AppIcons.discountIcon,
                                      width: 25.w,
                                      height: 25.h,
                                    ),
                                    Text(
                                      '${state.projectsModel!.price} EGP',
                                      style: TextStyles.styleRegular(
                                        context,
                                        fontSize: 12.sp,
                                        color: ColorsManager.primaryColor,
                                      ),
                                    ),
                                    if (originalPrice != null) ...[
                                      const SizedBox(width: 6),
                                      Text(
                                        '${originalPrice!.toInt()} EGP',
                                        style: TextStyle(
                                          fontSize: 10.sp,
                                          color: ColorsManager.primaryColor
                                              .withAlpha((.55 * 255).toInt()),
                                          decoration:
                                              TextDecoration.lineThrough,
                                        ),
                                      ),
                                    ],
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
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
                                SvgPicture.asset(
                                  AppIcons.reviewIcon,
                                  width: 20.w,
                                  height: 20.h,
                                ),
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

  Widget _buildThumbnail(String imageUrl) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8.r),
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha((.25 * 255).toInt()),
              blurRadius: 4,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        width: 50.w,
        height: 50.h,
        child: CachedNetworkImage(
          imageUrl: imageUrl,
          placeholder:
              (context, url) => Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Container(
                  width: 50.w,
                  height: 50.h,
                  color: Colors.white,
                ),
              ),
          errorWidget: (context, url, error) => const Icon(Icons.error),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  //* shimmer
  Widget _buildShimmerLoading(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 30.h),
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                width: 30.w,
                height: 30.h,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(height: 27.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 282.w,
                  height: 179.h,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15.r),
                  ),
                ),
                SizedBox(width: 16.w),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: 50.w,
                      height: 50.h,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                    ),
                    SizedBox(height: 16.h),
                    Container(
                      width: 50.w,
                      height: 50.h,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                    ),
                    SizedBox(height: 16.h),
                    Container(
                      width: 50.w,
                      height: 50.h,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 28.h),
            Container(width: 150.w, height: 16.h, color: Colors.white),
            SizedBox(height: 12.h),
            Container(
              width: double.infinity,
              height: 14.h,
              color: Colors.white,
            ),
            SizedBox(height: 8.h),
            Container(
              width: double.infinity,
              height: 14.h,
              color: Colors.white,
            ),
            SizedBox(height: 8.h),
            Container(width: 200.w, height: 14.h, color: Colors.white),
            SizedBox(height: 22.h),
            Center(
              child: Container(width: 20.w, height: .5.h, color: Colors.white),
            ),
            SizedBox(height: 23.h),
            Container(width: 200.w, height: 16.h, color: Colors.white),
            SizedBox(height: 17.h),
            _buildShimmerReviewItem(),
            SizedBox(height: 16.h),
            _buildShimmerReviewItem(),
          ],
        ),
      ),
    );
  }

  Widget _buildShimmerReviewItem() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 30.w,
          height: 30.h,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
          ),
        ),
        SizedBox(width: 10.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(width: 100.w, height: 10.h, color: Colors.white),
                  Container(width: 50.w, height: 8.h, color: Colors.white),
                ],
              ),
              SizedBox(height: 4.h),
              Row(
                children: List.generate(
                  5,
                  (index) => Padding(
                    padding: const EdgeInsets.only(right: 2.0),
                    child: Container(
                      width: 10.w,
                      height: 10.h,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 8.h),
              Container(
                width: double.infinity,
                height: 10.h,
                color: Colors.white,
              ),
              SizedBox(height: 4.h),
              Container(width: 150.w, height: 10.h, color: Colors.white),
            ],
          ),
        ),
      ],
    );
  }

  String _formatDateToDaysAgo(DateTime date) {
    final Duration diff = DateTime.now().difference(date);
    if (diff.inDays > 0) {
      return '${diff.inDays} days ago';
    } else if (diff.inHours > 0) {
      return '${diff.inHours} hours ago';
    } else if (diff.inMinutes > 0) {
      return '${diff.inMinutes} minutes ago';
    } else {
      return 'just now';
    }
  }
}

Widget _buildReviewItem(
  BuildContext context, {
  required String name,
  required int rating,
  required String comment,
  required String daysAgo,
  String? avatarPath,
}) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      ClipRRect(
        borderRadius: BorderRadius.circular(25.r),
        child: Center(
          child: Image.asset(
            avatarPath ?? AppIcons.personIcon,
            fit: BoxFit.cover,
            width: 30.w,
            height: 30.h,
          ),
        ),
      ),
      SizedBox(width: 10.w),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  name,
                  style: TextStyles.styleSemiBold(
                    context,
                    fontSize: 10.sp,
                    color: ColorsManager.primaryColor.withAlpha(
                      (.88 * 255).toInt(),
                    ),
                  ),
                ),
                Text(
                  daysAgo,
                  style: TextStyles.styleRegular(
                    context,
                    fontSize: 8.sp,
                    color: ColorsManager.primaryColor.withAlpha(
                      (.55 * 255).toInt(),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 4.h),
            Row(
              children: List.generate(
                5,
                (index) => Icon(
                  index < rating ? Icons.star : Icons.star_border,
                  color: ColorsManager.yellowTextColor,
                  size: 10.sp,
                ),
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              '"$comment"',
              style: TextStyles.styleRegular(
                context,
                fontSize: 10.sp,
                color: ColorsManager.primaryColor.withAlpha(
                  (.84 * 255).toInt(),
                ),
              ),
            ),
          ],
        ),
      ),
    ],
  );
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
