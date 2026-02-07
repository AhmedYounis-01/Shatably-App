import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shatably_app/core/utils/app_icons.dart';
import 'package:shatably_app/feature/AI/ui/widgets/home%20vision%20widgets/vision_action_button.dart';

class VisionImageDescriptionActions extends StatelessWidget {
  final Color textColor;
  final VoidCallback onEdit;
  final VoidCallback onCopy;

  const VisionImageDescriptionActions({
    super.key,
    required this.textColor,
    required this.onEdit,
    required this.onCopy,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        VisionActionButton(
          text: "Edit",
          iconPath: AppIcons.aiEditIcon,
          onPressed: onEdit,
          textColor: textColor,
          isUser: true,
        ),
        SizedBox(width: 10.w),
        VisionActionButton(
          text: "Copy",
          iconPath: AppIcons.aiCopyIcon,
          onPressed: onCopy,
          textColor: textColor,
          isUser: true,
        ),
      ],
    );
  }
}
