import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shatably_app/core/themes/text_styles.dart';
class SimpleDiscription extends StatelessWidget {
  const SimpleDiscription({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "Smart help for your home—instant ideas, smart suggestions, and\n photo previews in seconds.",
        textAlign: TextAlign.center,
        style: TextStyles.styleRegular(
          context,
          fontSize: 11.sp,
          color: Color(0XFF0A252E).withAlpha((.70 * 255).toInt()),
        ),
      ),
    );
  }
}
