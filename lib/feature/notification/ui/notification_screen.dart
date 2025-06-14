import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shatably_app/core/themes/colors_manager.dart';
import 'package:shatably_app/core/themes/text_styles.dart';
import 'package:shatably_app/core/utils/app_icons.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
     

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.w),  
          child: Column(
            children: [
              // Header
              Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: Container(
                      width: 32.w,
                      height: 32.h,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xFFA6CDC6),
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
                        "Notifications",
                        style: TextStyles.styleMedium(
                          context,
                          fontSize: 18.sp,
                          color: ColorsManager.primaryColor,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 32.w),
                ],
              ),
              SizedBox(height: 36.h),
               Expanded(
                 child: ListView.separated(
                  itemBuilder: (context, index) {
                    final NotifyData notification = notificationData[index];
                    return NotificationItem(notification: notification);
                  },
                  separatorBuilder: (context, index) => SizedBox(height: 24.h),
                  itemCount: notificationData.length,
                 ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class NotificationItem extends StatelessWidget {
  final NotifyData notification;

  const NotificationItem({super.key, required this.notification});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SvgPicture.asset(
          notification.icon,
          width: 38.w,
          height: 38.h,

          placeholderBuilder:
              (BuildContext context) => Container(
                width: 38.w,
                height: 38.h,
                color: Colors.grey[300],
                child: Icon(Icons.error, size: 20.sp),
              ),
        ),
        SizedBox(width: 6.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                notification.title,  
                style: TextStyles.styleMedium(
                  context,
                  color: ColorsManager.primaryColor,
                  fontSize: 14.sp,
                ),
              ),
              Text(
                notification
                    .titleDetails,  
                style: TextStyles.styleRegular(
                  context,
                  color: ColorsManager.primaryColor.withAlpha(
                    (.64 * 255).toInt(),
                  ),
                  fontSize: 14.sp,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
        Text(
          notification.time, 
          style: TextStyles.styleRegular(
            context,
            color: const Color(0XFFA0A0A0),
            fontSize: 12.sp,
          ),
        ),
      ],
    );
  }
}

class NotifyData {
  final String icon;
  final String title;
  final String titleDetails;
  final String time;

  NotifyData({
    required this.icon,
    required this.title,
    required this.titleDetails,
    required this.time,
  });
}

List<NotifyData> notificationData = [
  NotifyData(
    icon: AppIcons.userIcon,
    title: "Booking Confirmed",
    titleDetails: "Your service with Mohamed Ahmed is confirmed. See you soon!",
    time: "2 days ago",
  ),
  NotifyData(
    icon: AppIcons.userIcon,
    title: "On the Way",
    titleDetails: "Your provider is on the way. Get ready!",
    time: "6 days ago",
  ),
  NotifyData(
    icon: AppIcons.userIcon,
    title: "Job Completed",
    titleDetails: "The service is complete. Rate your experience!",
    time: "9 days ago",
  ),
];
