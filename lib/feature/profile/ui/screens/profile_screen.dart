import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shatably_app/core/themes/colors_manager.dart';
import 'package:shatably_app/core/themes/text_styles.dart';
import 'package:shatably_app/core/utils/app_icons.dart';
import 'package:shatably_app/core/utils/app_images.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0XFFE5F1EF),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              SizedBox(height: 50.h),
              Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: Container(
                      width: 32.w,
                      height: 32.h,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xFFBEE1DB),
                      ),
                      child: Center(
                        child: Icon(
                          Icons.arrow_back_ios_new,
                          color: ColorsManager.primaryColor,
                          size: 16.sp,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: Text(
                        "Profile",
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w500,
                          color: ColorsManager.primaryColor,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 32.w),
                ],
              ),
              SizedBox(height: 18.h),
              Container(
                width: 85.r,
                height: 85.r,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: AssetImage(AppImages.circleAvatarIcon),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Center(
                  child: Container(
                    width: 70.r,
                    height: 70.r,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withAlpha((25 * 255).toInt()),
                          blurRadius: 4.r,
                          offset: const Offset(0, 1),
                        ),
                      ],
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: AssetImage(AppImages.morganImage2),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10.h),
              Text(
                "Abdelrahman Morgan",
                style: TextStyles.styleMedium(
                  context,
                  fontSize: 13.sp,
                  color: ColorsManager.primaryColor,
                ),
              ),
              Text(
                "abdelrahmanmorggan@gamil.com",
                style: TextStyles.styleMedium(
                  context,
                  fontSize: 12.sp,
                  color: ColorsManager.primaryColor.withAlpha(
                    (64 * 255).toInt(),
                  ),
                ),
              ),

              SizedBox(height: 53.h),
              const ProfileMenuList(),
              // Container(
              //   width: double.infinity,
              //   height: 48.h,
              //   padding: EdgeInsets.only(left: 10.w, right: 18.w),
              //   decoration: BoxDecoration(
              //     color: ColorsManager.backGroundFormsColor,
              //     border: Border.all(color: ColorsManager.yellowTextColor),
              //     borderRadius: BorderRadius.circular(15.r),
              //   ),
              //   child: Row(
              //     children: [
              //       SvgPicture.asset(AppIcons.userIcon),
              //       SizedBox(width: 8.w),
              //       Text("Edit Profile"),
              //       Spacer(),
              //       InkWell(
              //         onTap: () {},
              //         child: Icon(
              //           Icons.arrow_forward_ios,
              //           size: 16.sp,
              //           color: ColorsManager.primaryColor,
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProfileMenuItem {
  final String icon;
  final String title;
  final VoidCallback onTap;
  final bool isLogout;

  ProfileMenuItem({
    required this.icon,
    required this.title,
    required this.onTap,
    this.isLogout = false,
  });
}

class ProfileMenuList extends StatelessWidget {
  const ProfileMenuList({super.key});

  @override
  Widget build(BuildContext context) {
    final List<ProfileMenuItem> menuItems = [
      ProfileMenuItem(
        icon: AppIcons.paymentIcon,
        title: "Edit Profile",
        onTap: () {},
      ),
      ProfileMenuItem(
        icon: AppIcons.paymentIcon, // You'll need to add this icon
        title: "Payment Methods",
        onTap: () {},
      ),
      ProfileMenuItem(
        icon: AppIcons.transactioIcon, // You'll need to add this icon
        title: "Transactions",
        onTap: () {},
      ),
      ProfileMenuItem(
        icon: AppIcons.helpIcon, // You'll need to add this icon
        title: "Help Center",
        onTap: () {},
      ),
      ProfileMenuItem(
        icon: AppIcons.settingsIcon, // You'll need to add this icon
        title: "Settings",
        onTap: () {},
      ),
      ProfileMenuItem(
        icon: AppIcons.policiesIcon, // You'll need to add this icon
        title: "Terms and Conditions",
        onTap: () {},
      ),
      ProfileMenuItem(
        icon: AppIcons.logoutIcon, // You'll need to add this icon
        title: "Logout",
        isLogout: true,
        onTap: () {},
      ),
    ];

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

class ProfileMenuItemWidget extends StatelessWidget {
  final ProfileMenuItem item;

  const ProfileMenuItemWidget({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 48.h,
      padding: EdgeInsets.only(left: 10.w, right: 18.w),
      margin: EdgeInsets.only(bottom: 12.h),
      decoration: BoxDecoration(
        color: ColorsManager.backGroundFormsColor,
        border: Border.all(color: ColorsManager.yellowTextColor),
        borderRadius: BorderRadius.circular(15.r),
      ),
      child: InkWell(
        onTap: item.onTap,
        borderRadius: BorderRadius.circular(15.r),
        child: Row(
          children: [
            SvgPicture.asset(item.icon),
            SizedBox(width: 8.w),
            Text(
              item.title,
              style: TextStyle(
                color: ColorsManager.primaryColor,

                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            const Spacer(),
            if (!item.isLogout)
              Icon(
                Icons.arrow_forward_ios,
                size: 16.sp,
                color: ColorsManager.primaryColor,
              ),
          ],
        ),
      ),
    );
  }
}
