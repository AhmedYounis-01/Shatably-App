import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shatably_app/core/utils/app_icons.dart';
import 'package:shatably_app/feature/AI/data/models/chat_message.dart';
import 'package:shatably_app/feature/AI/ui/widgets/chat%20bot%20widgets/chat_action_button.dart';

class ChatMessageActions extends StatelessWidget {
  final ChatMessage message;
  final VoidCallback onEdit;
  final VoidCallback onCopy;
  final VoidCallback onShare;
  final VoidCallback onRegenerate;

  const ChatMessageActions({
    super.key,
    required this.message,
    required this.onEdit,
    required this.onCopy,
    required this.onShare,
    required this.onRegenerate,
  });

  @override
  Widget build(BuildContext context) {
    final bool isUser = message.sender == MessageSender.user;
    final Color textColor = Colors.white.withAlpha((0.49 * 255).toInt());

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (isUser) ...[
          ChatActionButton(
            text: "Edit",
            iconPath: AppIcons.aiEditIcon,
            onPressed: onEdit,
            textColor: textColor,
            isUser: true,
          ),
          SizedBox(width: 10.w),
          ChatActionButton(
            text: "Copy",
            iconPath: AppIcons.aiCopyIcon,
            onPressed: onCopy,
            textColor: textColor,
            isUser: true,
          ),
        ] else ...[
          ChatActionButton(
            text: "Copy",
            iconPath: AppIcons.aiCopyIcon,
            onPressed: onCopy,
            textColor: Colors.white,
            isUser: false,
          ),
          SizedBox(width: 10.w),
          ChatActionButton(
            text: "Share",
            iconPath: AppIcons.aiShareIcon,
            onPressed: onShare,
            textColor: Colors.white,
            isUser: false,
          ),
          SizedBox(width: 10.w),
          ChatActionButton(
            text: "Regenerate",
            iconPath: AppIcons.aiRegenerateIcon,
            onPressed: onRegenerate,
            textColor: Colors.white,
            isUser: false,
          ),
        ],
      ],
    );
  }
}
