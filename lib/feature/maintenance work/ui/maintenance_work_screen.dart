import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shatably_app/core/themes/colors_manager.dart';
import 'package:shatably_app/core/themes/text_styles.dart';
import 'package:shatably_app/core/utils/app_icons.dart';
import 'package:shatably_app/core/widgets/custom_app_button1.dart';
import 'package:shatably_app/feature/maintenance%20work/logic/cubit/maintenance_work_cubit.dart';
import 'package:shatably_app/feature/maintenance%20work/logic/cubit/maintenance_work_state.dart';

class MaintenanceWorkScreen extends StatelessWidget {
  const MaintenanceWorkScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(0),
        child: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.light,
          ),
        ),
      ),
      body: BlocBuilder<MaintenanceWorkCubit, MaintenanceWorkState>(
        builder: (context, state) {
          if (state.status == ServicesStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state.status == ServicesStatus.error) {
            return Center(child: Text(state.errorMessage ?? ''));
          }
          return Stack(
            children: [
              Stack(
                children: [
                  // Background Image
                  SizedBox(
                    width: double.infinity,
                    height: 400.h,
                    child: Image.network(
                      state.maintenanceServiceModel?.imageUrl ?? '',
                      fit: BoxFit.cover,
                      // width: double.infinity,
                      // height: double.infinity,
                    ),
                  ),
                  // Gradient
                  Container(
                    width: double.infinity,
                    height: double.infinity,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black.withAlpha((.10 * 255).toInt()),
                          Colors.black.withAlpha((.30 * 255).toInt()),
                          Colors.black.withAlpha((.30 * 255).toInt()),
                          Colors.black.withAlpha((.60 * 255).toInt()),
                          Colors.black.withAlpha((.10 * 255).toInt()),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              SafeArea(
                child: Column(
                  children: [
                    SizedBox(height: 30.h),
                    // Back Button and Title
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {},
                            child: Container(
                              width: 30.w,
                              height: 30.h,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color(0xFFA6CDC6),
                              ),
                              child: Center(
                                child: SvgPicture.asset(
                                  "assets/icons/arrow_ios.svg",
                                  width: 15.w,
                                  height: 15.h,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Center(
                              child: Text(
                                state.maintenanceServiceModel?.name ?? '',
                                style: TextStyle(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 30.w), // Balance the spacing
                        ],
                      ),
                    ),

                    // Expanded(
                    //   child: Container(),
                    // ), // Push the service details card to the bottom
                    SizedBox(height: 274.h),
                    // Service Details Container
                    Expanded(
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
                            // Drag indicator
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
                            // Service title
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 26.w),
                              child: Text(
                                state.maintenanceServiceModel?.description ??
                                    '',
                                style: TextStyles.styleMedium(
                                  context,
                                  fontSize: 16.sp,
                                  color: const Color(0xFF1C4857),
                                ),
                              ),
                            ),
                            SizedBox(height: 5.h),
                            //! evaluted rating
                            // ! التقييم (Evaluated Rating) - تم التعديل هنا
                            // نفترض أن serviceModel يحتوي الآن على قائمة من العمال
                            // التحقق مما إذا كانت هناك تقييمات متاحة بناءً على عدد المراجعات
                            // التحقق مما إذا كانت هناك تقييمات متاحة بناءً على عدد المراجعات
                            if (state.maintenanceServiceModel?.reviewCount !=
                                    null &&
                                state.maintenanceServiceModel!.reviewCount > 0)
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 23.w),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    // عرض النجوم بناءً على متوسط تقييم الخدمة
                                    ...List.generate(5, (index) {
                                      return Icon(
                                        index <
                                                (state
                                                        .maintenanceServiceModel
                                                        ?.averageRating ??
                                                    0)
                                            ? Icons
                                                .star // نجمة ممتلئة إذا كان الفهرس أقل من متوسط التقييم
                                            : Icons
                                                .star_border, // نجمة فارغة بخلاف ذلك
                                        color: const Color(
                                          0xFFDDA853, // لون ذهبي للنجوم
                                        ),
                                        size: 20.h, // حجم النجمة
                                      );
                                    }),
                                    SizedBox(
                                      width: 4.w,
                                    ), // مسافة بين النجوم وعدد المراجعات
                                    // عرض عدد المراجعات للخدمة
                                    Text(
                                      "(${(state.maintenanceServiceModel?.reviewCount ?? 0)})", // عرض عدد المراجعات بين قوسين
                                      style: TextStyles.styleRegular(
                                        context,
                                        fontSize: 14.sp,
                                        color: const Color(
                                          0XFF16404D, // لون النص
                                        ).withAlpha(
                                          (.5 * 255)
                                              .toInt(), // شفافية 50% للون النص
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            else
                              // رسالة بديلة إذا لم تكن هناك بيانات تقييم للخدمة (عدد المراجعات 0)
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 23.w),
                                child: Text(
                                  'No rating available', // نص يشير إلى عدم توفر تقييمات
                                  style: TextStyles.styleRegular(
                                    context,
                                    fontSize: 14.sp,
                                    color: const Color(
                                      0XFF16404D,
                                    ).withAlpha((.5 * 255).toInt()),
                                  ),
                                ),
                              ),
                            SizedBox(height: 28.h),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 0.w),
                              child: Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    _buildServiceFilter(
                                      context,
                                      AppIcons.takyeefIcon,
                                      "Install",
                                      isLast: false,
                                    ),
                                    _buildServiceFilter(
                                      context,
                                      AppIcons.wrenchIcon,
                                      "Repair",
                                      isLast: false,
                                    ),
                                    _buildServiceFilter(
                                      context,
                                      AppIcons.renewIcon,
                                      "Renew",
                                      isLast: true,
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            SizedBox(height: 20.h),
                            // Service details
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 26.w),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Details',
                                    style: TextStyles.styleMedium(
                                      context,
                                      fontSize: 16.sp,
                                      color: ColorsManager.primaryColor,
                                    ),
                                  ),
                                  SizedBox(height: 8.h),
                                  RichText(
                                    text: TextSpan(
                                      text:
                                          state
                                              .maintenanceServiceModel
                                              ?.details ??
                                          '',
                                      style: TextStyles.styleRegular(
                                        context,
                                        fontSize: 14.sp,
                                        color: Color(
                                          0XFF16404D,
                                        ).withAlpha((.8 * 255).toInt()),
                                      ),
                                      children: [
                                        TextSpan(
                                          text: 'Read more',
                                          style: TextStyles.styleBold(
                                            context,
                                            fontSize: 14.sp,
                                            color: Color(0XFF003076),
                                          ),
                                          recognizer:
                                              TapGestureRecognizer()
                                                ..onTap = () {
                                                  // Read more action
                                                },
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 40.h),
                            // Price and Book Now
                            Container(
                              width: double.infinity,
                              padding: EdgeInsets.symmetric(vertical: 10.h),
                              decoration: BoxDecoration(
                                color: const Color(0xFFE4EFED),
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(25.r),
                                  topRight: Radius.circular(25.r),
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withAlpha(
                                      (.25 * 255).toInt(),
                                    ),
                                    offset: const Offset(0, -4),
                                    spreadRadius: -1,
                                    blurRadius: 4.8,
                                  ),
                                ],
                              ),
                              child: Column(
                                children: [
                                  SizedBox(height: 20.h),
                                  // Price
                                  Center(
                                    child: RichText(
                                      text: TextSpan(
                                        children: [
                                          TextSpan(
                                            text:
                                                state
                                                    .maintenanceServiceModel
                                                    ?.price
                                                    .toString() ??
                                                "",
                                            style: TextStyles.styleMedium(
                                              context,
                                              fontSize: 16.sp,
                                              color: ColorsManager.primaryColor,
                                            ),
                                          ),
                                          TextSpan(
                                            text: ' Per Hour',
                                            style: TextStyles.styleMedium(
                                              context,
                                              fontSize: 14.sp,
                                              color: ColorsManager.primaryColor
                                                  .withAlpha(
                                                    (.53 * 255).toInt(),
                                                  ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 12.h),
                                  // Book Now button
                                  Center(
                                    child: CustomAppButton1(
                                      width: 145.w,
                                      height: 50.h,
                                      onPressed: () {},
                                      backgroundColor: const Color(0xFF1C4857),
                                      borderRadius: 25.r,
                                      hasShadow: true,
                                      child: Text(
                                        'Book Now',
                                        style: TextStyles.styleMedium(
                                          context,
                                          fontSize: 16.sp,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildServiceFilter(
    BuildContext context,
    String icon,
    String label, {
    bool isLast = false,
  }) {
    return Row(
      children: [
        SvgPicture.asset(icon, width: 20.w, height: 20.h),
        SizedBox(width: 8.w),
        Text(
          label,
          style: TextStyles.styleRegular(
            context,
            fontSize: 14.sp,
            color: ColorsManager.primaryColor,
          ),
        ),
        SizedBox(width: 17.w),
        if (!isLast) ...[
          SizedBox(width: 8.w),
          Container(
            width: 1.w,
            height: 12.h,
            decoration: BoxDecoration(color: Colors.amber),
          ),
          SizedBox(width: 16.w),
        ],
      ],
    );
  }
}
