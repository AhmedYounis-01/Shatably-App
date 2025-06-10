import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shatably_app/core/themes/colors_manager.dart';
import 'package:shatably_app/core/themes/text_styles.dart';
import 'package:shatably_app/core/utils/app_icons.dart';
import 'package:shatably_app/core/utils/app_images.dart';
import 'package:shatably_app/core/widgets/custom_app_button1.dart';
import 'package:shatably_app/core/widgets/custom_text_form_field2.dart';

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
              const NavigationBar(title: "Payment Method"),
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
              const SaveButton(),
            ],
          ),
        ),
      ),
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
              style: TextStyles.styleMedium(
                context,
                fontSize: 18.sp,
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

class PaymentOptions extends StatelessWidget {
  final List<Map<String, dynamic>> paymentMethods;
  final int? selectedIndex;
  final Function(int) onSelect;

  const PaymentOptions({
    required this.paymentMethods,
    required this.selectedIndex,
    required this.onSelect,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Row(
        children: List.generate(
          paymentMethods.length,
          (index) => Expanded(
            child: GestureDetector(
              onTap: () => onSelect(index),
              child: Container(
                height: 50.h,
                margin: EdgeInsets.only(
                  right: index < paymentMethods.length - 1 ? 8.w : 0,
                ),
                decoration: BoxDecoration(
                  color:
                      selectedIndex == index
                          ? ColorsManager.primaryColor
                          : Colors.transparent,
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(
                    color: ColorsManager.primaryColor,
                    width: selectedIndex == index ? 1.w : .5.w,
                  ),
                ),
                child: Center(
                  child: SvgPicture.asset(
                    paymentMethods[index]["icon"],
                    // width: paymentMethods[index]["size"],
                    // height: paymentMethods[index]["size"],
                    // ignore: deprecated_member_use
                    color:
                        index == 0
                            ? null
                            : selectedIndex == index
                            ? Colors.white
                            : null,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class MyCardSection extends StatelessWidget {
  const MyCardSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "My Card",
          style: TextStyles.styleMedium(
            context,
            fontSize: 16.sp,
            color: ColorsManager.primaryColor,
          ),
        ),
        SizedBox(height: 10.h),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(20.w),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20.r)),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF000000).withAlpha((0.22 * 255).toInt()),
                offset: const Offset(0, 1),
                blurRadius: 34.4.r,
                spreadRadius: 0,
              ),
            ],
            gradient: LinearGradient(
              begin: Alignment.bottomRight,
              end: Alignment.topLeft,
              colors: [
                Color(0xFF77A4B3).withAlpha((0.7 * 255).toInt()),
                Color(0xFF16404D).withAlpha((0.7 * 255).toInt()),
              ],
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(AppImages.visaIcon, width: 80.w, height: 30.h),
              SizedBox(height: 21.h),
              Image.asset(AppImages.visaIcon2, width: 25.w, height: 19.h),
              SizedBox(height: 7.5.h),
              Text(
                "0000 0000 0000 0000",
                style: TextStyles.styleRegular(
                  context,
                  fontSize: 20.sp,
                  color: Colors.white,
                ).copyWith(wordSpacing: 10.w),
              ),
              Text(
                "Abdelrahman Morgan",
                style: TextStyles.styleRegular(
                  context,
                  fontSize: 14.sp,
                  color: Colors.white,
                ),
              ),
              Text(
                "09/26",
                style: TextStyles.styleRegular(
                  context,
                  fontSize: 10.sp,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class CardInputFields extends StatelessWidget {
  const CardInputFields({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            SizedBox(
              width: 166.w,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Cardholder Name*",
                    style: TextStyles.styleMedium(
                      context,
                      fontSize: 14.sp,
                      color: ColorsManager.primaryColor,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  SizedBox(
                    height: 32.h,
                    child: CustomTextFormField2(
                      hintText: "Abdelrahman Morgan",
                      fontSize: 11.sp,
                      textAlign: TextAlign.start,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 14.w),
            SizedBox(
              width: 161.w,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "CVV*",
                    style: TextStyles.styleMedium(
                      context,
                      fontSize: 14.sp,
                      color: ColorsManager.primaryColor,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  SizedBox(
                    height: 32.h,
                    child: CustomTextFormField2(
                      hintText: "035",
                      fontSize: 11.sp,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 11.h),
        SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Cardholder Name*",
                style: TextStyles.styleMedium(
                  context,
                  fontSize: 14.sp,
                  color: ColorsManager.primaryColor,
                ),
              ),
              SizedBox(height: 4.h),
              SizedBox(
                height: 32.h,
                child: CustomTextFormField2(
                  hintText: "0000 0000 0000 0000",
                  fontSize: 11.sp,
                  textAlign: TextAlign.start,
                  hintWordSpacing: 10.w,
                  textWordSpacing: 10.w,
                  suffixIcon: AppIcons.bocketCard,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class SaveButton extends StatelessWidget {
  const SaveButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CustomAppButton1(
        onPressed: () {},
        width: 145.w,
        height: 50.h,
        borderRadius: 25.r,
        child: Text(
          "Save",
          style: TextStyles.styleMedium(
            context,
            fontSize: 16.sp,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
