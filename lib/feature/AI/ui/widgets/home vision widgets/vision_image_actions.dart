import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shatably_app/core/utils/app_icons.dart';
import 'package:shatably_app/core/widgets/custom_toast.dart';
import 'package:shatably_app/feature/AI/data/models/generated_content.dart';
import 'package:shatably_app/feature/AI/ui/widgets/home%20vision%20widgets/vision_action_button.dart';
import 'package:toastification/toastification.dart';

class VisionImageActions extends StatelessWidget {
  final GeneratedContent content;
  final VoidCallback onRegenerate;

  const VisionImageActions({
    super.key,
    required this.content,
    required this.onRegenerate,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        VisionActionButton(
          text: "Copy",
          iconPath: AppIcons.aiCopyIcon,
          onPressed: () async {
            if (content.base64ImageBytes != null) {
              await Clipboard.setData(
                ClipboardData(text: content.base64ImageBytes!),
              );
              if (context.mounted) {
                customToast(
                  context: context,
                  message: "Image copied to clipboard",
                  type: ToastificationType.success,
                  icon: Icons.check,
                );
              }
            }
          },
          textColor: Colors.white,
          isUser: false,
        ),
        SizedBox(width: 10.w),
        VisionActionButton(
          text: "Share",
          iconPath: AppIcons.aiShareIcon,
          onPressed: () {
            if (content.base64ImageBytes != null) {
              customToast(
                context: context,
                message: "Share functionality not implemented yet.",
                type: ToastificationType.info,
                icon: Icons.info,
              );
            }
          },
          textColor: Colors.white,
          isUser: false,
        ),
        SizedBox(width: 10.w),
        VisionActionButton(
          text: "Regenerate",
          iconPath: AppIcons.aiRegenerateIcon,
          onPressed: onRegenerate,
          textColor: Colors.white,
          isUser: false,
        ),
      ],
    );
  }
}
