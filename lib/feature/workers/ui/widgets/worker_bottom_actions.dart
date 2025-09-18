import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shatably_app/core/themes/colors_manager.dart';
import 'package:shatably_app/core/themes/text_styles.dart';
import 'package:shatably_app/core/utils/app_icons.dart';

class WorkerBottomActions extends StatelessWidget {
  final VoidCallback? onHireNow;
  final VoidCallback? onChat;

  const WorkerBottomActions({super.key, this.onHireNow, this.onChat});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        decoration: BoxDecoration(
          color: const Color(0XFFE5F1EF),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15.r),
            topRight: Radius.circular(15.r),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha((.26 * 255).toInt()),
              blurRadius: 4,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: onHireNow,
                child: Container(
                  height: 45.h,
                  decoration: BoxDecoration(
                    color: ColorsManager.primaryColor,
                    borderRadius: BorderRadius.circular(15.r),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withAlpha((.26 * 255).toInt()),
                        blurRadius: 9.5,
                        spreadRadius: -1,
                        offset: const Offset(0, -4),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      SizedBox(width: 20.w),
                      Expanded(
                        child: Text(
                          "Hiring Now",
                          textAlign: TextAlign.center,
                          style: TextStyles.styleMedium(
                            context,
                            fontSize: 14.sp,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Container(
                        width: 28.w,
                        height: 28.h,
                        margin: EdgeInsets.only(right: 10.w),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.black, width: 1.r),
                          shape: BoxShape.circle,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: SvgPicture.asset(AppIcons.yellowArrow3),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(width: 15.w),
            GestureDetector(
              onTap: onChat,
              child: PhysicalModel(
                color: Colors.transparent,
                shadowColor: Colors.black,
                elevation: 30.r,
                child: SvgPicture.asset(
                  AppIcons.chatIcon,
                  width: 48.w,
                  height: 48.h,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
