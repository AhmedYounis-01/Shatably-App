import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shatably_app/core/themes/colors_manager.dart';
import 'package:shatably_app/core/themes/text_styles.dart';
import 'package:shatably_app/core/utils/app_icons.dart';
import 'package:shatably_app/core/widgets/custom_toast.dart';
import 'package:shatably_app/feature/booking%20process/data/models/model____for%20me/book_model.dart';
import 'package:shatably_app/feature/booking%20process/logic/booking%20cubit/booking_cubit.dart';
import 'package:shatably_app/feature/booking%20process/logic/booking%20cubit/booking_state.dart';
import 'package:shatably_app/feature/booking%20process/ui/screens/booking_details_screen.dart';
import 'package:shatably_app/feature/booking%20process/ui/widgets/book%20widgets/booking_calendar.dart';
import 'package:shatably_app/feature/booking%20process/ui/widgets/book%20widgets/booking_header.dart';
import 'package:shatably_app/feature/booking%20process/ui/widgets/book%20widgets/payment_method_selection.dart';
import 'package:shatably_app/feature/booking%20process/ui/widgets/book%20widgets/time_slot_selection.dart';
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
  final ValueNotifier<DateTime?> selectedDateNotifier = ValueNotifier(null);
  final ValueNotifier<String?> selectedTimeSlotNotifier = ValueNotifier(null);
  final ValueNotifier<int?> selectedPaymentMethodIndexNotifier = ValueNotifier(
    null,
  );

  DateTime _currentDisplayMonth = DateTime.now();
  int? _selectedDayIndex;
  bool isMorningSelected = true;

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

  List<DateTime> _getDaysForMonth(DateTime month) {
    List<DateTime> days = [];
    final now = DateTime.now();
    final startOfToday = DateTime(now.year, now.month, now.day);
    DateTime firstDayOfMonth = DateTime(month.year, month.month, 1);
    DateTime lastDayOfMonth = DateTime(month.year, month.month + 1, 0);

    for (int i = 0; i < lastDayOfMonth.day; i++) {
      DateTime day = firstDayOfMonth.add(Duration(days: i));
      if (day.isAfter(startOfToday.subtract(const Duration(days: 1)))) {
        days.add(day);
      }
    }
    return days;
  }

  void _updateMonth(int offset) {
    setState(() {
      _currentDisplayMonth = DateTime(
        _currentDisplayMonth.year,
        _currentDisplayMonth.month + offset,
        1,
      );
      _selectedDayIndex = null;
      selectedDateNotifier.value = null;
    });
  }

  void _handleBooking(int index) {
    selectedPaymentMethodIndexNotifier.value = index;
    BookingRequestModel bookingRequest;

    if (widget.serviceType == 'Maintenance') {
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
    context.read<BookingCubit>().bookService(bookingRequest);
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
          BookingHeader(imageUrl: widget.image, title: "Booking"),
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
                    offset: const Offset(0, -4),
                  ),
                ],
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 13.4.h),
                    _buildDragIndicator(),
                    SizedBox(height: 15.5.h),
                    _buildHeaderTitle("Get Schedule"),
                    SizedBox(height: 17.h),
                    _buildTextSection(
                      "When Should The Professional arrive",
                      "Pick a date and time that works best for your schedule.",
                    ),
                    SizedBox(height: 20.h),
                    BookingCalendar(
                      currentDisplayMonth: _currentDisplayMonth,
                      days: _getDaysForMonth(_currentDisplayMonth),
                      selectedDayIndex: _selectedDayIndex,
                      onPreviousMonth: () => _updateMonth(-1),
                      onNextMonth: () => _updateMonth(1),
                      onDaySelected: (index, day) {
                        setState(() {
                          _selectedDayIndex = index;
                          selectedDateNotifier.value = day;
                        });
                      },
                    ),
                    SizedBox(height: 24.h),
                    _buildSectionTitle("Available Slots"),
                    SizedBox(height: 18.h),
                    ValueListenableBuilder<String?>(
                      valueListenable: selectedTimeSlotNotifier,
                      builder: (context, selectedTimeSlot, _) {
                        return TimeSlotSelection(
                          isMorningSelected: isMorningSelected,
                          morningTimeSlots: morningTimeSlots,
                          afternoonTimeSlots: afternoonTimeSlots,
                          selectedTimeSlot: selectedTimeSlot,
                          onMorningSelected:
                              () => setState(() {
                                isMorningSelected = true;
                                selectedTimeSlotNotifier.value = null;
                              }),
                          onAfternoonSelected:
                              () => setState(() {
                                isMorningSelected = false;
                                selectedTimeSlotNotifier.value = null;
                              }),
                          onTimeSlotSelected:
                              (slot) => selectedTimeSlotNotifier.value = slot,
                        );
                      },
                    ),
                    SizedBox(height: 28.h),
                    _buildSectionTitle("Payment Methods"),
                    SizedBox(height: 20.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24.w),
                      child: ValueListenableBuilder<int?>(
                        valueListenable: selectedPaymentMethodIndexNotifier,
                        builder: (context, selectedPaymentIndex, _) {
                          return PaymentMethodSelection(
                            paymentMethods: paymentMethods,
                            selectedIndex: selectedPaymentIndex,
                            onSelect: _handleBooking,
                          );
                        },
                      ),
                    ),
                    _buildBookingBlocListener(),
                    SizedBox(height: 100.h),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDragIndicator() {
    return Center(
      child: Container(
        width: 25.w,
        height: 2.h,
        decoration: BoxDecoration(
          color: ColorsManager.primaryColor.withAlpha((43 * 255).toInt()),
          borderRadius: BorderRadius.circular(2.r),
        ),
      ),
    );
  }

  Widget _buildHeaderTitle(String title) {
    return Center(
      child: Text(
        title,
        style: TextStyles.styleMedium(
          context,
          fontSize: 16.sp,
          color: ColorsManager.primaryColor,
        ),
      ),
    );
  }

  Widget _buildTextSection(String title, String subtitle) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyles.styleMedium(
              context,
              fontSize: 18.sp,
              color: ColorsManager.primaryColor,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            subtitle,
            style: TextStyles.styleRegular(
              context,
              fontSize: 14.sp,
              color: ColorsManager.primaryColor.withAlpha((.64 * 255).toInt()),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Text(
        title,
        style: TextStyles.styleMedium(
          context,
          fontSize: 16.sp,
          color: ColorsManager.primaryColor,
        ),
      ),
    );
  }

  Widget _buildBookingBlocListener() {
    return BlocListener<BookingCubit, BookingState>(
      listener: (context, state) {
        if (state.status == BookingStates.error) {
          customToast(
            context: context,
            message: state.errorMessage ?? 'Failed to book service.',
            type: ToastificationType.error,
            icon: Icons.error,
          );
        } else if (state.status == BookingStates.success) {
          context.read<BookingCubit>().logBookingId();
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const BookingDetailScreen(),
            ),
          );
        }
      },
      child: const SizedBox.shrink(),
    );
  }
}
