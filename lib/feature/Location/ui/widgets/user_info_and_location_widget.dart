import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shatably_app/core/themes/text_styles.dart';
import 'package:shatably_app/core/utils/app_icons.dart';

class UserInfoAndLocationWidget extends StatelessWidget {
  final String username;
  final VoidCallback onSetLocation;
  final VoidCallback onSkip;

  const UserInfoAndLocationWidget({
    Key? key,
    required this.username,
    required this.onSetLocation,
    required this.onSkip,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 22.h,
      left: 22.w,
      right: 22.w,
      child: Column(
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              UserGreetingContainer(username: username),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: SetLocationContainer(onSetLocation: onSetLocation),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          SkipButton(onSkip: onSkip),
        ],
      ),
    );
  }
}

class UserGreetingContainer extends StatelessWidget {
  final String username;

  const UserGreetingContainer({Key? key, required this.username})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(
        top: 18.h,
        left: 18.w,
        right: 18.w,
        bottom: 30.h,
      ),
      decoration: BoxDecoration(
        color: Color(0x6016404D),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Hello, $username',
            style: TextStyles.styleBold(
              context,
              fontSize: 16.sp,
              color: Color(0xffFFE0AE),
            ),
          ),
          SizedBox(height: 50.h),
        ],
      ),
    );
  }
}

class SetLocationContainer extends StatelessWidget {
  final VoidCallback onSetLocation;

  const SetLocationContainer({Key? key, required this.onSetLocation})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 18.w),
      decoration: BoxDecoration(
        color: Color(0x5016404D),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(12.r),
          bottomRight: Radius.circular(12.r),
          topLeft: Radius.circular(25.r),
          topRight: Radius.circular(25.r),
        ),
      ),
      child: InkWell(
        onTap: onSetLocation,
        child: Row(
          children: [
            Image.asset(
              AppIcons.locationIcon2,
              width: 18,
              height: 18,
              color: Colors.white,
            ),
            SizedBox(width: 12.w),
            Text(
              'Set location on map',
              style: TextStyles.styleMedium(
                context,
                fontSize: 14.sp,
                color: Color(0x99FFFFFF),
              ),
            ),
            Spacer(),
            Icon(Icons.chevron_right, color: Colors.white, size: 24.w),
          ],
        ),
      ),
    );
  }
}

class SkipButton extends StatelessWidget {
  final VoidCallback onSkip;

  const SkipButton({Key? key, required this.onSkip}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onSkip,
      child: Text(
        'Skip',
        style: TextStyles.styleRegular(
          context,
          color: Color(0xff16404D).withAlpha((.4 * 255).toInt()),
        ),
      ),
    );
  }
}
