import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shatably_app/core/themes/colors_manager.dart';
import 'package:shatably_app/feature/maintenance work/ui/widgets/details_section.dart';
import 'package:shatably_app/feature/maintenance work/ui/widgets/price_booking_section.dart';
import 'package:shatably_app/feature/maintenance work/ui/widgets/rating_row.dart';
import 'package:shatably_app/feature/maintenance work/ui/widgets/service_filter.dart';
import 'package:shatably_app/core/utils/app_icons.dart';

class MaintenanceContentSection extends StatelessWidget {
  final BuildContext parentContext;
  final String description;
  final String details;
  final int? averageRating;
  final int? reviewCount;
  final String priceText;
  final VoidCallback onBook;

  const MaintenanceContentSection({
    super.key,
    required this.parentContext,
    required this.description,
    required this.details,
    required this.averageRating,
    required this.reviewCount,
    required this.priceText,
    required this.onBook,
  });

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: Offset(0, -30.h),
      child: Container(
        padding: EdgeInsets.only(top: 12.h),
        decoration: BoxDecoration(
          color: const Color(0XFFE5F1EF),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.r),
            topRight: Radius.circular(30.r),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 25.w,
                height: 2.h,
                decoration: BoxDecoration(
                  color: ColorsManager.primaryColor,
                  borderRadius: BorderRadius.circular(10.r),
                ),
              ),
            ),
            SizedBox(height: 14.5.h),
            MaintenanceDetailsSection(
              parentContext: parentContext,
              description: description,
              details: details,
            ),
            SizedBox(height: 5.h),
            MaintenanceRatingRow(
              parentContext: parentContext,
              averageRating: averageRating,
              reviewCount: reviewCount,
            ),
            SizedBox(height: 28.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 0.w),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    ServiceFilter(
                      icon: AppIcons.takyeefIcon,
                      label: "Install",
                      isLast: false,
                    ),
                    ServiceFilter(
                      icon: AppIcons.wrenchIcon,
                      label: "Repair",
                      isLast: false,
                    ),
                    ServiceFilter(
                      icon: AppIcons.renewIcon,
                      label: "Renew",
                      isLast: true,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 40.h),
            MaintenancePriceAndBook(
              parentContext: parentContext,
              priceText: priceText,
              onBook: onBook,
            ),
          ],
        ),
      ),
    );
  }
}
