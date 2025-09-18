import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class ProjectGallery extends StatelessWidget {
  final String mainImageUrl;
  final List<String> imageUrls;

  const ProjectGallery({
    super.key,
    required this.mainImageUrl,
    required this.imageUrls,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(15.r),
          child: Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withAlpha((.25 * 255).toInt()),
                  blurRadius: 4.2,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            width: 282.w,
            height: 179.h,
            child: CachedNetworkImage(
              imageUrl: mainImageUrl,
              placeholder:
                  (context, url) => Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Container(
                      width: 282.w,
                      height: 179.h,
                      color: Colors.white,
                    ),
                  ),
              errorWidget: (context, url, error) => const Icon(Icons.error),
              fit: BoxFit.cover,
            ),
          ),
        ),
        SizedBox(width: 16.w),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            if (imageUrls.isNotEmpty) _buildThumbnail(imageUrls[0]),
            SizedBox(height: 16.h),
            if (imageUrls.length > 1) _buildThumbnail(imageUrls[1]),
            SizedBox(height: 16.h),
            if (imageUrls.length > 2) _buildThumbnail(imageUrls[2]),
          ],
        ),
      ],
    );
  }

  Widget _buildThumbnail(String imageUrl) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8.r),
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha((.25 * 255).toInt()),
              blurRadius: 4,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        width: 50.w,
        height: 50.h,
        child: CachedNetworkImage(
          imageUrl: imageUrl,
          placeholder:
              (context, url) => Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Container(
                  width: 50.w,
                  height: 50.h,
                  color: Colors.white,
                ),
              ),
          errorWidget: (context, url, error) => const Icon(Icons.error),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
