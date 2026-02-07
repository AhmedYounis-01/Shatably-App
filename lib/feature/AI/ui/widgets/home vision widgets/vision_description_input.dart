import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shatably_app/core/themes/text_styles.dart';

class VisionDescriptionInput extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onGenerate;

  const VisionDescriptionInput({
    super.key,
    required this.controller,
    required this.onGenerate,
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
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: controller,
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  style: TextStyles.styleRegular(
                    context,
                    fontSize: 14.sp,
                    color: Colors.white.withAlpha((0.8 * 255).toInt()),
                  ),
                  decoration: InputDecoration(
                    hintText: 'Describe your vision...',
                    hintStyle: TextStyles.styleRegular(
                      context,
                      fontSize: 14.sp,
                      color: Colors.white.withAlpha((0.5 * 255).toInt()),
                    ),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(vertical: 12.h),
                  ),
                ),
              ),
              GestureDetector(
                onTap: onGenerate,
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
        ),
      ),
    );
  }
}
