import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shatably_app/core/helpers/extensions.dart';
import 'package:shatably_app/core/routes/routes.dart';
import 'package:shatably_app/core/themes/text_styles.dart';
import 'package:shatably_app/core/utils/app_icons.dart';
import 'package:shatably_app/core/utils/app_images.dart';
import 'package:shatably_app/core/widgets/custom_app_button.dart';

class AiCard extends StatelessWidget {
  const AiCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.r),
        boxShadow: [
          BoxShadow(
            blurRadius: 4.r,
            color: Colors.black.withAlpha((.25 * 255).toInt()),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            height: 153.h,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Color(0XFFE0E0E0),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25.r),
                topRight: Radius.circular(25.r),
              ),
            ),
            child: Stack(
              children: [
                SvgPicture.asset(
                  AppIcons.backgroundLines,
                  fit: BoxFit.fill,
                ),
                Center(child: Image.asset(AppImages.botImage)),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(
              horizontal: 18.w,
              vertical: 15.h,
            ),
            decoration: BoxDecoration(
              color: Color(0XFFC6C6C6),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(25.r),
                bottomRight: Radius.circular(25.r),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Shatably Assistant 🤖",
                  textAlign: TextAlign.center,
                  style: TextStyles.styleRegular(
                    context,
                    fontSize: 14.sp,
                    color: Color(0XFF0A252E),
                  ),
                ),
                SizedBox(height: 10.h),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        "Your 24/7 helper for finding the right service—fast, simple, and always here when you need it.",
                        textAlign: TextAlign.start,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyles.styleRegular(
                          context,
                          fontSize: 14.sp,
                          color: Color(
                            0XFF0A252E,
                          ).withAlpha((.60 * 255).toInt()),
                        ),
                      ),
                    ),
                    SizedBox(width: 30.w),
                    CustomAppButton(
                      onPressed: () {
                        context.pushNamed(Routes.chatBotScreen);
                      },
                      width: 55.w,
                      height: 25.h,
                      child: Text(
                        "Try it!",
                        style: TextStyles.styleRegular(
                          context,
                          fontSize: 11.sp,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
