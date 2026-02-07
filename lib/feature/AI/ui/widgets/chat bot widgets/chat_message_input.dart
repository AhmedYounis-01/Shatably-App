import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shatably_app/core/themes/text_styles.dart';
import 'package:shatably_app/core/utils/app_icons.dart';

class ChatMessageInput extends StatelessWidget {
  final TextEditingController controller;
  final String? selectedImageBase64;
  final VoidCallback onPickImage;
  final VoidCallback onSendMessage;
  final VoidCallback onRemoveImage;

  const ChatMessageInput({
    super.key,
    required this.controller,
    required this.selectedImageBase64,
    required this.onPickImage,
    required this.onSendMessage,
    required this.onRemoveImage,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 30),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 6),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          gradient: const LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [Color(0xFF0E3441), Color(0xFF081D23)],
          ),
          border: Border.all(
            color: Colors.white.withAlpha((0.15 * 255).toInt()),
            width: .2,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha((0.25 * 255).toInt()),
              blurRadius: 8.2,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            gradient: const LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [Color(0xFF113B49), Color(0xFF0A252E)],
            ),
            border: Border.all(color: const Color(0xFF124353), width: 1),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (selectedImageBase64 != null)
                Padding(
                  padding: EdgeInsets.only(bottom: 8.h, top: 4.h),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8.r),
                        child: Image.memory(
                          base64Decode(selectedImageBase64!),
                          width: 40.w,
                          height: 40.h,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(width: 8.w),
                      Expanded(
                        child: Text(
                          'Image selected. Type a message...',
                          style: TextStyles.styleRegular(
                            context,
                            fontSize: 12.sp,
                            color: Colors.white.withAlpha((0.7 * 255).toInt()),
                          ),
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.close,
                          color: Colors.white.withAlpha((0.7 * 255).toInt()),
                        ),
                        onPressed: onRemoveImage,
                      ),
                    ],
                  ),
                ),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: controller,
                      maxLines: null,
                      keyboardType: TextInputType.multiline,
                      style: TextStyles.styleRegular(
                        context,
                        fontSize: 14.sp,
                        color: const Color(
                          0xFF089ECC,
                        ).withAlpha((0.46 * 255).toInt()),
                      ),
                      decoration: InputDecoration(
                        hintText:
                            selectedImageBase64 != null
                                ? 'Add text for image...'
                                : 'Message Shatably Assistant.......',
                        hintStyle: TextStyles.styleRegular(
                          context,
                          fontSize: 14.sp,
                          color: const Color(
                            0xFF089ECC,
                          ).withAlpha((0.46 * 255).toInt()),
                        ),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(vertical: 12.h),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: onPickImage,
                    child: SvgPicture.asset(
                      AppIcons.addPhotoIcon,
                      colorFilter: ColorFilter.mode(
                        selectedImageBase64 != null
                            ? Colors.blueAccent
                            : const Color(0XFF33B0EE),
                        BlendMode.srcIn,
                      ),
                      width: 25.w,
                      height: 25.h,
                    ),
                  ),
                  SizedBox(width: 10.w),
                  GestureDetector(
                    onTap: onSendMessage,
                    child: Container(
                      padding: EdgeInsets.all(5.r),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: const Color(
                          0XFF089ECC,
                        ).withAlpha((0.46 * 255).toInt()),
                      ),
                      child: Center(
                        child: Icon(
                          Icons.send_rounded,
                          color: Colors.white,
                          size: 24.sp,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
