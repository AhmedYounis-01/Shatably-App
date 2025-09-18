import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shimmer/shimmer.dart';

class MaintenanceHeaderImage extends StatelessWidget {
  final String imageUrl;
  final String title;
  final VoidCallback onBack;

  const MaintenanceHeaderImage({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          width: double.infinity,
          height: 400.h,
          child: CachedNetworkImage(
            imageUrl: imageUrl,
            fit: BoxFit.cover,
            placeholder:
                (context, url) => Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    width: double.infinity,
                    height: double.infinity,
                    color: Colors.white,
                  ),
                ),
            errorWidget:
                (context, url, error) => Container(
                  color: Colors.grey[300],
                  child: Icon(
                    Icons.broken_image,
                    size: 50.h,
                    color: Colors.grey[600],
                  ),
                ),
          ),
        ),
        Container(
          width: double.infinity,
          height: 400.h,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.black.withAlpha((.10 * 255).toInt()),
                Colors.black.withAlpha((.30 * 255).toInt()),
                Colors.black.withAlpha((.30 * 255).toInt()),
                Colors.black.withAlpha((.60 * 255).toInt()),
                Colors.black.withAlpha((.10 * 255).toInt()),
              ],
            ),
          ),
        ),
        Positioned(
          top: 30.h,
          left: 0,
          right: 0,
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: onBack,
                    child: Container(
                      width: 30.w,
                      height: 30.h,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xFFA6CDC6),
                      ),
                      child: Center(
                        child: SvgPicture.asset(
                          "assets/icons/arrow_ios.svg",
                          width: 15.w,
                          height: 15.h,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: Text(
                        title,
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  SizedBox(width: 30.w),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
