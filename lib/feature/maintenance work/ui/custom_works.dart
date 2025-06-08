import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shatably_app/core/themes/colors_manager.dart';
import 'package:shatably_app/core/themes/text_styles.dart';
import 'package:shatably_app/core/widgets/custom_app_button1.dart';

class CustomMaintenanceWorkScreen extends StatelessWidget {
  final String title;
  final String backgroundImage;
  final String serviceTitle;
  final String serviceDetails;
  final String price;
  final List<Map<String, dynamic>> filters;
  final List<WorkerInfo> workers;

  final VoidCallback onBookNow;

  const CustomMaintenanceWorkScreen({
    super.key,
    required this.title,
    required this.backgroundImage,
    required this.serviceTitle,
    required this.serviceDetails,
    required this.price,
    required this.filters,
    required this.onBookNow,
    required this.workers,
  });

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
      body: Stack(
        children: [
          // Background Image
          // Positioned.fill(
          //   // <-- Positioned is now a direct child of Stack
          //   child: Container(
          //     // <-- The Container now wraps the Image and can apply the gradient
          //     decoration: BoxDecoration(
          //       color: Colors.red,
          //       gradient: LinearGradient(
          //         colors: [
          //           Colors.black.withAlpha((.0 * 255).toInt()),
          //           Colors.black.withAlpha((.26 * 255).toInt()),
          //           Colors.black.withAlpha((.39 * 255).toInt()),
          //           Colors.black.withAlpha((.70 * 255).toInt()),
          //           Colors.black.withAlpha((.0 * 255).toInt()),
          //         ],
          //         begin: Alignment.topCenter,
          //         end: Alignment.bottomCenter,
          //       ),
          //       boxShadow: [
          //         BoxShadow(
          //           color: Colors.black,
          //           spreadRadius: 5,
          //           blurRadius: 10,
          //           offset: Offset(0, 4), // تغير حسب الاتجاه اللي انت عايزه
          //         ),
          //       ],
          //     ),
          //     child: Image.asset(
          //       backgroundImage,
          //       fit: BoxFit.fill,
          //       width:
          //           double
          //               .infinity, // These might be redundant with Positioned.fill and BoxFit.fill
          //       height:
          //           double
          //               .infinity, // but good to keep if you have other layout needs
          //     ),
          //   ),
          // ),
          Stack(
            children: [
              // Background Image
              Image.asset(
                backgroundImage,
                fit: BoxFit.cover,
                // width: double.infinity,
                // height: double.infinity,
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
                            title,
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
                            serviceTitle,
                            style: TextStyles.styleMedium(
                              context,
                              fontSize: 16.sp,
                              color: const Color(0xFF1C4857),
                            ),
                          ),
                        ),
                        SizedBox(height: 5.h),
                        //! evaluted rating
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children:
                              workers.map((worker) {
                                return Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 23.w,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        ...List.generate(5, (index) {
                                          return Icon(
                                            index < worker.rating
                                                ? Icons.star
                                                : Icons.star_border,
                                            color: const Color(0xFFDDA853),
                                            size: 20.h,
                                          );
                                        }),
                                        SizedBox(width: 4.w),
                                        Text(
                                          "(${worker.reviewCount})",
                                          style: TextStyles.styleRegular(
                                            context,
                                            fontSize: 14.sp,
                                            color: Color(
                                              0XFF16404D,
                                            ).withAlpha((.5 * 255).toInt()),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }).toList(),
                        ),
                        SizedBox(height: 28.h),
                        // Filters
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 26.w),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children:
                                  filters.map((filter) {
                                    return Padding(
                                      padding: EdgeInsets.only(right: 17.w),
                                      child: _buildServiceFilter(
                                        context,
                                        filter['icon'],
                                        filter['label'],
                                        isLast: filter == filters.last,
                                      ),
                                    );
                                  }).toList(),
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
                                  text: serviceDetails,
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
                                        text: price,
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
                                              .withAlpha((.53 * 255).toInt()),
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
                                  onPressed: onBookNow,
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
                                // child: Container(
                                //   height: 50.h,
                                //   width: 145.w,
                                //   child: ElevatedButton(
                                //     onPressed: onBookNow,
                                //     style: ElevatedButton.styleFrom(
                                //       backgroundColor: const Color(0xFF1C4857),
                                //       padding: EdgeInsets.symmetric(
                                //         vertical: 12.h,
                                //       ),
                                //       shape: RoundedRectangleBorder(
                                //         borderRadius: BorderRadius.circular(
                                //           25.r,
                                //         ),
                                //       ),
                                //     ),
                                //     child: Text(
                                //       'Book Now',
                                //       style: TextStyle(
                                //         color: Colors.white,
                                //         fontSize: 16.sp,
                                //         fontWeight: FontWeight.w600,
                                //       ),
                                //     ),
                                //   ),
                                // ),
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
        SizedBox(width: 6.w),
        Text(
          label,
          style: TextStyles.styleRegular(
            context,
            fontSize: 14.sp,
            color: ColorsManager.primaryColor,
          ),
        ),
        if (!isLast) ...[
          SizedBox(width: 8.w),
          Container(
            width: 1.w,
            height: 12.h,
            decoration: BoxDecoration(color: Colors.amber),
          ),
        ],
      ],
    );
  }
}

class WorkerInfo {
  // final String name;
  // final String imagePath;
  final int rating;
  final int reviewCount;

  WorkerInfo({
    // required this.name,
    // required this.imagePath,
    required this.rating,
    required this.reviewCount,
  });
}
