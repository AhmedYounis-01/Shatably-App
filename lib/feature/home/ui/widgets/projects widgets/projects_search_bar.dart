import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shatably_app/core/themes/colors_manager.dart';
import 'package:shatably_app/core/themes/text_styles.dart';
import 'package:shatably_app/core/utils/app_icons.dart';

class ProjectsSearchBar extends StatelessWidget {
  const ProjectsSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
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
    );
  }
}
