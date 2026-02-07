import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shatably_app/core/themes/text_styles.dart';
import 'package:shatably_app/feature/AI/data/models/generated_content.dart';

class VisionImageContent extends StatelessWidget {
  final GeneratedContent? content;
  final Animation<double> shimmerAnimation;
  final Uint8List? Function(String) decodeBase64Image;

  const VisionImageContent({
    super.key,
    required this.content,
    required this.shimmerAnimation,
    required this.decodeBase64Image,
  });

  @override
  Widget build(BuildContext context) {
    if (content?.isLoading == true) {
      return _buildLoadingShimmer(context, content?.text);
    } else if (content != null &&
        content!.base64ImageBytes != null &&
        content!.type == ContentType.image) {
      return _buildGeneratedImage(context, content!.base64ImageBytes!);
    } else if (content != null && content!.type == ContentType.text) {
      return _buildErrorMessage(context, message: content!.text);
    } else {
      return _buildPlaceholderMessage(context);
    }
  }

  Widget _buildLoadingShimmer(BuildContext context, String? message) {
    return AnimatedBuilder(
      animation: shimmerAnimation,
      builder: (context, child) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              stops: [
                shimmerAnimation.value - 0.5,
                shimmerAnimation.value,
                shimmerAnimation.value + 0.5,
              ],
              colors: const [
                Color(0xFF113B49),
                Color(0xFF124353),
                Color(0xFF113B49),
              ],
            ),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(
                  color: Colors.white.withAlpha((0.7 * 255).toInt()),
                ),
                SizedBox(height: 16.h),
                Text(
                  message ?? 'Generating...',
                  style: TextStyles.styleRegular(
                    context,
                    fontSize: 14.sp,
                    color: Colors.white.withAlpha((0.7 * 255).toInt()),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildGeneratedImage(BuildContext context, String base64String) {
    final imageBytes = decodeBase64Image(base64String);

    if (imageBytes == null || imageBytes.isEmpty) {
      return _buildErrorMessage(
        context,
        message: 'Failed to load image: Invalid or empty data.',
      );
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: Image.memory(
        imageBytes,
        width: double.infinity,
        height: double.infinity,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              color: Colors.red.withAlpha((0.1 * 255).toInt()),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error, color: Colors.red, size: 40.sp),
                  SizedBox(height: 8.h),
                  Text(
                    'Image Load Error',
                    style: TextStyles.styleRegular(
                      context,
                      fontSize: 14.sp,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildErrorMessage(BuildContext context, {String? message}) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(20.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, color: Colors.orange, size: 40.sp),
            SizedBox(height: 16.h),
            Text(
              message ?? 'An error occurred',
              textAlign: TextAlign.center,
              style: TextStyles.styleRegular(
                context,
                fontSize: 14.sp,
                color: Colors.orange,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlaceholderMessage(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.auto_awesome, color: Colors.blueAccent),
          const SizedBox(width: 6),
          Text(
            'Your AI-generated vision is ready to explore',
            textAlign: TextAlign.center,
            style: TextStyles.styleRegular(
              context,
              fontSize: 12.sp,
              color: Colors.blueAccent.withAlpha((0.5 * 255).toInt()),
            ),
          ),
        ],
      ),
    );
  }
}
