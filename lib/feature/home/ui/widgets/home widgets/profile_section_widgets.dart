import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shatably_app/core/themes/colors_manager.dart';
import 'package:shatably_app/core/utils/app_icons.dart';
import 'package:shatably_app/core/utils/app_images.dart';
import 'package:shatably_app/core/themes/text_styles.dart';
import 'package:shatably_app/feature/notification/ui/notification_screen.dart';
import 'package:shatably_app/feature/home/ui/widgets/home widgets/app_colors.dart';

// Profile Section Widget
class ProfileSection extends StatelessWidget {
  const ProfileSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.cream,
      width: double.infinity,
      padding: const EdgeInsets.only(bottom: 0, left: 23, right: 23),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),
          const ProfileNotificationRow(),
          const SizedBox(height: 15),
          Text(
            'What service do you want',
            style: TextStyles.styleRegular(
              context,
              fontSize: 14.sp,
              color: ColorsManager.primaryColor,
            ),
          ),
          SizedBox(height: 5.h),
        ],
      ),
    );
  }
}

// Profile and Notification Row Widget
class ProfileNotificationRow extends StatelessWidget {
  const ProfileNotificationRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const UserProfile(),
        NotificationButton(onTap: () => navigateToNotifications(context)),
      ],
    );
  }

  void navigateToNotifications(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const NotificationScreen()),
    );
  }
}

// User Profile Widget
class UserProfile extends StatelessWidget {
  const UserProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 22,
          backgroundImage: AssetImage(AppImages.morganImage),
        ),
        const SizedBox(width: 12),
        const UserDetails(),
      ],
    );
  }
}

// User Details Widget
class UserDetails extends StatelessWidget {
  const UserDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Hi Morgan',
          style: TextStyles.styleRegular(
            context,
            fontSize: 12.sp,
            color: const Color.fromRGBO(22, 64, 77, 0.8),
          ),
        ),
        const SizedBox(height: 4),
        const LocationRow(),
      ],
    );
  }
}

// Location Row Widget
class LocationRow extends StatelessWidget {
  const LocationRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(AppIcons.locationHomeIcon),
        const SizedBox(width: 4),
        Text(
          'Location name here',
          style: TextStyles.styleRegular(
            context,
            fontSize: 14.sp,
            color: ColorsManager.primaryColor,
          ),
        ),
        const SizedBox(width: 2),
        SvgPicture.asset(AppIcons.arrowHomeIcon),
      ],
    );
  }
}

// Notification Button Widget
class NotificationButton extends StatelessWidget {
  const NotificationButton({super.key, required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Stack(
        alignment: AlignmentDirectional.topEnd,
        children: [
          SvgPicture.asset(AppIcons.bellHomeIcon),
          Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(
              color: ColorsManager.yellowTextColor,
              borderRadius: BorderRadius.circular(25),
            ),
          ),
        ],
      ),
    );
  }
}
