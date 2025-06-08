import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shatably_app/core/themes/colors_manager.dart';
import 'package:shatably_app/core/themes/text_styles.dart';
import 'package:shatably_app/core/utils/app_icons.dart';
import 'package:shatably_app/core/utils/app_images.dart';

class CustomBookingScreen extends StatefulWidget {
  // final String title;
  final String image;
  // final String backgroundImage;
  // final String serviceTitle;
  // final String serviceDetails;
  // final String price;
  // final List<Map<String, dynamic>> filters;
  // final List<WorkerInfo> workers;
  // final VoidCallback onBookNow;

  const CustomBookingScreen({
    super.key,
    // required this.title,
    required this.image,
    // required this.backgroundImage,
    // required this.serviceTitle,
    // required this.serviceDetails,
    // required this.price,
    // required this.filters,
    // required this.workers,
    // required this.onBookNow,
  });

  @override
  State<CustomBookingScreen> createState() => _CustomBookingScreenState();
}

class _CustomBookingScreenState extends State<CustomBookingScreen> {
  // State variables for booking functionality
  DateTime selectedDate = DateTime.now();
  String currentMonth = "June 2025";
  int selectedDayIndex = 0;
  bool isMorningSelected = true;
  int? selectedTimeSlotIndex;
  int? selectedPaymentMethodIndex;
  // int selectedPaymentIndex = 1; // Visa is selected by default (index 1)

