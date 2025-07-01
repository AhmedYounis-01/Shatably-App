import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shatably_app/core/themes/colors_manager.dart';
import 'package:shatably_app/core/themes/text_styles.dart';
import 'package:shatably_app/core/utils/app_icons.dart';
import 'package:shatably_app/core/widgets/custom_toast.dart';
import 'package:shatably_app/feature/booking%20process/data/models/model____for%20me/book_model.dart';
import 'package:shatably_app/feature/booking%20process/logic/booking%20cubit/booking_cubit.dart';
import 'package:shatably_app/feature/booking%20process/logic/booking%20cubit/booking_state.dart';
import 'package:shatably_app/feature/booking%20process/ui/screens/book_details_screen.dart';
import 'package:toastification/toastification.dart';

class BookingScreen extends StatefulWidget {
  final String image;
  final String id;
  final String serviceType;

  const BookingScreen({
    super.key,
    required this.image,
    required this.id,
    required this.serviceType,
  });

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  // --- Controllers for selected data ---
  // Selected date
  ValueNotifier<DateTime?> selectedDateNotifier = ValueNotifier(null);
  // Selected time slot
  ValueNotifier<String?> selectedTimeSlotNotifier = ValueNotifier(null);
  // Selected payment method
  ValueNotifier<int?> selectedPaymentMethodIndexNotifier = ValueNotifier(null);

  // State variables for booking functionality
  DateTime _currentDisplayMonth = DateTime.now();
  int? _selectedDayIndex;
  bool isMorningSelected = true;

  // Sample data for the booking screen
  List<DateTime> _getDaysForMonth(DateTime month) {
    List<DateTime> days = [];
    final now = DateTime.now();
    final startOfToday = DateTime(now.year, now.month, now.day);

    // Get the first day of the month
    DateTime firstDayOfMonth = DateTime(month.year, month.month, 1);
    // Get the last day of the month
    DateTime lastDayOfMonth = DateTime(month.year, month.month + 1, 0);

    for (int i = 0; i < lastDayOfMonth.day; i++) {
      DateTime day = firstDayOfMonth.add(Duration(days: i));
      // Only add days from today onwards if in the current month
      if (day.isAfter(startOfToday.subtract(const Duration(days: 1)))) {
        days.add(day);
      }
    }
    return days;
  }

  final List<String> morningTimeSlots = [
    "12PM - 1PM",
    "1PM - 2PM",
    "2PM - 3PM",
  ];

  final List<String> afternoonTimeSlots = [
    "3PM - 4PM",
    "4PM - 5PM",
    "5PM - 6PM",
  ];

  final List<Map<String, dynamic>> paymentMethods = [
    {"name": "Mastercard", "icon": AppIcons.baymentIcon1},
    {"name": "Visa", "icon": AppIcons.baymentIcon2},
    {"name": "Apple Pay", "icon": AppIcons.baymentIcon3},
  ];

  @override
  void initState() {
    super.initState();
    // Initialize with the current day selected if available
    _initializeSelectedDay();
  }

  void _initializeSelectedDay() {
    final now = DateTime.now();
    final daysInMonth = _getDaysForMonth(_currentDisplayMonth);
    for (int i = 0; i < daysInMonth.length; i++) {
      if (daysInMonth[i].day == now.day &&
          daysInMonth[i].month == now.month &&
          daysInMonth[i].year == now.year) {
        _selectedDayIndex = i;
        selectedDateNotifier.value = daysInMonth[i];
        break;
      }
    }
  }

  void _goToPreviousMonth() {
    setState(() {
      _currentDisplayMonth = DateTime(
        _currentDisplayMonth.year,
        _currentDisplayMonth.month - 1,
        1,
      );
      _selectedDayIndex = null; // Reset selection for new month
      selectedDateNotifier.value = null;
    });
  }

