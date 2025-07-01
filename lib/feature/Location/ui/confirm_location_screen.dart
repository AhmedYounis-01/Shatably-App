import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shatably_app/core/helpers/extensions.dart';
import 'package:shatably_app/core/routes/routes.dart';
import 'package:shatably_app/core/themes/colors_manager.dart';
import 'package:shatably_app/core/themes/text_styles.dart';
import 'package:shatably_app/core/widgets/custom_animation.dart';
import 'package:shatably_app/core/widgets/custom_app_button1.dart';

class ConfirmLocationScreen extends StatelessWidget {
  const ConfirmLocationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsetsDirectional.symmetric(horizontal: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Center(child: SvgPicture.asset(AppIcons.right)),
            FadeAnimationIcon(),
            SizedBox(height: 50.h),
            Text(
              'Successful',
              style: TextStyles.styleBold(
                context,
                fontSize: 19.sp,
                fontFamily: "Inter_24pt",
                color: Color(0xff1E1E1E),
              ),
            ),
            SizedBox(height: 22.h),
            Text(
              'Congratulations! Your location has\n been saved. Click continue to login',
              textAlign: TextAlign.center,
              style: TextStyles.styleRegular(context, color: Color(0xff989898)),
            ),
            SizedBox(height: 50.h),
            CustomAppButton1(
              width: 145.w,
              height: 50.h,
              onPressed: () {
                context.pushReplacementNamed(Routes.appLayoutsScreen);
              },
              backgroundColor: ColorsManager.primaryColor,
              // isCircular: true,
              borderRadius: 30,
              child: Text(
                "Continue",
                style: TextStyles.styleMedium(context, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
