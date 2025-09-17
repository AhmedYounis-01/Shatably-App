import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shatably_app/core/themes/colors_manager.dart';
import 'package:shatably_app/core/themes/text_styles.dart';

class SearchBarWidget extends StatelessWidget {
  final TextEditingController searchController;
  final Function(String) onSearch;

  const SearchBarWidget({
    Key? key,
    required this.searchController,
    required this.onSearch,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.all(18.w),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  'Add your Home',
                  style: TextStyles.styleBold(
                    context,
                    fontSize: 18.sp,
                    color: ColorsManager.primaryColor,
                  ),
                ),
              ),
              SizedBox(height: 10.h),
              Container(
                height: 48.h,
                decoration: BoxDecoration(
                  color: Color(0x5CFFFFFF),
                  boxShadow: [BoxShadow(color: Color(0x3F000000))],
                  borderRadius: BorderRadius.circular(32.r),
                ),
                child: TextField(
                  controller: searchController,
                  textInputAction: TextInputAction.search,
                  onSubmitted: onSearch,
                  decoration: InputDecoration(
                    hintText: 'Search here',
                    hintStyle: TextStyles.styleRegular(
                      context,
                      fontSize: 14.sp,
                      color: ColorsManager.geryIconColor,
                    ),
                    prefixIcon: Icon(
                      Icons.location_on_outlined,
                      color: ColorsManager.geryIconColor,
                    ),
                    suffixIcon: InkWell(
                      onTap: () => onSearch(searchController.text),
                      child: const Icon(Icons.send, color: Colors.grey),
                    ),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(vertical: 18.h),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