  void _goToNextMonth() {
    setState(() {
      _currentDisplayMonth = DateTime(
        _currentDisplayMonth.year,
        _currentDisplayMonth.month + 1,
        1,
      );
      _selectedDayIndex = null; // Reset selection for new month
      selectedDateNotifier.value = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
    );
    return Scaffold(
      backgroundColor: const Color(0XFFE5F1EF),
      body: Column(
        children: [
          // Header
          Stack(
            children: [
              // Background Image
              Container(
                height: 320.h,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(widget.image),
                    // image: AssetImage(widget.image),
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(
                      Colors.black.withAlpha((0.25 * 255).toInt()),
                      BlendMode.darken,
                    ),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withAlpha((0.15 * 255).toInt()),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
              ),
              // Navigation Bar
              Positioned(
                top: 35.h,
                left: 16.w,
                right: 16.w,
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.of(context).pop(),
                      child: Container(
                        width: 32.w,
                        height: 32.h,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xFFBEE1DB),
                        ),
                        child: Center(
                          child: Icon(
                            Icons.arrow_back_ios_new,
                            color: ColorsManager.primaryColor,
                            size: 16.sp,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Center(
                        child: Text(
                          "Booking",
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 32.w), // Balance spacing
                  ],
                ),
              ),
            ],
          ),

          // Content Section
          Expanded(
            child: Container(
              width: double.infinity,
              transform: Matrix4.translationValues(0, -20.h, 0),
              decoration: BoxDecoration(
                color: const Color(0XFFE5F1EF),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.r),
                  topRight: Radius.circular(30.r),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withAlpha((0.25 * 255).toInt()),
                    blurRadius: 8,
                    offset: const Offset(0, -4), // Shadow above
                  ),
                ],
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 13.4.h),
                    // Drag indicator
                    Center(
                      child: Container(
                        width: 25.w,
                        height: 2.h,
                        decoration: BoxDecoration(
                          color: ColorsManager.primaryColor.withAlpha(
                            (43 * 255).toInt(),
                          ),
                          borderRadius: BorderRadius.circular(2.r),
                        ),
                      ),
                    ),
                    SizedBox(height: 15.5.h),

                    // Get Schedule title
                    Center(
                      child: Text(
                        "Get Schedule",
                        style: TextStyles.styleMedium(
                          context,
                          fontSize: 16.sp,
                          color: ColorsManager.primaryColor,
                        ),
                      ),
                    ),
                    SizedBox(height: 17.h),

                    // When should the professional arrive
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24.w),
                      child: Text(
                        "When Should The Professional arrive",
                        style: TextStyles.styleMedium(
                          context,
                          fontSize: 18.sp,
                          color: ColorsManager.primaryColor,
                        ),
                      ),
                    ),
                    SizedBox(height: 4.h),

                    // Pick a date and time text
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24.w),
                      child: Text(
                        "Pick a date and time that works best for your schedule.",
                        style: TextStyles.styleRegular(
                          context,
                          fontSize: 14.sp,
                          color: ColorsManager.primaryColor.withAlpha(
                            (.64 * 255).toInt(),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20.h),

                    // Month selection
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "${_getMonthName(_currentDisplayMonth.month)} ${_currentDisplayMonth.year}",
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
                                onTap: _goToPreviousMonth,
                                child: Icon(
                                  Icons.arrow_back_ios,
                                  color: ColorsManager.primaryColor.withAlpha(
                                    (.55 * 255).toInt(),
                                  ),
                                ),
                              ),
                              SizedBox(width: 8.w),
                              GestureDetector(
                                onTap: _goToNextMonth,
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

                    // Date selection
                    // Container(
                    //   padding: const EdgeInsets.symmetric(horizontal: 20),
                    //   height: 60.h,
                    //   child: ListView.builder(
                    //     scrollDirection: Axis.horizontal,
                    //     itemCount:
                    //         _getDaysForMonth(_currentDisplayMonth).length,
                    //     itemBuilder: (context, index) {
                    //       final day =
                    //           _getDaysForMonth(_currentDisplayMonth)[index];
                    //       final bool isSelected = _selectedDayIndex == index;
                    //       return GestureDetector(
                    //         onTap: () {
                    //           setState(() {
                    //             _selectedDayIndex = index;
                    //             selectedDateNotifier.value = day;
                    //           });
                    //         },
                    //         child: Container(
                    //           width: 50.w, // Adjusted width for better spacing
                    //           margin: EdgeInsets.symmetric(horizontal: 4.w),
                    //           decoration: BoxDecoration(
                    //             color: Colors.white,
                    //             borderRadius: BorderRadius.circular(30.r),
                    //             boxShadow: [
                    //               BoxShadow(
                    //                 color: Colors.black.withAlpha(
                    //                   (.25 * 255).toInt(),
                    //                 ),
                    //                 blurRadius: 6,
                    //                 offset: const Offset(0, 2),
                    //               ),
                    //             ],
                    //           ),
                    //           child: Column(
                    //             mainAxisAlignment: MainAxisAlignment.center,
                    //             children: [
                    //               Text(
                    //                 _getWeekdayName(day.weekday),
                    //                 style: TextStyles.styleMedium(
                    //                   context,
                    //                   fontSize: 12.sp,
                    //                   color: ColorsManager.primaryColor,
                    //                 ),
                    //               ),
                    //               SizedBox(height: 8.h),
                    //               Container(
                    //                 width: 27.w,
                    //                 height: 27.h,
                    //                 decoration: BoxDecoration(
                    //                   color:
                    //                       isSelected
                    //                           ? ColorsManager.primaryColor
                    //                           : ColorsManager.primaryColor
                    //                               .withAlpha(
                    //                                 (.30 * 255).toInt(),
                    //                               ),
                    //                   shape: BoxShape.circle,
                    //                 ),
                    //                 child: Center(
                    //                   child: Text(
                    //                     day.day.toString(),
                    //                     style: TextStyle(
                    //                       fontSize: 16.sp,
                    //                       fontWeight: FontWeight.w600,
                    //                       color:
                    //                           isSelected
                    //                               ? Colors.white
                    //                               : Colors.white.withAlpha(
                    //                                 (.50 * 255).toInt(),
                    //                               ),
                    //                     ),
                    //                   ),
                    //                 ),
                    //               ),
                    //             ],
                    //           ),
                    //         ),
                    //       );
                    //     },
                    //   ),
                    // ),

                    // Date selection Container
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      height: 70.h,

                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount:
                            _getDaysForMonth(_currentDisplayMonth).length,
                        itemBuilder: (context, index) {
                          final day =
                              _getDaysForMonth(_currentDisplayMonth)[index];
                          final bool isSelected = _selectedDayIndex == index;
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                _selectedDayIndex = index;
                                selectedDateNotifier.value = day;
                              });
                            },
                            child: Container(
                              width: 31.w,
                              margin: EdgeInsets.symmetric(horizontal: 8.w),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(30),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withAlpha(
                                      (.25 * 255).toInt(),
                                    ),
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
                                              : ColorsManager.primaryColor
                                                  .withAlpha(
                                                    (.30 * 255).toInt(),
                                                  ),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Center(
                                      child: Text(
                                        day.day.toString(),
                                        style: TextStyle(
                                          fontSize: 16,
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
                    SizedBox(height: 24.h),

                    // Available Slots
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24.w),
                      child: Text(
                        "Available Slots",
                        style: TextStyles.styleMedium(
                          context,
                          fontSize: 16.sp,
                          color: ColorsManager.primaryColor,
                        ),
                      ),
                    ),
                    SizedBox(height: 18.h),

                    // Morning/Afternoon Toggle
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 88.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  isMorningSelected = true;
                                  selectedTimeSlotNotifier.value =
                                      null; // Reset time slot selection
                                });
                              },
                              child: Container(
                                width: 95.w,
                                height: 38.h,
                                padding: EdgeInsets.symmetric(
                                  horizontal: 16.w,
                                  vertical: 10.h,
                                ),
                                decoration: BoxDecoration(
                                  color:
                                      isMorningSelected
                                          ? ColorsManager.primaryColor
                                          : Colors.white,
                                  borderRadius: BorderRadius.circular(20.r),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
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
                              onTap: () {
                                setState(() {
                                  isMorningSelected = false;
                                  selectedTimeSlotNotifier.value =
                                      null; // Reset time slot selection
                                });
                              },
                              child: Container(
                                width: 95.w,
                                height: 38.h,
                                padding: EdgeInsets.symmetric(
                                  horizontal: 16.w,
                                  vertical: 10.h,
                                ),
                                decoration: BoxDecoration(
                                  color:
                                      !isMorningSelected
                                          ? ColorsManager.primaryColor
                                          : Colors.white,
                                  borderRadius: BorderRadius.circular(20.r),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
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

                    // Divider line
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24.w),
                      child: Divider(
                        color: ColorsManager.primaryColor.withAlpha(
                          (.19 * 255).toInt(),
                        ),
                        thickness: 1.h,
                      ),
                    ),
                    SizedBox(height: 15.5.h),

                    // Custom time slots
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: ValueListenableBuilder<String?>(
                        valueListenable: selectedTimeSlotNotifier,
                        builder: (context, selectedTimeSlot, child) {
                          final List<String> currentSlots =
                              isMorningSelected
                                  ? morningTimeSlots
                                  : afternoonTimeSlots;

                          // Split the slots into rows
                          final List<String> firstRowSlots =
                              currentSlots.take(4).toList();
                          final List<String> secondRowSlots =
                              currentSlots.skip(4).take(2).toList();

                          return Column(
                            children: [
                              // First row - up to 4 items
                              if (firstRowSlots.isNotEmpty)
                                Wrap(
                                  spacing: 16.w,
                                  children:
                                      firstRowSlots.map((timeText) {
                                        final bool isSelected =
                                            selectedTimeSlot == timeText;
                                        return GestureDetector(
                                          onTap: () {
                                            selectedTimeSlotNotifier.value =
                                                timeText;
                                          },
                                          child: Container(
                                            width: 100.w,
                                            height: 32.h,
                                            decoration: BoxDecoration(
                                              color:
                                                  isSelected
                                                      ? ColorsManager
                                                          .primaryColor
                                                      : ColorsManager
                                                          .backGroundFormsColor,
                                              borderRadius:
                                                  BorderRadius.circular(15.r),
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
                                                          : ColorsManager
                                                              .primaryColor,
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      }).toList(),
                                ),

                              // Add spacing between rows
                              if (firstRowSlots.isNotEmpty &&
                                  secondRowSlots.isNotEmpty)
                                SizedBox(height: 15.h),

                              // Second row - up to 2 items (centered)
                              if (secondRowSlots.isNotEmpty)
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children:
                                      secondRowSlots.map((timeText) {
                                        final bool isSelected =
                                            selectedTimeSlot == timeText;
                                        return Container(
                                          margin: EdgeInsets.symmetric(
                                            horizontal: 8.w,
                                          ),
                                          child: GestureDetector(
                                            onTap: () {
                                              selectedTimeSlotNotifier.value =
                                                  timeText;
                                            },
                                            child: Container(
                                              width: 100.w,
                                              height: 32.h,
                                              decoration: BoxDecoration(
                                                color:
                                                    isSelected
                                                        ? ColorsManager
                                                            .primaryColor
                                                        : ColorsManager
                                                            .backGroundFormsColor,
                                                borderRadius:
                                                    BorderRadius.circular(15.r),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.black
                                                        .withAlpha(
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
                                                            : ColorsManager
                                                                .primaryColor,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      }).toList(),
                                ),
                            ],
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 28.h),

                    // Payment Methods title
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24.w),
                      child: Text(
                        "Payment Methods",
                        style: TextStyles.styleMedium(
                          context,
                          fontSize: 16.sp,
                          color: ColorsManager.primaryColor,
                        ),
                      ),
                    ),
                    SizedBox(height: 20.h),

                    // Payment Methods
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24.w),
                      child: ValueListenableBuilder<int?>(
                        valueListenable: selectedPaymentMethodIndexNotifier,
                        builder: (context, selectedPaymentIndex, child) {
                          return Row(
                            children: List.generate(
                              paymentMethods.length,
                              (index) => Expanded(
                                child: GestureDetector(
                                  // onTap: () {
                                  //   //! for Maintenance Work
                                  //   /*
                                  //   selectedPaymentMethodIndexNotifier.value =
                                  //       index;
                                  //   // Move the booking logic here
                                  //   final bookingRequest = BookingRequestModel(
                                  //     bookingDate: "2025-06-15",
                                  //     timeSlot: "10:00 AM",
                                  //     serviceId: widget.id,
                                  //     clientId: null,
                                  //     workerId: null,
                                  //     portfolioId: null,
                                  //     location: Location(
                                  //       latitude: 30.0444,
                                  //       longitude: 31.54,
                                  //       address: "123 Nasr City, Cairo",
                                  //       description: "Near the main square",
                                  //     ),
                                  //   );
                                  //   context.read<BookingCubit>().bookService(
                                  //     bookingRequest,
                                  //   );
                                  //   */
                                  //   //! for projects work
                                  //   /*
                                  //   selectedPaymentMethodIndexNotifier.value =
                                  //       index;
                                  //   // Move the booking logic here
                                  //   final bookingRequest = BookingRequestModel(
                                  //     bookingDate: "2025-06-15",
                                  //     timeSlot: "10:00 AM",
                                  //     serviceId: null,
                                  //     clientId: null,
                                  //     workerId: null,
                                  //     portfolioId: widget.id,
                                  //     location: Location(
                                  //       latitude: 30.0444,
                                  //       longitude: 31.54,
                                  //       address: "123 Nasr City, Cairo",
                                  //       description: "Near the main square",
                                  //     ),
                                  //   );
                                  //   context.read<BookingCubit>().bookService(
                                  //     bookingRequest,
                                  //   );
                                  //   */

                                  //   context.read<BookingCubit>().bookService(
                                  //     bookingRequest,
                                  //   );
                                  // },
                                  onTap: () {
                                    selectedPaymentMethodIndexNotifier.value =
                                        index;

                                    // Create booking request based on the type of service
                                    BookingRequestModel bookingRequest;

                                    // Check if we're booking a maintenance service or project
                                    if (widget.serviceType == 'Maintenance') {
                                      // For Maintenance Work
                                      bookingRequest = BookingRequestModel(
                                        bookingDate: "2025-06-15",
                                        timeSlot: "10:00 AM",
                                        serviceId: widget.id,
                                        clientId: null,
                                        workerId: null,
                                        portfolioId: null,
                                        location: Location(
                                          latitude: 30.0444,
                                          longitude: 31.54,
                                          address: "123 Nasr City, Cairo",
                                          description: "Near the main square",
                                        ),
                                      );
                                    } else {
                                      // For Projects Work
                                      bookingRequest = BookingRequestModel(
                                        bookingDate: "2025-06-15",
                                        timeSlot: "10:00 AM",
                                        serviceId: null,
                                        clientId: null,
                                        workerId: null,
                                        portfolioId: widget.id,
                                        location: Location(
                                          latitude: 30.0444,
                                          longitude: 31.54,
                                          address: "123 Nasr City, Cairo",
                                          description: "Near the main square",
                                        ),
                                      );
                                    }

                                    // Make the booking request
                                    context.read<BookingCubit>().bookService(
                                      bookingRequest,
                                    );
                                  },
                                  child: Container(
                                    height: 50.h,
                                    margin: EdgeInsets.only(
                                      right:
                                          index < paymentMethods.length - 1
                                              ? 8.w
                                              : 0,
                                    ),
                                    decoration: BoxDecoration(
                                      color:
                                          selectedPaymentIndex == index
                                              ? ColorsManager.primaryColor
                                              : Colors.transparent,
                                      borderRadius: BorderRadius.circular(12.r),
                                      border: Border.all(
                                        color: ColorsManager.primaryColor,
                                        width:
                                            selectedPaymentIndex == index
                                                ? 1.w
                                                : .5.w,
                                      ),
                                    ),
                                    child: Center(
                                      child: SvgPicture.asset(
                                        paymentMethods[index]["icon"],
                                        colorFilter:
                                            index == 0
                                                ? null // First icon no color change
                                                : ColorFilter.mode(
                                                  selectedPaymentIndex == index
                                                      ? Colors.white
                                                      : ColorsManager
                                                          .primaryColor,
                                                  BlendMode.srcIn,
                                                ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 24.h),

                    BlocConsumer<BookingCubit, BookingState>(
                      listener: (context, state) {
                        if (state.status == BookingStates.loading) {
                          Center(
                            child: CircularProgressIndicator(
                              color: ColorsManager.primaryColor,
                            ),
                          );
                        } else if (state.status == BookingStates.error) {
                          customToast(
                            context: context,
                            message:
                                state.errorMessage ?? 'Failed to book service.',
                            type: ToastificationType.error,
                            icon: Icons.error,
                          );
                        } else if (state.status == BookingStates.success) {
                          context.read<BookingCubit>().logBookingId();

                          // customToast(
                          //   context: context,
                          //   message: 'Service booked successfully.',
                          //   type: ToastificationType.success,
                          //   icon: Icons.check_circle,
                          // );
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder:
                                  (context) => BookingDetailScreen(
                                    bookingId:
                                        state.bookingResponseModel!.bookingId,
                                  ),
                            ),
                          );
                        }
                      },
                      builder: (context, state) {
                        return const SizedBox.shrink(); // Replaced with an empty SizedBox
                      },
                    ),

                    SizedBox(height: 100),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Helper for weekday name
  String _getWeekdayName(int weekday) {
    switch (weekday) {
      case DateTime.monday:
        return 'Mon';
      case DateTime.tuesday:
        return 'Tue';
      case DateTime.wednesday:
        return 'Wed';
      case DateTime.thursday:
        return 'Thu';
      case DateTime.friday:
        return 'Fri';
      case DateTime.saturday:
        return 'Sat';
      case DateTime.sunday:
        return 'Sun';
      default:
        return '';
    }
  }

  // Helper for month name
  String _getMonthName(int month) {
    switch (month) {
      case 1:
        return 'January';
      case 2:
        return 'February';
      case 3:
        return 'March';
      case 4:
        return 'April';
      case 5:
        return 'May';
      case 6:
        return 'June';
      case 7:
        return 'July';
      case 8:
        return 'August';
      case 9:
        return 'September';
      case 10:
        return 'October';
      case 11:
        return 'November';
      case 12:
        return 'December';
      default:
        return '';
    }
  }
}

class DayInfo {
  final String day;
  final int date;

  DayInfo({required this.day, required this.date});
}

class WorkerInfo {
  final int rating;
  final int reviewCount;

  WorkerInfo({required this.rating, required this.reviewCount});
}
