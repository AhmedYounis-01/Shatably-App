import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shatably_app/feature/profile/data/sample/profile_menu_sample.dart';
import 'package:shatably_app/feature/profile/ui/widgets/profile_menu_item.dart';

class ProfileMenuList extends StatelessWidget {
  const ProfileMenuList({super.key});

  @override
  Widget build(BuildContext context) {
    final menuItems = getProfileMenuItems();

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: menuItems.length,
      separatorBuilder: (context, index) => SizedBox(height: 12.h),
      itemBuilder: (context, index) {
        final item = menuItems[index];
        return ProfileMenuItemWidget(item: item);
      },
    );
  }
}
