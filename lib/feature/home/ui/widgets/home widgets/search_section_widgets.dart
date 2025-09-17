import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shatably_app/core/themes/colors_manager.dart';
import 'package:shatably_app/core/utils/app_icons.dart';
import 'package:shatably_app/core/themes/text_styles.dart';
import 'package:shatably_app/feature/home/ui/widgets/home widgets/app_colors.dart';

// Search Bar Section Widget
class SearchBarSection extends StatelessWidget {
  const SearchBarSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const SearchBarBackground(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 23),
          child: Container(
            height: 50.h,
            decoration: searchBarDecoration(),
            child: const SearchTextField(),
          ),
        ),
      ],
    );
  }

  BoxDecoration searchBarDecoration() {
    return BoxDecoration(
      color: const Color(0xFFDADADA),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withAlpha((0.25 * 255).toInt()),
          spreadRadius: 2,
          blurRadius: 10.4,
        ),
      ],
      borderRadius: BorderRadius.circular(10),
    );
  }
}

// Search Bar Background Widget
class SearchBarBackground extends StatelessWidget {
  const SearchBarBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(height: 25.h, color: AppColors.creamLight),
        Container(height: 25.h, color: AppColors.lightBlue),
      ],
    );
  }
}

// Search Text Field Widget
class SearchTextField extends StatelessWidget {
  const SearchTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      textInputAction: TextInputAction.search,
      decoration: InputDecoration(
        hintText: 'Search for service',
        hintStyle: TextStyles.styleRegular(
          context,
          fontSize: 14.sp,
          color: ColorsManager.geryIconColor,
        ),
        suffixIcon: InkWell(
          onTap: () {}, // Add search functionality here
          child: Padding(
            padding: EdgeInsets.all(15.h),
            child: Image.asset(
              AppIcons.searchIcon1,
              color: ColorsManager.geryIconColor,
            ),
          ),
        ),
        border: InputBorder.none,
        contentPadding: EdgeInsets.symmetric(vertical: 18.h, horizontal: 16.w),
      ),
    );
  }
}
