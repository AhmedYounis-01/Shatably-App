import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shatably_app/core/themes/text_styles.dart';
import 'package:shatably_app/core/utils/app_images.dart';
import 'package:shatably_app/feature/AI/data/models/chat_message.dart';
import 'package:shatably_app/feature/AI/ui/widgets/chat%20bot%20widgets/chat_message_actions.dart';

class ChatMessageBubble extends StatelessWidget {
  final ChatMessage message;
  final VoidCallback onEdit;
  final VoidCallback onCopy;
  final VoidCallback onShare;
  final VoidCallback onRegenerate;

  const ChatMessageBubble({
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
    final Color nameTextColor = Colors.white.withAlpha((0.49 * 255).toInt());

    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8.h, horizontal: 5.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: EdgeInsets.only(right: 8.w),
                  child: CircleAvatar(
                    radius: 14.r,
                    backgroundColor: Colors.transparent,
                    backgroundImage: AssetImage(
                      isUser ? AppImages.morganImage : AppImages.botImage,
                    ),
                  ),
                ),
                SizedBox(width: 8.w),
                Text(
                  isUser ? "You" : "Shatably Assistant",
                  style: TextStyles.styleMedium(
                    context,
                    fontSize: 16.sp,
                    color: nameTextColor,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.h),
            Padding(
              padding: EdgeInsets.only(left: 32.w),
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: 0.75.sw),
                child:
                    message.isTyping
                        ? Text(
                          message.text,
                          style: TextStyles.styleRegular(
                            context,
                            fontSize: 13.sp,
                            color: Colors.redAccent,
                          ),
                        )
                        : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              message.text,
                              style: TextStyles.styleRegular(
                                context,
                                fontSize: 13.sp,
                                color: Colors.white,
                              ),
                            ),
                            if (message.base64Image != null)
                              Padding(
                                padding: EdgeInsets.only(top: 8.h),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8.r),
                                  child: Image.memory(
                                    base64Decode(message.base64Image!),
                                    width: 150.w,
                                    height: 150.h,
                                    fit: BoxFit.cover,
                                    errorBuilder:
                                        (context, error, stackTrace) => Text(
                                          'Failed to load image',
                                          style: TextStyles.styleRegular(
                                            context,
                                            fontSize: 10.sp,
                                            color: Colors.red,
                                          ),
                                        ),
                                  ),
                                ),
                              ),
                          ],
                        ),
              ),
            ),
            SizedBox(height: 16.h),
            if (!message.isTyping)
              Padding(
                padding: EdgeInsets.only(left: 32.w, bottom: 32.h),
                child: ChatMessageActions(
                  message: message,
                  onEdit: onEdit,
                  onCopy: onCopy,
                  onShare: onShare,
                  onRegenerate: onRegenerate,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
