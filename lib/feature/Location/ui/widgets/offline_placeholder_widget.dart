import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shatably_app/core/themes/text_styles.dart';

class OfflinePlaceholderWidget extends StatelessWidget {
  final VoidCallback onRetry;

  const OfflinePlaceholderWidget({Key? key, required this.onRetry})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.signal_wifi_off, size: 64.w, color: Colors.grey),
          SizedBox(height: 16.h),
          Text(
            'No Internet Connection',
            style: TextStyles.styleBold(
              context,
              fontSize: 18.sp,
              color: Colors.grey[700],
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'Please check your connection and try again',
            style: TextStyles.styleRegular(
              context,
              fontSize: 14.sp,
              color: Colors.grey[600],
            ),
          ),
          SizedBox(height: 24.h),
          ElevatedButton(onPressed: onRetry, child: Text('Retry')),
        ],
      ),
    );
  }
}
