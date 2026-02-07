import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shatably_app/core/utils/app_icons.dart';
import 'package:shatably_app/feature/booking%20process/ui/widgets/payment%20widgets/card_input_fields.dart';
import 'package:shatably_app/feature/booking%20process/ui/widgets/payment%20widgets/my_card_section.dart';
import 'package:shatably_app/feature/booking%20process/ui/widgets/payment%20widgets/payment_navigation_bar.dart';
import 'package:shatably_app/feature/booking%20process/ui/widgets/payment%20widgets/payment_options.dart';
import 'package:shatably_app/feature/booking%20process/ui/widgets/payment%20widgets/payment_save_button.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  int? selectedPaymentMethodIndex;
  final List<Map<String, dynamic>> paymentMethods = [
    {"name": "Mastercard", "icon": AppIcons.baymentIcon1},
    {"name": "Visa", "icon": AppIcons.baymentIcon2},
    {"name": "Apple Pay", "icon": AppIcons.baymentIcon3},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0XFFE5F1EF),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 60.h),
              const PaymentNavigationBar(title: "Payment Method"),
              SizedBox(height: 30.h),
              PaymentOptions(
                paymentMethods: paymentMethods,
                selectedIndex: selectedPaymentMethodIndex,
                onSelect: (index) {
                  setState(() {
                    selectedPaymentMethodIndex = index;
                  });
                },
              ),
              SizedBox(height: 34.h),
              const MyCardSection(),
              SizedBox(height: 34.h),
              const CardInputFields(),
              SizedBox(height: 43.h),
              PaymentSaveButton(onPressed: () {}),
              SizedBox(height: 40.h),
            ],
          ),
        ),
      ),
    );
  }
}
