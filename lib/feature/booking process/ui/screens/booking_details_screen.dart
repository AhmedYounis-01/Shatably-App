// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shatably_app/core/helpers/cache/storage_manager.dart';
import 'package:shatably_app/core/injection/injection_container.dart';
import 'package:shatably_app/core/services/stripe/stripe_service.dart';
import 'package:shatably_app/core/themes/colors_manager.dart';
import 'package:shatably_app/core/themes/text_styles.dart';
import 'package:shatably_app/core/utils/app_icons.dart';
import 'package:shatably_app/core/widgets/custom_app_button1.dart';
import 'package:shatably_app/core/widgets/custom_toast.dart';
import 'package:shatably_app/feature/booking%20process/data/models/model____for%20me/hire_details_model.dart';
import 'package:shatably_app/feature/booking%20process/data/models/payment_intent_input_model.dart';
import 'package:shatably_app/feature/booking%20process/logic/booking%20cubit/booking_cubit.dart';
import 'package:shatably_app/feature/booking%20process/logic/hire%20details/hire_details_cubit.dart';
import 'package:shatably_app/feature/booking%20process/logic/hire%20details/hire_details_state.dart';
import 'package:shatably_app/feature/booking%20process/ui/screens/transaction_faield.dart';
import 'package:shatably_app/feature/booking%20process/ui/screens/transaction_sucess.dart';
import 'package:shatably_app/feature/booking%20process/ui/widgets/booking%20details%20widgets/location_card.dart';
import 'package:shatably_app/feature/booking%20process/ui/widgets/booking%20details%20widgets/navigation_bar.dart'
    as booking_nav;
import 'package:shatably_app/feature/booking%20process/ui/widgets/booking%20details%20widgets/payment_method_widget.dart';
import 'package:shatably_app/feature/booking%20process/ui/widgets/booking%20details%20widgets/payment_summary.dart';
import 'package:shatably_app/feature/booking%20process/ui/widgets/booking%20details%20widgets/schedule_appointment.dart';
import 'package:shatably_app/feature/booking%20process/ui/widgets/booking%20details%20widgets/text_and_icon_widget.dart';
import 'package:toastification/toastification.dart';

class BookingDetailScreen extends StatefulWidget {
  final double amount;
  const BookingDetailScreen({super.key, required this.amount});

  @override
  State<BookingDetailScreen> createState() => _BookingDetailScreenState();
}

class _BookingDetailScreenState extends State<BookingDetailScreen> {
  int selectedPaymentIndex = 0;

  final List<Map<String, String>> paymentMethods = [
    {"title": "Visa Card", "icon": AppIcons.smallVisaIcon},
    {"title": "Cash Payment", "icon": AppIcons.smallCardIcon},
    {"title": "Master Card", "icon": AppIcons.smallApplePayIcon},
  ];

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
    );
    return Scaffold(
      backgroundColor: const Color(0XFFE5F1EF),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 60.h),
            // App Bar
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: const booking_nav.NavigationBar(title: "Hire Details"),
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
                    const TextAndIconWidget(title: "Your Locatin"),
                    SizedBox(height: 8.h),
                    LocationCard(
                      title: "Alexandria, Smouha",
                      subtitle: "Forem ipsum dolor sit amet, consectetur",
                      onTap: () {
                        print("Location card tapped!");
                      },
                    ),
                    SizedBox(height: 14.h),
                    const TextAndIconWidget(title: "Schedule Appointment"),
                    SizedBox(height: 8.h),
                    //? Schedule Appointment
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: const Color(0XFFF7FCFB),
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
                      child: const ScheduleAppointment(),
                    ),

                    SizedBox(height: 14.h),
                    //? Payment Methods
                    const TextAndIconWidget(title: "Payment Method"),
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
                        color: const Color(0XFFF7FCFB),
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
                      child: PaymentSummary(amount: widget.amount),
                    ),
                    SizedBox(height: 23.h),

                    BlocProvider(
                      create: (context) => sl<HireDetailsCubit>(),
                      child: BlocConsumer<HireDetailsCubit, HireDetailsState>(
                        listener: (context, state) {},
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
                              onPressed: () async {
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
                                // bookingId ??= bookingResponse?.bookingId;

                                if (bookingId != null) {
                                  print(
                                    "✅ Booking ID to use in hire: $bookingId",
                                  );

                                  final bookingDetailsRequest =
                                      BookingDetailsRequestModel(
                                        bookingId: bookingId,
                                        // أضف باقي الحقول حسب الحاجة
                                      );
                                  PaymentIntentInputModel
                                  paymentIntentInputModel =
                                      PaymentIntentInputModel(
                                        amount: widget.amount.toString(),
                                        currency: 'EGP',
                                        cusomerId: 'cus_SVRHbZtxfdcgSS',
                                      );
                                  await context
                                      .read<HireDetailsCubit>()
                                      .createBookingRecord(
                                        bookingDetailsRequest,
                                      )
                                      .then((payDetails) async {
                                        try {
                                          await StripeService().makePayment(
                                            paymentIntentInputModel:
                                                paymentIntentInputModel,
                                          );

                                          if (context.mounted) {
                                            Navigator.of(
                                              context,
                                            ).pushReplacement(
                                              MaterialPageRoute(
                                                builder:
                                                    (context) =>
                                                        const TransactionSucess(),
                                              ),
                                            );
                                          }
                                        } on StripeException catch (e) {
                                          if (e.error.code ==
                                              FailureCode.Canceled) {
                                            print("❌ Payment canceled by user");
                                            return;
                                          }
                                          print(
                                            "❌ Stripe error: ${e.error.message}",
                                          );
                                          if (context.mounted) {
                                            Navigator.of(
                                              context,
                                            ).pushReplacement(
                                              MaterialPageRoute(
                                                builder:
                                                    (context) =>
                                                        const TransactionFaield(),
                                              ),
                                            );
                                          }
                                        } catch (e) {
                                          print("❌ Payment error: $e");
                                          if (context.mounted) {
                                            Navigator.of(
                                              context,
                                            ).pushReplacement(
                                              MaterialPageRoute(
                                                builder:
                                                    (context) =>
                                                        const TransactionFaield(),
                                              ),
                                            );
                                          }
                                        }
                                      });
                                } else {
                                  print("❌ Booking ID not found anywhere");
                                  Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                      builder:
                                          (context) =>
                                              const TransactionFaield(),
                                    ),
                                  );
                                  customToast(
                                    context: context,
                                    message: 'Try again later',
                                    type: ToastificationType.error,
                                    icon: Icons.error,
                                  );
                                }
                              },
                              child: Text(
                                "Continue",
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
                    SizedBox(height: 100.h),
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
