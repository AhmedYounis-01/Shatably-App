import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shatably_app/core/themes/text_styles.dart';

class LocationPermissionDeniedWidget extends StatelessWidget {
  const LocationPermissionDeniedWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black54,
      child: Center(
        child: Padding(
          padding: EdgeInsets.all(24.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.location_off, color: Colors.white, size: 48.w),
              SizedBox(height: 16.h),
              Text(
                'Location permission denied',
                style: TextStyles.styleBold(
                  context,
                  color: Colors.white,
                  fontSize: 18.sp,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 8.h),
              Text(
                'Please enable location permission in app settings to use this feature',
                style: TextStyles.styleRegular(
                  context,
                  color: Colors.white,
                  fontSize: 14.sp,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 24.h),
              ElevatedButton(
                onPressed: () async {
                  await Geolocator.openAppSettings();
                },
                child: Text('Open Settings'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
