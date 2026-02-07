import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shatably_app/core/themes/colors_manager.dart';
import 'package:shatably_app/core/themes/text_styles.dart';

class BookingCalendar extends StatelessWidget {
  final DateTime currentDisplayMonth;
  final List<DateTime> days;
  final int? selectedDayIndex;
  final VoidCallback onPreviousMonth;
  final VoidCallback onNextMonth;
  final void Function(int, DateTime) onDaySelected;

  const BookingCalendar({
    super.key,
    required this.currentDisplayMonth,
    required this.days,
    required this.selectedDayIndex,
    required this.onPreviousMonth,
    required this.onNextMonth,
    required this.onDaySelected,
  });

  String _getMonthName(int month) {
    const months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];
    return months[month - 1];
  }

  String _getWeekdayName(int weekday) {
    const weekdays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    return weekdays[weekday - 1];
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "${_getMonthName(currentDisplayMonth.month)} ${currentDisplayMonth.year}",
                style: TextStyles.styleMedium(
                  context,
                  fontSize: 16.sp,
                  color: ColorsManager.primaryColor,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: onPreviousMonth,
                    child: Icon(
                      Icons.arrow_back_ios,
                      color: ColorsManager.primaryColor.withAlpha(
                        (.55 * 255).toInt(),
                      ),
                    ),
                  ),
                  SizedBox(width: 8.w),
                  GestureDetector(
                    onTap: onNextMonth,
                    child: Icon(
                      Icons.arrow_forward_ios,
                      color: ColorsManager.primaryColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: 27.h),
        SizedBox(
          height: 70.h,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            itemCount: days.length,
            itemBuilder: (context, index) {
              final day = days[index];
              final bool isSelected = selectedDayIndex == index;
              return GestureDetector(
                onTap: () => onDaySelected(index, day),
                child: Container(
                  width: 31.w,
                  margin: EdgeInsets.symmetric(horizontal: 8.w),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withAlpha((.25 * 255).toInt()),
                        blurRadius: 6,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 8.h),
                      Text(
                        _getWeekdayName(day.weekday),
                        style: TextStyles.styleMedium(
                          context,
                          fontSize: 12.sp,
                          color: ColorsManager.primaryColor,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Container(
                        width: 27.w,
                        height: 27.h,
                        decoration: BoxDecoration(
                          color:
                              isSelected
                                  ? ColorsManager.primaryColor
                                  : ColorsManager.primaryColor.withAlpha(
                                    (.30 * 255).toInt(),
                                  ),
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text(
                            day.day.toString(),
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                              color:
                                  isSelected
                                      ? Colors.white
                                      : Colors.white.withAlpha(
                                        (.50 * 255).toInt(),
                                      ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
