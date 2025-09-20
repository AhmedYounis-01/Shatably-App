import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shatably_app/core/themes/colors_manager.dart';
import 'package:shatably_app/core/themes/text_styles.dart';
import 'package:shatably_app/core/utils/app_icons.dart';
import 'package:shatably_app/feature/Appointments/data/models/appointment_model.dart';

class AppointmentCard extends StatelessWidget {
  final AppointmentModel appointment;
  final VoidCallback? onCancel;
  final VoidCallback? onReschedule;

  const AppointmentCard({
    super.key,
    required this.appointment,
    this.onCancel,
    this.onReschedule,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0XFFE4E4E4),
        borderRadius: BorderRadius.circular(15.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha((0.25 * 255).toInt()),
            blurRadius: 2.3,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Profile Section
          Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: const Color(0xFFD7D7D7),
              borderRadius: BorderRadius.circular(10.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withAlpha((0.25 * 255).toInt()),
                  blurRadius: 2,
                ),
              ],
            ),
            child: Row(
              children: [
                // Profile Image
                Container(
                  width: 50.w,
                  height: 50.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0.r),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withAlpha((0.25 * 255).toInt()),
                        blurRadius: 1.2,
                        offset: const Offset(0, 1),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15.0.r),
                    child: Image.asset(
                      appointment.profileImage,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(width: 5.w),
                // Name and Profession
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        appointment.profession,
                        style: TextStyles.styleMedium(
                          context,
                          fontSize: 8.sp,
                          color: const Color(0XFF133741),
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        appointment.name,
                        style: TextStyles.styleMedium(
                          context,
                          fontSize: 13.sp,
                          color: const Color(
                            0XFF133741,
                          ).withAlpha((.67 * 255).toInt()),
                        ),
                      ),
                    ],
                  ),
                ),
                // Completed Status (only for completed appointments)
                if (!appointment.isUpcoming)
                  Text(
                    "Completed",
                    style: TextStyles.styleMedium(
                      context,
                      fontSize: 10.sp,
                      color: ColorsManager.yellowTextColor,
                    ),
                  ),
              ],
            ),
          ),

          appointment.isUpcoming
              ? SizedBox(height: 9.h)
              : SizedBox(height: 13.h),

          // Appointment Details
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // Date
              Row(
                children: [
                  SvgPicture.asset(
                    AppIcons.schedualeIcon,
                    width: 18.w,
                    height: 18.h,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(width: 4.w),
                  Text(
                    appointment.date,
                    style: TextStyles.styleMedium(
                      context,
                      fontSize: 10.sp,
                      color: ColorsManager.primaryColor.withAlpha(
                        (0.80 * 255).toInt(),
                      ),
                    ),
                  ),
                ],
              ),

              // Time
              Row(
                children: [
                  SvgPicture.asset(
                    AppIcons.clockIcon1,
                    width: 18.w,
                    height: 18.h,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(width: 4.w),
                  Text(
                    appointment.time,
                    style: TextStyles.styleMedium(
                      context,
                      fontSize: 10.sp,
                      color: ColorsManager.primaryColor.withAlpha(
                        (0.80 * 255).toInt(),
                      ),
                    ),
                  ),
                ],
              ),

              // Duration
              Row(
                children: [
                  SvgPicture.asset(
                    AppIcons.clockIcon2,
                    width: 18.w,
                    height: 18.h,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(width: 4.w),
                  Text(
                    appointment.duration,
                    style: TextStyles.styleMedium(
                      context,
                      fontSize: 10.sp,
                      color: ColorsManager.primaryColor.withAlpha(
                        (0.80 * 255).toInt(),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),

          // Action Buttons (only for upcoming appointments)
          if (appointment.isUpcoming) ...[
            SizedBox(height: 16.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Cancel Button
                Container(
                  width: 130.w,
                  height: 45.h,
                  decoration: BoxDecoration(
                    color: const Color(0XFFE4E4E4),
                    borderRadius: BorderRadius.circular(10.r),
                    border: Border.all(
                      color: const Color(0XFF6C5127),
                      width: 1,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withAlpha((0.25 * 255).toInt()),
                        blurRadius: 3.5,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: TextButton(
                    onPressed: onCancel,
                    child: Text(
                      "Cancel",
                      style: TextStyles.styleMedium(
                        context,
                        fontSize: 14.sp,
                        color: const Color(0XFF6C5127),
                      ),
                    ),
                  ),
                ),

                // Reschedule Button
                Container(
                  width: 130.w,
                  height: 45.h,
                  decoration: BoxDecoration(
                    color: ColorsManager.primaryColor,
                    borderRadius: BorderRadius.circular(10.r),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withAlpha((0.25 * 255).toInt()),
                        blurRadius: 3.5,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: TextButton(
                    onPressed: onReschedule,
                    child: Text(
                      "Rescheduale",
                      style: TextStyles.styleMedium(
                        context,
                        fontSize: 14.sp,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}
