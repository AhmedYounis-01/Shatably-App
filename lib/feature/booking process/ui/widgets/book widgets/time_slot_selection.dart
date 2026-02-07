import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shatably_app/core/themes/colors_manager.dart';
import 'package:shatably_app/core/themes/text_styles.dart';
import 'package:shatably_app/core/utils/app_icons.dart';

class TimeSlotSelection extends StatelessWidget {
  final bool isMorningSelected;
  final List<String> morningTimeSlots;
  final List<String> afternoonTimeSlots;
  final String? selectedTimeSlot;
  final VoidCallback onMorningSelected;
  final VoidCallback onAfternoonSelected;
  final void Function(String) onTimeSlotSelected;

  const TimeSlotSelection({
    super.key,
    required this.isMorningSelected,
    required this.morningTimeSlots,
    required this.afternoonTimeSlots,
    required this.selectedTimeSlot,
    required this.onMorningSelected,
    required this.onAfternoonSelected,
    required this.onTimeSlotSelected,
  });

  @override
  Widget build(BuildContext context) {
    final List<String> currentSlots =
        isMorningSelected ? morningTimeSlots : afternoonTimeSlots;

    final List<String> firstRowSlots = currentSlots.take(4).toList();
    final List<String> secondRowSlots = currentSlots.skip(4).take(2).toList();

    return Column(
      children: [
        // Morning/Afternoon Toggle
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 88.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: onMorningSelected,
                  child: Container(
                    height: 38.h,
                    decoration: BoxDecoration(
                      color:
                          isMorningSelected
                              ? ColorsManager.primaryColor
                              : Colors.white,
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(AppIcons.cloudyIcon),
                        SizedBox(width: 6.w),
                        Text(
                          "Morning",
                          style: TextStyles.styleMedium(
                            context,
                            fontSize: 10.sp,
                            color:
                                isMorningSelected
                                    ? Colors.white
                                    : ColorsManager.primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: GestureDetector(
                  onTap: onAfternoonSelected,
                  child: Container(
                    height: 38.h,
                    decoration: BoxDecoration(
                      color:
                          !isMorningSelected
                              ? ColorsManager.primaryColor
                              : Colors.white,
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(AppIcons.sunnyIcon),
                        SizedBox(width: 6.w),
                        Text(
                          "Afternoon",
                          style: TextStyles.styleMedium(
                            context,
                            fontSize: 10.sp,
                            color:
                                !isMorningSelected
                                    ? Colors.white
                                    : ColorsManager.primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 12.5.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Divider(
            color: ColorsManager.primaryColor.withAlpha((.19 * 255).toInt()),
            thickness: 1.h,
          ),
        ),
        SizedBox(height: 15.5.h),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            children: [
              if (firstRowSlots.isNotEmpty)
                Wrap(
                  spacing: 16.w,
                  runSpacing: 15.h,
                  children:
                      firstRowSlots.map((timeText) {
                        final bool isSelected = selectedTimeSlot == timeText;
                        return GestureDetector(
                          onTap: () => onTimeSlotSelected(timeText),
                          child: Container(
                            width: 100.w,
                            height: 32.h,
                            decoration: BoxDecoration(
                              color:
                                  isSelected
                                      ? ColorsManager.primaryColor
                                      : ColorsManager.backGroundFormsColor,
                              borderRadius: BorderRadius.circular(15.r),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withAlpha(
                                    (.25 * 255).toInt(),
                                  ),
                                  blurRadius: 4.6,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Center(
                              child: Text(
                                timeText,
                                style: TextStyles.styleMedium(
                                  context,
                                  fontSize: 10.sp,
                                  color:
                                      isSelected
                                          ? Colors.white
                                          : ColorsManager.primaryColor,
                                ),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                ),
              if (firstRowSlots.isNotEmpty && secondRowSlots.isNotEmpty)
                SizedBox(height: 15.h),
              if (secondRowSlots.isNotEmpty)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:
                      secondRowSlots.map((timeText) {
                        final bool isSelected = selectedTimeSlot == timeText;
                        return Container(
                          margin: EdgeInsets.symmetric(horizontal: 8.w),
                          child: GestureDetector(
                            onTap: () => onTimeSlotSelected(timeText),
                            child: Container(
                              width: 100.w,
                              height: 32.h,
                              decoration: BoxDecoration(
                                color:
                                    isSelected
                                        ? ColorsManager.primaryColor
                                        : ColorsManager.backGroundFormsColor,
                                borderRadius: BorderRadius.circular(15.r),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withAlpha(
                                      (.25 * 255).toInt(),
                                    ),
                                    blurRadius: 4.6,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Center(
                                child: Text(
                                  timeText,
                                  style: TextStyles.styleMedium(
                                    context,
                                    fontSize: 10.sp,
                                    color:
                                        isSelected
                                            ? Colors.white
                                            : ColorsManager.primaryColor,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
