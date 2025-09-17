import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shatably_app/core/themes/colors_manager.dart';
import 'package:shatably_app/core/themes/text_styles.dart';
import 'package:shatably_app/core/utils/app_icons.dart';
import 'package:shatably_app/feature/projects/ui/projects_screen.dart';

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
