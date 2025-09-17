import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shatably_app/core/themes/text_styles.dart';

class LocationConfirmationWidget extends StatelessWidget {
  final String locationName;
  final VoidCallback onCancel;
  final VoidCallback onSave;

  const LocationConfirmationWidget({
    Key? key,
    required this.locationName,
    required this.onCancel,
    required this.onSave,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 22.h,
      left: 22.w,
      right: 22.w,
      child: Container(
        padding: EdgeInsets.all(20.w),
        decoration: BoxDecoration(
          color: Color(0x9016404D),
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            LocationHeaderRow(locationName: locationName),
            SizedBox(height: 8.h),
            Text(
              'Lorem ipsum dolor sit amet, consectetur',
              style: TextStyles.styleRegular(
                context,
                fontSize: 12.sp,
                color: Colors.white70,
              ),
            ),
            SizedBox(height: 20.h),
            ActionButtonsRow(onCancel: onCancel, onSave: onSave),
          ],
        ),
      ),
    );
  }
}

class LocationHeaderRow extends StatelessWidget {
  final String locationName;

  const LocationHeaderRow({Key? key, required this.locationName})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.location_on, color: Colors.white, size: 20.w),
        SizedBox(width: 8.w),
        Expanded(
          child: Text(
            locationName,
            style: TextStyles.styleBold(
              context,
              fontSize: 16.sp,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}

class ActionButtonsRow extends StatelessWidget {
  final VoidCallback onCancel;
  final VoidCallback onSave;

  const ActionButtonsRow({
    Key? key,
    required this.onCancel,
    required this.onSave,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: CancelButton(onCancel: onCancel)),
        SizedBox(width: 12.w),
        Expanded(child: SaveButton(onSave: onSave)),
      ],
    );
  }
}

class CancelButton extends StatelessWidget {
  final VoidCallback onCancel;

  const CancelButton({Key? key, required this.onCancel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44.h,
      decoration: BoxDecoration(
        color: Colors.transparent,
        border: Border.all(color: Color(0xffFFE0AE), width: 1.5),
        borderRadius: BorderRadius.circular(25.r),
      ),
      child: TextButton(
        onPressed: onCancel,
        child: Text(
          'Cancel',
          style: TextStyles.styleMedium(
            context,
            fontSize: 14.sp,
            color: Color(0xffFFE0AE),
          ),
        ),
      ),
    );
  }
}

class SaveButton extends StatelessWidget {
  final VoidCallback onSave;

  const SaveButton({Key? key, required this.onSave}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44.h,
      decoration: BoxDecoration(
        color: Color(0xff16404D),
        borderRadius: BorderRadius.circular(25.r),
      ),
      child: TextButton(
        onPressed: onSave,
        child: Text(
          'Save',
          style: TextStyles.styleMedium(
            context,
            fontSize: 14.sp,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
