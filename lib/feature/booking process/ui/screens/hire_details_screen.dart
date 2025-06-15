// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shatably_app/core/injection/injection_container.dart';
import 'package:shatably_app/core/themes/colors_manager.dart';
import 'package:shatably_app/core/themes/text_styles.dart';
import 'package:shatably_app/core/utils/app_icons.dart';
import 'package:shatably_app/core/utils/app_images.dart';
import 'package:shatably_app/core/widgets/custom_app_button1.dart';
import 'package:shatably_app/core/widgets/custom_toast.dart';
import 'package:shatably_app/feature/booking%20process/data/models/model____for%20me/book_model.dart';
import 'package:shatably_app/feature/booking%20process/data/models/model____for%20me/hire_details_model.dart';
import 'package:shatably_app/feature/booking%20process/logic/booking%20cubit/booking_cubit.dart';
import 'package:shatably_app/feature/booking%20process/logic/hire%20details/hire_details_cubit.dart';
import 'package:shatably_app/feature/booking%20process/logic/hire%20details/hire_details_state.dart';
import 'package:shatably_app/feature/home/ui/home_screen.dart';
import 'package:toastification/toastification.dart';

class BookingDetailScreen extends StatelessWidget {
  // final String? bookingId;
  final BookingResponseModel? bookingResponse;
  const BookingDetailScreen({super.key, this.bookingResponse});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
    );
    return Scaffold(
      backgroundColor: Color(0XFFE5F1EF),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 60.h),
            // App Bar
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: NavigationBar(title: "Hire Details"),
            ),
            SizedBox(height: 50.h),
            // Content
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25.r),
                  topRight: Radius.circular(25.r),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withAlpha((0.25 * 255).toInt()),
                    blurRadius: 4,
                    spreadRadius: 3,
                    offset: const Offset(0, 1),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    SizedBox(height: 20.h),
                    //? Location Card
                    TextAndIconWidget(title: "Your Locatin"),
                    SizedBox(height: 8.h),
                    LocationCard(
                      title: "Alexandria, Smouha",
                      subtitle: "Forem ipsum dolor sit amet, consectetur",
                      onTap: () {
                        print("Location card tapped!");
                      },
                    ),
                    SizedBox(height: 14.h),
                    TextAndIconWidget(title: "Schedule Appointment"),
                    SizedBox(height: 8.h),
                    //? Schedule Appointment
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: Color(0XFFF7FCFB),
                        borderRadius: BorderRadius.circular(15.r),
                        border: Border.all(
                          color: const Color(0xFFA6CDC6),
                          width: 1,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withAlpha((0.25 * 255).toInt()),
                            blurRadius: 4,
                          ),
                        ],
                      ),
                      child: ScheduleAppointment(),
                    ),

                    SizedBox(height: 14.h),
                    //? Payment Methods
                    TextAndIconWidget(title: "Payment Method"),
                    SizedBox(height: 8.h),
                    PaymentMethodWidget(
                      payIcon: AppIcons.smallVisaIcon,
                      title: "Credit Card",
                      isSelected: true,
                      onSelected: () {
                        print("Credit Card selected");
                      },
                    ),
                    SizedBox(height: 8.h),
                    PaymentMethodWidget(
                      payIcon: AppIcons.smallCardIcon,
                      title: "MasterCard",
                      isSelected: false,
                      onSelected: () {
                        print("MasterCard selected");
                      },
                    ),
                    SizedBox(height: 8.h),
                    PaymentMethodWidget(
                      payIcon: AppIcons.smallApplePayIcon,
                      title: "Apple pay",
                      isSelected: false,
                      onSelected: () {
                        print("Apple pay selected");
                      },
                    ),
                    SizedBox(height: 15.h),
                    //? Payment Summary
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Payment Summary",
                        style: TextStyles.styleMedium(
                          context,
                          fontSize: 16.sp,
                          color: ColorsManager.primaryColor,
                        ),
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 15,
                      ),
                      decoration: BoxDecoration(
                        color: Color(0XFFF7FCFB),
                        borderRadius: BorderRadius.circular(15.r),
                        border: Border.all(
                          color: const Color(0xFFA6CDC6),
                          width: 1,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withAlpha((0.25 * 255).toInt()),
                            blurRadius: 4,
                          ),
                        ],
                      ),
                      child: PaymentSummary(),
                    ),
                    SizedBox(height: 23.h),

                    // الزر بتاع الـ Confirm
                    // MultiBlocProvider(
                    //   providers: [
                    //     BlocProvider(
                    //       create: (context) => sl<HireDetailsCubit>(),
                    //     ),
                    //     BlocProvider(create: (context) => sl<BookingCubit>()),
                    //   ],
                    //   child: BlocConsumer<HireDetailsCubit, HireDetailsState>(
                    //     listener: (context, state) {
                    //       if (state.status == HireDetailsStates.error) {
                    //         customToast(
                    //           context: context,
                    //           message:
                    //               state.errorMessage ??
                    //               'Failed to book service.',
                    //           type: ToastificationType.error,
                    //           icon: Icons.error,
                    //         );
                    //       } else if (state.status ==
                    //           HireDetailsStates.success) {
                    //         customToast(
                    //           context: context,
                    //           message: 'Service booked successfully.',
                    //           type: ToastificationType.success,
                    //           icon: Icons.check_circle,
                    //         );

                    //         Navigator.push(
                    //           context,
                    //           MaterialPageRoute(
                    //             builder: (context) => HomeScreen(),
                    //           ),
                    //         );
                    //       }
                    //     },
                    //     builder: (
                    //       BuildContext context,
                    //       HireDetailsState state,
                    //     ) {
                    //       return Center(
                    //         child: CustomAppButton1(
                    //           width: 150.w,
                    //           height: 50.h,
                    //           hasShadow: true,
                    //           borderRadius: 25.r,
                    //           onPressed: () {
                    //             final bookingId =
                    //                 context
                    //                     .read<BookingCubit>()
                    //                     .state
                    //                     .bookingResponseModel
                    //                     ?.bookingId;

                    //             if (bookingId != null) {
                    //               print("✅ Booking ID to use in hire: //");

                    //               final bookingDetailsRequest =
                    //                   BookingDetailsRequestModel(
                    //                     bookingId: bookingId,
                    //                     // أضف باقي الحقول حسب الحاجة
                    //                   );

                    //               context
                    //                   .read<HireDetailsCubit>()
                    //                   .createBookingRecord(
                    //                     bookingDetailsRequest,
                    //                   );
                    //             } else {
                    //               print(
                    //                 "❌ Booking ID not found in BookingCubit state",
                    //               );
                    //               customToast(
                    //                 context: context,
                    //                 message: 'Booking ID not found',
                    //                 type: ToastificationType.error,
                    //                 icon: Icons.error,
                    //               );
                    //             }
                    //           },
                    //           child: Text(
                    //             "Confirm",
                    //             style: TextStyles.styleMedium(
                    //               context,
                    //               fontSize: 16.sp,
                    //               color: Colors.white,
                    //             ),
                    //           ),
                    //         ),
                    //       );
                    //     },
                    //   ),
                    // ),
                    // استبدل الـ MultiBlocProvider section بـ:
                    // إذا كنت محتاج تستخدم الـ BookingCubit من parent widget
                    // استخدم BlocProvider.of بدلاً من context.read
                    BlocProvider(
                      create: (context) => sl<HireDetailsCubit>(),
                      child: BlocConsumer<HireDetailsCubit, HireDetailsState>(
                        listener: (context, state) {
                          if (state.status == HireDetailsStates.error) {
                            customToast(
                              context: context,
                              message:
                                  state.errorMessage ??
                                  'Failed to book service.',
                              type: ToastificationType.error,
                              icon: Icons.error,
                            );
                          } else if (state.status ==
                              HireDetailsStates.success) {
                            customToast(
                              context: context,
                              message: 'Service booked successfully.',
                              type: ToastificationType.success,
                              icon: Icons.check_circle,
                            );

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HomeScreen(),
                              ),
                            );
                          }
                        },
                        builder: (
                          BuildContext context,
                          HireDetailsState state,
                        ) {
                          return Center(
                            child: CustomAppButton1(
                              width: 150.w,
                              height: 50.h,
                              hasShadow: true,
                              borderRadius: 25.r,
                              onPressed: () {
                                String? bookingId;

                                // جرب تاخد الـ bookingId من الـ parent BookingCubit
                                try {
                                  final bookingCubit =
                                      BlocProvider.of<BookingCubit>(
                                        context,
                                        listen: false,
                                      );
                                  bookingId =
                                      bookingCubit
                                          .state
                                          .bookingResponseModel
                                          ?.bookingId;
                                  print("✅ من BookingCubit: $bookingId");
                                } catch (e) {
                                  print(
                                    "❌ مش قادر أجيب BookingCubit من الـ parent: $e",
                                  );
                                }

                                // لو مش موجود، استخدم الـ bookingResponse من الـ constructor
                                bookingId ??= bookingResponse?.bookingId;

                                if (bookingId != null) {
                                  print(
                                    "✅ Booking ID to use in hire: $bookingId",
                                  );

                                  final bookingDetailsRequest =
                                      BookingDetailsRequestModel(
                                        bookingId: bookingId,
                                        // أضف باقي الحقول حسب الحاجة
                                      );

                                  context
                                      .read<HireDetailsCubit>()
                                      .createBookingRecord(
                                        bookingDetailsRequest,
                                      );
                                } else {
                                  print("❌ Booking ID not found anywhere");
                                  customToast(
                                    context: context,
                                    message: 'Booking ID not found',
                                    type: ToastificationType.error,
                                    icon: Icons.error,
                                  );
                                }
                              },
                              child: Text(
                                "Confirm",
                                style: TextStyles.styleMedium(
                                  context,
                                  fontSize: 16.sp,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 10.h),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PaymentSummary extends StatelessWidget {
  const PaymentSummary({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              "Method",
              style: TextStyles.styleMedium(
                context,
                fontSize: 14.sp,
                color: ColorsManager.primaryColor.withAlpha(
                  (.50 * 255).toInt(),
                ),
              ),
            ),
            Spacer(),
            Text(
              "Visa Card",
              style: TextStyles.styleMedium(
                context,
                fontSize: 14.sp,
                color: ColorsManager.primaryColor,
              ),
            ),
          ],
        ),
        SizedBox(height: 8.h),
        Row(
          children: [
            Text(
              "Account name:",
              style: TextStyles.styleMedium(
                context,
                fontSize: 14.sp,
                color: ColorsManager.primaryColor.withAlpha(
                  (.50 * 255).toInt(),
                ),
              ),
            ),
            Spacer(),
            Text(
              "Abdelrahman Morgan",
              style: TextStyles.styleMedium(
                context,
                fontSize: 14.sp,
                color: ColorsManager.primaryColor,
              ),
            ),
          ],
        ),
        SizedBox(height: 8.h),
        Row(
          children: [
            Text(
              "Discount:",
              style: TextStyles.styleMedium(
                context,
                fontSize: 14.sp,
                color: ColorsManager.primaryColor.withAlpha(
                  (.50 * 255).toInt(),
                ),
              ),
            ),
            Spacer(),
            Text(
              "25%",
              style: TextStyles.styleMedium(
                context,
                fontSize: 14.sp,
                color: ColorsManager.primaryColor,
              ),
            ),
          ],
        ),
        SizedBox(height: 8.h),
        Row(
          children: [
            Text(
              "Total:",
              style: TextStyles.styleMedium(
                context,
                fontSize: 14.sp,
                color: ColorsManager.primaryColor.withAlpha(
                  (.50 * 255).toInt(),
                ),
              ),
            ),
            Spacer(),
            Text(
              "787.5",
              style: TextStyles.styleMedium(
                context,
                fontSize: 14.sp,
                color: ColorsManager.primaryColor,
              ).copyWith(
                shadows: [
                  Shadow(
                    blurRadius: 4.3,
                    color: Colors.black.withAlpha((.25 * 255).toInt()),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class PaymentMethodWidget extends StatelessWidget {
  final String payIcon;
  final String title;
  final bool isSelected;
  final void Function()? onSelected;
  final IconData selectedRadioIcon;
  final IconData unselectedRadioIcon;

  const PaymentMethodWidget({
    super.key,
    required this.payIcon,
    required this.title,
    required this.isSelected,
    required this.onSelected,
    this.selectedRadioIcon = Icons.radio_button_checked,
    this.unselectedRadioIcon = Icons.radio_button_unchecked,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onSelected,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: isSelected ? Color(0XFFCCDBDF) : Color(0XFFF7FCFB),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: const Color(0xFFA6CDC6), width: 1),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha((0.25 * 255).toInt()),
              blurRadius: 4,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 20.r,
              backgroundColor: Color(0XFFBBBBBB),
              child: SvgPicture.asset(payIcon),
            ),
            SizedBox(width: 8.w),
            Text(
              title,
              style: TextStyles.styleMedium(
                context,
                fontSize: 12.sp,
                color:
                    isSelected
                        ? ColorsManager.primaryColor
                        : ColorsManager.primaryColor.withAlpha(
                          (.68 * 255).toInt(),
                        ),
              ),
            ),
            Spacer(),
            Icon(
              isSelected ? selectedRadioIcon : unselectedRadioIcon,
              color: ColorsManager.primaryColor,
            ),
          ],
        ),
      ),
    );
  }
}

class TextAndIconWidget extends StatelessWidget {
  final String title;
  const TextAndIconWidget({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: TextStyles.styleMedium(
            context,
            fontSize: 16.sp,
            color: ColorsManager.primaryColor,
          ),
        ),
        Spacer(),
        SvgPicture.asset(AppIcons.pinIcon),
      ],
    );
  }
}

class NavigationBar extends StatelessWidget {
  final String title;

  const NavigationBar({required this.title, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
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
              title,
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w500,
                color: ColorsManager.primaryColor,
              ),
            ),
          ),
        ),
        SizedBox(width: 32.w),
      ],
    );
  }
}

class LocationCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final VoidCallback? onTap;

  const LocationCard({
    super.key,
    required this.title,
    required this.subtitle,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Color(0XFFF7FCFB),
          borderRadius: BorderRadius.circular(15.r),
          border: Border.all(color: const Color(0xFFA6CDC6), width: 1),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha((0.25 * 255).toInt()),
              blurRadius: 4,
            ),
          ],
        ),
        child: Row(
          children: [
            // Map Icon Container
            SizedBox(
              width: 68.w,
              height: 70.h,
              child: Image.asset(AppImages.mapImage, fit: BoxFit.fill),
            ),
            const SizedBox(width: 16),
            // Text Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyles.styleBold(
                      context,
                      fontSize: 16,
                      color: ColorsManager.primaryColor,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyles.styleBold(
                      context,
                      fontSize: 12,
                      color: ColorsManager.primaryColor.withAlpha(
                        (.50 * 255).toInt(),
                      ),
                    ),
                  ), // Arrow Icon
                  Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      child: SvgPicture.asset(
                        AppIcons.yellowArrowIcon2,
                        width: 18.w,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ScheduleAppointment extends StatelessWidget {
  const ScheduleAppointment({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              "Date:",
              style: TextStyles.styleMedium(
                context,
                fontSize: 14.sp,
                color: ColorsManager.primaryColor.withAlpha(
                  (.50 * 255).toInt(),
                ),
              ),
            ),
            Spacer(),
            Text(
              "16 June 2025",
              style: TextStyles.styleMedium(
                context,
                fontSize: 14.sp,
                color: ColorsManager.primaryColor,
              ),
            ),
          ],
        ),
        SizedBox(height: 16.h),
        Row(
          children: [
            Text(
              "Time:",
              style: TextStyles.styleMedium(
                context,
                fontSize: 14.sp,
                color: ColorsManager.primaryColor.withAlpha(
                  (.50 * 255).toInt(),
                ),
              ),
            ),
            Spacer(),
            Text(
              "2PM to 5PM",
              style: TextStyles.styleMedium(
                context,
                fontSize: 14.sp,
                color: ColorsManager.primaryColor,
              ),
            ),
          ],
        ),
        SizedBox(height: 16.h),
        Row(
          children: [
            Text(
              "Duration:",
              style: TextStyles.styleMedium(
                context,
                fontSize: 14.sp,
                color: ColorsManager.primaryColor.withAlpha(
                  (.50 * 255).toInt(),
                ),
              ),
            ),
            Spacer(),
            Text(
              "3 Hours",
              style: TextStyles.styleMedium(
                context,
                fontSize: 14.sp,
                color: ColorsManager.primaryColor,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