  // Sample data for the booking screen
  final days = [
    {'day': 'Mon', 'date': '16', 'isSelected': true},
    {'day': 'Tue', 'date': '17', 'isSelected': false},
    {'day': 'Mon', 'date': '18', 'isSelected': false},
    {'day': 'Wed', 'date': '19', 'isSelected': false},
    {'day': 'Thu', 'date': '20', 'isSelected': false},
    {'day': 'Fri', 'date': '21', 'isSelected': false},
    {'day': 'Sat', 'date': '22', 'isSelected': false},
  ];

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
          // Header Section with Image and Navigation
          Stack(
            children: [
              // Background Image
              Container(
                height: 320.h, // Fixed height for header
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(widget.image),
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
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
              ),
              // Navigation Bar positioned at top
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
                    SizedBox(width: 32.w), // Balance the spacing
                  ],
                ),
              ),
            ],
          ),

          // Content Section
          Expanded(
            child: Container(
              width: double.infinity,
              transform: Matrix4.translationValues(
                0,
                -20.h, // Move content upward
                0,
              ),
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
                    offset: Offset(0, -4), // Shadow above the container
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
                            currentMonth,
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
                                onTap: () {
                                  // Previous month logic
                                },
                                child: Icon(
                                  Icons.arrow_back_ios,
                                  color: ColorsManager.primaryColor.withAlpha(
                                    (.55 * 255).toInt(),
                                  ),
                                ),
                              ),
                              SizedBox(width: 8.w),
                              GestureDetector(
                                onTap: () {
                                  // Next month logic
                                },
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
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children:
                            days.map((dayData) {
                              return Container(
                                width: 31.w,
                                // height: 60.h,
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
                                      dayData['day'] as String,
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
                                            (dayData['isSelected'] as bool)
                                                ? ColorsManager.primaryColor
                                                : ColorsManager.primaryColor
                                                    .withAlpha(
                                                      (.30 * 255).toInt(),
                                                    ),
                                        shape: BoxShape.circle,
                                      ),
                                      child: Center(
                                        child: Text(
                                          dayData['date'] as String,
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                            color:
                                                (dayData['isSelected'] as bool)
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
                              );
                            }).toList(),
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
                      padding: EdgeInsets.symmetric(horizontal: 24.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                isMorningSelected = true;
                                selectedTimeSlotIndex = null;
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
                          SizedBox(width: 12.w),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                isMorningSelected = false;
                                selectedTimeSlotIndex = null;
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
                        ],
                      ),
                    ),
                    SizedBox(height: 12.5.h),

                    // divider line
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
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        // vertical: 20.h,
                      ),
                      child: Column(
                        children: [
                          // First row - 4 slots
                          Row(
                            children: [
                              _buildTimeSlot("12PM - 1 PM", 0),
                              SizedBox(width: 16.w),
                              _buildTimeSlot("1PM - 2PM", 1),
                              SizedBox(width: 16.w),
                              _buildTimeSlot("2PM - 3PM", 2),
                              SizedBox(width: 16.w),
                              _buildTimeSlot("3PM - 4PM", 3),
                            ],
                          ),
                          SizedBox(height: 15.h),
                          // Second row - 2 slots centered
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              _buildTimeSlot("4PM - 5PM", 4),
                              SizedBox(width: 16.w),
                              _buildTimeSlot("5PM - 6PM", 5),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 28.h),

                    // Payment Methods
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

                    // Payment options
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24.w),
                      child: Row(
                        children: List.generate(
                          paymentMethods.length,
                          (index) => Expanded(
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedPaymentMethodIndex = index;
                                });
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
                                      selectedPaymentMethodIndex == index
                                          ? ColorsManager.primaryColor
                                          : Colors.transparent,
                                  borderRadius: BorderRadius.circular(12.r),
                                  border: Border.all(
                                    color:
                                        selectedPaymentMethodIndex == index
                                            ? ColorsManager.primaryColor
                                            : ColorsManager.primaryColor,
                                    width:
                                        selectedPaymentMethodIndex == index
                                            ? 1.w
                                            : .5.w,
                                  ),
                                ),
                                child: Center(
                                  child: SvgPicture.asset(
                                    paymentMethods[index]["icon"],
                                    // width:
                                    //     paymentMethods[index]["size"], // Dynamic width
                                    // height:
                                    //     paymentMethods[index]["size"], // Dynamic height
                                    // ignore: deprecated_member_use
                                    color:
                                        index == 0
                                            ? null // First icon does not change color
                                            : selectedPaymentMethodIndex ==
                                                index
                                            ? Colors.white
                                            : null,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 24.h),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  } // Helper method to build individual time slot

  Widget _buildTimeSlot(String timeText, int index) {
    final timeSlots = isMorningSelected ? morningTimeSlots : afternoonTimeSlots;
    final isSelected = selectedTimeSlotIndex == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedTimeSlotIndex = index;
        });
      },
      child: Container(
        width: 75.w,
        height: 32.h,
        decoration: BoxDecoration(
          color:
              isSelected
                  ? ColorsManager.primaryColor
                  : ColorsManager.backGroundFormsColor,
          borderRadius: BorderRadius.circular(15.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha((.25 * 255).toInt()),
              blurRadius: 4.6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Center(
          child: Text(
            index < timeSlots.length ? timeSlots[index] : timeText,
            style: TextStyles.styleMedium(
              context,
              fontSize: 10.sp,
              color: isSelected ? Colors.white : ColorsManager.primaryColor,
            ),
          ),
        ),
      ),
    );
  }

  // Widget _buildPaymentMethod({
  //   required String icon,
  //   required int index,
  //   required bool isSelected,
  // }) {
  //   return GestureDetector(
  //     onTap: () {
  //       setState(() {
  //         selectedPaymentIndex = index;
  //       });
  //     },
  //     child: Container(
  //       width: 120,
  //       height: 60,
  //       decoration: BoxDecoration(
  //         color: isSelected ? const Color(0xFF2D5A5A) : Colors.white,
  //         // borderRadius: BorderRadius.circular(30),
  //         // border: Border.all(
  //         //   color:
  //         //       isSelected
  //         //           ? const Color(0xFF2D5A5A)
  //         //           : Colors.grey.withOpacity(0.3),
  //         //   width: 2,
  //         // ),
  //         boxShadow: [
  //           BoxShadow(
  //             color: Colors.black.withOpacity(0.08),
  //             blurRadius: 8,
  //             offset: const Offset(0, 2),
  //           ),
  //         ],
  //       ),
  //       child: Center(
  //         child: Image.asset(
  //           icon,
  //           width: 50,
  //           height: 30,
  //           fit: BoxFit.contain,
  //           color: isSelected ? Colors.white : null,
  //           colorBlendMode: isSelected ? BlendMode.srcIn : null,
  //         ),
  //       ),
  //     ),
  //   );
  // }
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
