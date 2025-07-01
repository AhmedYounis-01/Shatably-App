import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shatably_app/core/themes/colors_manager.dart';
import 'package:shatably_app/core/themes/text_styles.dart';
import 'package:shatably_app/core/widgets/custom_animation.dart';
import 'package:shatably_app/core/widgets/custom_app_button1.dart';
import 'package:shatably_app/feature/home/ui/home_screen.dart';

class TransactionFaield extends StatelessWidget {
  const TransactionFaield({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
    );
    return Scaffold(
      body: Padding(
        padding: EdgeInsetsDirectional.only(top: 150, start: 16, end: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AnimatedFadeErrorIcon(),
            // SizedBox(height: 20.h),
            Text(
              'Transaction Failed',
              style: TextStyles.styleMedium(
                context,
                fontSize: 18.3.sp,
                color: ColorsManager.primaryColor,
              ),
            ),
            SizedBox(height: 22.h),
            Text(
              '"The payment transaction was unsuccessful. Please try again or use a different payment method."',
              textAlign: TextAlign.center,
              style: TextStyles.styleRegular(context, color: Color(0xff989898)),
            ),
            SizedBox(height: 50.h),
            CustomAppButton1(
              width: 140.w,
              height: 50.h,
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => HomeScreen()),
                );
              },
              backgroundColor: ColorsManager.primaryColor,
              // isCircular: true,
              borderRadius: 30,
              child: Text(
                "Retry",
                style: TextStyles.styleMedium(context, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
