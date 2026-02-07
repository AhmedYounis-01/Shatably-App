import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shatably_app/core/themes/text_styles.dart';
import 'package:shatably_app/core/utils/app_images.dart';
import 'package:shatably_app/feature/AI/ui/widgets/home%20vision%20widgets/vision_image_description_actions.dart';

class VisionUserPromptSection extends StatelessWidget {
  final String latestUserPrompt;
  final VoidCallback onEdit;
  final VoidCallback onCopy;

  const VisionUserPromptSection({
    super.key,
    required this.latestUserPrompt,
    required this.onEdit,
    required this.onCopy,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(right: 8.w),
                  child: CircleAvatar(
                    radius: 14.r,
                    backgroundColor: Colors.transparent,
                    backgroundImage: AssetImage(AppImages.morganImage),
                  ),
                ),
                SizedBox(width: 8.w),
                Text(
                  "You",
                  style: TextStyles.styleMedium(
                    context,
                    fontSize: 16.sp,
                    color: Colors.white.withAlpha((0.49 * 255).toInt()),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.h),
            Padding(
              padding: EdgeInsets.only(left: 32.w),
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: 0.75.sw),
                child: Text(
                  latestUserPrompt,
                  style: TextStyles.styleRegular(
                    context,
                    fontSize: 13.sp,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(height: 16.h),
            Padding(
              padding: EdgeInsets.only(left: 32.w, bottom: 32.h),
              child: VisionImageDescriptionActions(
                textColor: Colors.white.withAlpha((0.49 * 255).toInt()),
                onEdit: onEdit,
                onCopy: onCopy,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
