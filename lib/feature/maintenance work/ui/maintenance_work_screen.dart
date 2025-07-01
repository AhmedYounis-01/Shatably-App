// import 'package:flutter/gestures.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:shatably_app/core/injection/injection_container.dart';
// import 'package:shatably_app/core/themes/colors_manager.dart';
// import 'package:shatably_app/core/themes/text_styles.dart';
// import 'package:shatably_app/core/utils/app_icons.dart';
// import 'package:shatably_app/core/widgets/custom_app_button1.dart';
// import 'package:shatably_app/feature/booking%20process/ui/screens/book_screen.dart';
// import 'package:shatably_app/feature/maintenance%20work/data/repository/maintenance_work_repository.dart';
// import 'package:shatably_app/feature/maintenance%20work/logic/cubit/maintenance_work_cubit.dart';
// import 'package:shatably_app/feature/maintenance%20work/logic/cubit/maintenance_work_state.dart';

// class MaintenanceWorkScreen extends StatelessWidget {
//   final String serviceId;
//   const MaintenanceWorkScreen({super.key, required this.serviceId});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       extendBodyBehindAppBar: true,
//       appBar: PreferredSize(
//         preferredSize: const Size.fromHeight(0),
//         child: AppBar(
//           backgroundColor: Colors.transparent,
//           elevation: 0,
//           systemOverlayStyle: const SystemUiOverlayStyle(
//             statusBarColor: Colors.transparent,
//             statusBarIconBrightness: Brightness.light,
//           ),
//         ),
//       ),
//       body: BlocProvider(
//         create:
//             (context) =>
//                 MaintenanceWorkCubit(sl<MaintenanceWorkRepository>())
//                   ..getMaintenanceWork(id: serviceId),
//         child: BlocBuilder<MaintenanceWorkCubit, MaintenanceWorkState>(
//           builder: (context, state) {
//             if (state.status == ServicesStatus.loading) {
//               return const Center(child: CircularProgressIndicator());
//             }
//             if (state.status == ServicesStatus.error) {
//               return Center(child: Text(state.errorMessage ?? ''));
//             }
//             return SingleChildScrollView(
//               // Changed to SingleChildScrollView to make the entire screen scrollable
//               child: Column(
//                 // Retained as Column as requested
//                 children: [
//                   // Section 1: Image, Gradient, Back Button, and Title (using a Stack)
//                   Stack(
//                     children: [
//                       SizedBox(
//                         width: double.infinity,
//                         height: 400.h, // Maintain original image height
//                         child: Image.network(
//                           state.maintenanceServiceModel?.imageUrl ?? '',
//                           fit: BoxFit.cover,
//                         ),
//                       ),
//                       // Gradient overlay on the image
//                       Container(
//                         width: double.infinity,
//                         height: 400.h, // Match image height for gradient
//                         decoration: BoxDecoration(
//                           gradient: LinearGradient(
//                             begin: Alignment.topCenter,
//                             end: Alignment.bottomCenter,
//                             colors: [
//                               Colors.black.withAlpha((.10 * 255).toInt()),
//                               Colors.black.withAlpha((.30 * 255).toInt()),
//                               Colors.black.withAlpha((.30 * 255).toInt()),
//                               Colors.black.withAlpha((.60 * 255).toInt()),
//                               Colors.black.withAlpha((.10 * 255).toInt()),
//                             ],
//                           ),
//                         ),
//                       ),
//                       // Back Button and Title positioned over the image
//                       Positioned(
//                         top: 30.h, // Adjust top padding for SafeArea
//                         left: 0,
//                         right: 0,
//                         child: SafeArea(
//                           child: Padding(
//                             padding: EdgeInsets.symmetric(horizontal: 16.w),
//                             child: Row(
//                               children: [
//                                 GestureDetector(
//                                   onTap: () {
//                                     Navigator.of(context).pop();
//                                   },
//                                   child: Container(
//                                     width: 30.w,
//                                     height: 30.h,
//                                     decoration: const BoxDecoration(
//                                       shape: BoxShape.circle,
//                                       color: Color(0xFFA6CDC6),
//                                     ),
//                                     child: Center(
//                                       child: SvgPicture.asset(
//                                         "assets/icons/arrow_ios.svg",
//                                         width: 15.w,
//                                         height: 15.h,
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                                 Expanded(
//                                   child: Center(
//                                     child: Text(
//                                       state.maintenanceServiceModel?.name ?? '',
//                                       style: TextStyle(
//                                         fontSize: 18.sp,
//                                         fontWeight: FontWeight.w500,
//                                         color: Colors.white,
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                                 SizedBox(width: 30.w), // Balance the spacing
//                               ],
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                   // Section 2: Service Details Container (now overlapping)
//                   Transform.translate(
//                     // Used Transform.translate to move the container up for overlap
//                     offset: Offset(
//                       0,
//                       -30.h,
//                     ), // Adjust this value for more or less overlap
//                     child: Container(
//                       padding: EdgeInsets.only(top: 12.h),
//                       decoration: BoxDecoration(
//                         color: const Color(0XFFE5F1EF),
//                         borderRadius: BorderRadius.only(
//                           topLeft: Radius.circular(30.r),
//                           topRight: Radius.circular(30.r),
//                         ),
//                       ),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           // Drag indicator
//                           Center(
//                             child: Container(
//                               width: 25.w,
//                               height: 2.h,
//                               decoration: BoxDecoration(
//                                 color: ColorsManager.primaryColor,
//                                 borderRadius: BorderRadius.circular(10.r),
//                               ),
//                             ),
//                           ),
//                           SizedBox(height: 14.5.h),
//                           // Service title
//                           Padding(
//                             padding: EdgeInsets.symmetric(horizontal: 26.w),
//                             child: Text(
//                               state.maintenanceServiceModel?.description ?? '',
//                               style: TextStyles.styleMedium(
//                                 context,
//                                 fontSize: 16.sp,
//                                 color: const Color(0xFF1C4857),
//                               ),
//                             ),
//                           ),
//                           SizedBox(height: 5.h),
//                           //! evaluted rating
//                           // ! التقييم (Evaluated Rating) - تم التعديل هنا
//                           // نفترض أن serviceModel يحتوي الآن على قائمة من العمال
//                           // التحقق مما إذا كانت هناك تقييمات متاحة بناءً على عدد المراجعات
//                           // التحقق مما إذا كانت هناك تقييمات متاحة بناءً على عدد المراجعات
//                           if (state.maintenanceServiceModel?.reviewCount !=
//                                   null &&
//                               state.maintenanceServiceModel!.reviewCount > 0)
//                             Padding(
//                               padding: EdgeInsets.symmetric(horizontal: 23.w),
//                               child: Row(
//                                 mainAxisAlignment: MainAxisAlignment.start,
//                                 children: [
//                                   // عرض النجوم بناءً على متوسط تقييم الخدمة
//                                   ...List.generate(5, (index) {
//                                     return Icon(
//                                       index <
//                                               (state
//                                                       .maintenanceServiceModel
//                                                       ?.averageRating ??
//                                                   0)
//                                           ? Icons
//                                               .star // نجمة ممتلئة إذا كان الفهرس أقل من متوسط التقييم
//                                           : Icons
//                                               .star_border, // نجمة فارغة بخلاف ذلك
//                                       color: const Color(
//                                         0xFFDDA853, // لون ذهبي للنجوم
//                                       ),
//                                       size: 20.h, // حجم النجمة
//                                     );
//                                   }),
//                                   SizedBox(
//                                     width: 4.w,
//                                   ), // مسافة بين النجوم وعدد المراجعات
//                                   // عرض عدد المراجعات للخدمة
//                                   Text(
//                                     "(${(state.maintenanceServiceModel?.reviewCount ?? 0)})", // عرض عدد المراجعات بين قوسين
//                                     style: TextStyles.styleRegular(
//                                       context,
//                                       fontSize: 14.sp,
//                                       color: const Color(
//                                         0XFF16404D, // لون النص
//                                       ).withAlpha(
//                                         (.5 * 255)
//                                             .toInt(), // شفافية 50% للون النص
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             )
//                           else
//                             // رسالة بديلة إذا لم تكن هناك بيانات تقييم للخدمة (عدد المراجعات 0)
//                             Padding(
//                               padding: EdgeInsets.symmetric(horizontal: 23.w),
//                               child: Text(
//                                 'No rating available', // نص يشير إلى عدم توفر تقييمات
//                                 style: TextStyles.styleRegular(
//                                   context,
//                                   fontSize: 14.sp,
//                                   color: const Color(
//                                     0XFF16404D,
//                                   ).withAlpha((.5 * 255).toInt()),
//                                 ),
//                               ),
//                             ),
//                           SizedBox(height: 28.h),
//                           Padding(
//                             padding: EdgeInsets.symmetric(horizontal: 0.w),
//                             child: Center(
//                               child: Row(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: [
//                                   _buildServiceFilter(
//                                     context,
//                                     AppIcons.takyeefIcon,
//                                     "Install",
//                                     isLast: false,
//                                   ),
//                                   _buildServiceFilter(
//                                     context,
//                                     AppIcons.wrenchIcon,
//                                     "Repair",
//                                     isLast: false,
//                                   ),
//                                   _buildServiceFilter(
//                                     context,
//                                     AppIcons.renewIcon,
//                                     "Renew",
//                                     isLast: true,
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),

//                           SizedBox(height: 20.h),
//                           // Service details
//                           Padding(
//                             padding: EdgeInsets.symmetric(horizontal: 26.w),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   'Details',
//                                   style: TextStyles.styleMedium(
//                                     context,
//                                     fontSize: 16.sp,
//                                     color: ColorsManager.primaryColor,
//                                   ),
//                                 ),
//                                 SizedBox(height: 8.h),
//                                 RichText(
//                                   text: TextSpan(
//                                     text:
//                                         state
//                                             .maintenanceServiceModel
//                                             ?.details ??
//                                         '',
//                                     style: TextStyles.styleRegular(
//                                       context,
//                                       fontSize: 14.sp,
//                                       color: const Color(
//                                         0XFF16404D,
//                                       ).withAlpha((.8 * 255).toInt()),
//                                     ),
//                                     children: [
//                                       TextSpan(
//                                         text: 'Read more',
//                                         style: TextStyles.styleBold(
//                                           context,
//                                           fontSize: 14.sp,
//                                           color: Color(0XFF003076),
//                                         ),
//                                         recognizer:
//                                             TapGestureRecognizer()
//                                               ..onTap = () {
//                                                 // Read more action
//                                               },
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                           SizedBox(height: 40.h),
//                           // Price and Book Now
//                           Container(
//                             width: double.infinity,
//                             padding: EdgeInsets.symmetric(vertical: 10.h),
//                             decoration: BoxDecoration(
//                               color: const Color(0xFFE4EFED),
//                               borderRadius: BorderRadius.only(
//                                 topLeft: Radius.circular(25.r),
//                                 topRight: Radius.circular(25.r),
//                               ),
//                               boxShadow: [
//                                 BoxShadow(
//                                   color: Colors.black.withAlpha(
//                                     (.25 * 255).toInt(),
//                                   ),
//                                   offset: const Offset(0, -4),
//                                   spreadRadius: -1,
//                                   blurRadius: 4.8,
//                                 ),
//                               ],
//                             ),
//                             child: Column(
//                               children: [
//                                 SizedBox(height: 20.h),
//                                 // Price
//                                 Center(
//                                   child: RichText(
//                                     text: TextSpan(
//                                       children: [
//                                         TextSpan(
//                                           text:
//                                               state
//                                                   .maintenanceServiceModel
//                                                   ?.price
//                                                   .toString() ??
//                                               "",
//                                           style: TextStyles.styleMedium(
//                                             context,
//                                             fontSize: 16.sp,
//                                             color: ColorsManager.primaryColor,
//                                           ),
//                                         ),
//                                         TextSpan(
//                                           text: ' Per Hour',
//                                           style: TextStyles.styleMedium(
//                                             context,
//                                             fontSize: 14.sp,
//                                             color: ColorsManager.primaryColor
//                                                 .withAlpha((.53 * 255).toInt()),
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                                 SizedBox(height: 12.h),
//                                 // Book Now button
//                                 Center(
//                                   child: CustomAppButton1(
//                                     width: 145.w,
//                                     height: 50.h,
//                                     onPressed: () {
//                                       Navigator.of(context).push(
//                                         MaterialPageRoute(
//                                           builder:
//                                               (context) => BookingScreen(
//                                                 id: serviceId,
//                                                 image:
//                                                     state
//                                                         .maintenanceServiceModel
//                                                         ?.imageUrl ??
//                                                     '',
//                                               ),
//                                         ),
//                                       );
//                                       // context.pushNamed(
//                                       //   Routes.bookingScreen,
//                                       //   arguments: serviceId,
//                                       // );
//                                     },
//                                     backgroundColor: const Color(0xFF1C4857),
//                                     borderRadius: 25.r,
//                                     hasShadow: true,
//                                     child: Text(
//                                       'Book Now',
//                                       style: TextStyles.styleMedium(
//                                         context,
//                                         fontSize: 16.sp,
//                                         color: Colors.white,
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                                 SizedBox(
//                                   height: 80.h,
//                                 ), // Add some bottom padding to the scrollable content
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }

//   Widget _buildServiceFilter(
//     BuildContext context,
//     String icon,
//     String label, {
//     bool isLast = false,
//   }) {
//     return Row(
//       children: [
//         SvgPicture.asset(icon, width: 20.w, height: 20.h),
//         SizedBox(width: 8.w),
//         Text(
//           label,
//           style: TextStyles.styleRegular(
//             context,
//             fontSize: 14.sp,
//             color: ColorsManager.primaryColor,
//           ),
//         ),
//         SizedBox(width: 17.w),
//         if (!isLast) ...[
//           SizedBox(width: 8.w),
//           Container(
//             width: 1.w,
//             height: 12.h,
//             decoration: BoxDecoration(color: Colors.amber),
//           ),
//           SizedBox(width: 16.w),
//         ],
//       ],
//     );
//   }
// }
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shatably_app/core/injection/injection_container.dart';
import 'package:shatably_app/core/themes/colors_manager.dart';
import 'package:shatably_app/core/themes/text_styles.dart';
import 'package:shatably_app/core/utils/app_icons.dart';
import 'package:shatably_app/core/widgets/custom_app_button1.dart';
import 'package:shatably_app/feature/booking%20process/ui/screens/book_screen.dart';
import 'package:shatably_app/feature/maintenance%20work/data/repository/maintenance_work_repository.dart';
import 'package:shatably_app/feature/maintenance%20work/logic/cubit/maintenance_work_cubit.dart';
import 'package:shatably_app/feature/maintenance%20work/logic/cubit/maintenance_work_state.dart';
import 'package:shimmer/shimmer.dart'; // Import the shimmer package

class MaintenanceWorkScreen extends StatelessWidget {
  final String serviceId;
  const MaintenanceWorkScreen({super.key, required this.serviceId});

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
      body: BlocProvider(
        create:
            (context) =>
                MaintenanceWorkCubit(sl<MaintenanceWorkRepository>())
                  ..getMaintenanceWork(id: serviceId),
        child: BlocBuilder<MaintenanceWorkCubit, MaintenanceWorkState>(
          builder: (context, state) {
            // Check if the status is loading and show shimmer effect
            if (state.status == ServicesStatus.loading) {
              return _buildShimmerLoading(); // Call the shimmer loading widget
            }
            if (state.status == ServicesStatus.error) {
              return Center(child: Text(state.errorMessage ?? ''));
            }
            return SingleChildScrollView(
              child: Column(
                children: [
                  // Section 1: Image, Gradient, Back Button, and Title (using a Stack)
                  Stack(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        height: 400.h,
                        child: CachedNetworkImage(
                          imageUrl:
                              state.maintenanceServiceModel?.imageUrl ?? '',
                          fit: BoxFit.cover,
                          placeholder:
                              (context, url) => Shimmer.fromColors(
                                baseColor: Colors.grey[300]!,
                                highlightColor: Colors.grey[100]!,
                                child: Container(
                                  width: double.infinity,
                                  height: double.infinity,
                                  color: Colors.white,
                                ),
                              ),
                          errorWidget:
                              (context, url, error) => Container(
                                color: Colors.grey[300],
                                child: Icon(
                                  Icons.broken_image,
                                  size: 50.h,
                                  color: Colors.grey[600],
                                ),
                              ),
                        ),
                      ),
                      // Gradient overlay on the image
                      Container(
                        width: double.infinity,
                        height: 400.h,
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
                      // Back Button and Title positioned over the image
                      Positioned(
                        top: 30.h,
                        left: 0,
                        right: 0,
                        child: SafeArea(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16.w),
                            child: Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).pop();
                                  },
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
                        ),
                      ),
                    ],
                  ),
                  // Section 2: Service Details Container (now overlapping)
                  Transform.translate(
                    offset: Offset(0, -30.h),
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
                              state.maintenanceServiceModel?.description ?? '',
                              style: TextStyles.styleMedium(
                                context,
                                fontSize: 16.sp,
                                color: const Color(0xFF1C4857),
                              ),
                            ),
                          ),
                          SizedBox(height: 5.h),
                          // Evaluated rating
                          if (state.maintenanceServiceModel?.reviewCount !=
                                  null &&
                              state.maintenanceServiceModel!.reviewCount > 0)
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 23.w),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  // Display stars based on service average rating
                                  ...List.generate(5, (index) {
                                    return Icon(
                                      index <
                                              (state
                                                      .maintenanceServiceModel
                                                      ?.averageRating ??
                                                  0)
                                          ? Icons
                                              .star // Filled star
                                          : Icons.star_border, // Empty star
                                      color: const Color(
                                        0xFFDDA853, // Gold color for stars
                                      ),
                                      size: 20.h, // Star size
                                    );
                                  }),
                                  SizedBox(
                                    width: 4.w,
                                  ), // Space between stars and review count
                                  // Display review count
                                  Text(
                                    "(${(state.maintenanceServiceModel?.reviewCount ?? 0)})", // Display review count in parentheses
                                    style: TextStyles.styleRegular(
                                      context,
                                      fontSize: 14.sp,
                                      color: const Color(
                                        0XFF16404D, // Text color
                                      ).withAlpha(
                                        (.5 * 255)
                                            .toInt(), // 50% opacity for text color
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          else
                            // Alternative message if no rating data is available (review count 0)
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 23.w),
                              child: Text(
                                'No rating available', // Text indicating no ratings
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
                                      color: const Color(
                                        0XFF16404D,
                                      ).withAlpha((.8 * 255).toInt()),
                                    ),
                                    children: [
                                      TextSpan(
                                        text: 'Read more',
                                        style: TextStyles.styleBold(
                                          context,
                                          fontSize: 14.sp,
                                          color: const Color(0XFF003076),
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
                                    onPressed: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder:
                                              (context) => BookingScreen(
                                                id: serviceId,
                                                image:
                                                    state
                                                        .maintenanceServiceModel
                                                        ?.imageUrl ??
                                                    '',
                                                    serviceType: "Maintenance",
                                              ),
                                        ),
                                      );
                                    },
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
                                SizedBox(height: 80.h),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
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
            decoration: const BoxDecoration(color: Colors.amber),
          ),
          SizedBox(width: 16.w),
        ],
      ],
    );
  }

  // Shimmer loading widget
  Widget _buildShimmerLoading() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: SingleChildScrollView(
        child: Column(
          children: [
            // Shimmer for the image section
            Container(
              width: double.infinity,
              height: 400.h,
              color: Colors.white, // Placeholder color for shimmer
            ),
            // Shimmer for the overlapping content container
            Transform.translate(
              offset: Offset(0, -30.h),
              child: Container(
                padding: EdgeInsets.only(top: 12.h),
                decoration: BoxDecoration(
                  color: Colors.white, // Placeholder color for shimmer
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.r),
                    topRight: Radius.circular(30.r),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Shimmer for drag indicator
                    Center(
                      child: Container(
                        width: 25.w,
                        height: 2.h,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                      ),
                    ),
                    SizedBox(height: 14.5.h),
                    // Shimmer for service title
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 26.w),
                      child: Container(
                        width: double.infinity,
                        height: 20.h,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 5.h),
                    // Shimmer for rating
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 23.w),
                      child: Row(
                        children: [
                          // Shimmer for stars
                          ...List.generate(
                            5,
                            (index) => Container(
                              width: 20.h,
                              height: 20.h,
                              color: Colors.white,
                              margin: EdgeInsets.only(right: 4.w),
                            ),
                          ),
                          // Shimmer for review count
                          Container(
                            width: 50.w,
                            height: 15.h,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 28.h),
                    // Shimmer for service filters
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 26.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          // Modified to use Expanded to prevent overflow
                          Expanded(child: _buildShimmerFilterItem()),
                          Expanded(child: _buildShimmerFilterItem()),
                          Expanded(child: _buildShimmerFilterItem()),
                        ],
                      ),
                    ),
                    SizedBox(height: 20.h),
                    // Shimmer for details title
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 26.w),
                      child: Container(
                        width: 80.w,
                        height: 20.h,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    // Shimmer for details text
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 26.w),
                      child: Column(
                        children: [
                          Container(
                            width: double.infinity,
                            height: 15.h,
                            color: Colors.white,
                            margin: EdgeInsets.only(bottom: 8.h),
                          ),
                          Container(
                            width: double.infinity,
                            height: 15.h,
                            color: Colors.white,
                            margin: EdgeInsets.only(bottom: 8.h),
                          ),
                          Container(
                            width: 150.w,
                            height: 15.h,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 40.h),
                    // Shimmer for price and button section
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(vertical: 10.h),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(25.r),
                          topRight: Radius.circular(25.r),
                        ),
                      ),
                      child: Column(
                        children: [
                          SizedBox(height: 20.h),
                          // Shimmer for price
                          Container(
                            width: 100.w,
                            height: 20.h,
                            color: Colors.white,
                          ),
                          SizedBox(height: 12.h),
                          // Shimmer for button
                          Center(
                            child: Container(
                              width: 145.w,
                              height: 50.h,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(25.r),
                              ),
                            ),
                          ),
                          SizedBox(height: 80.h),
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
    );
  }

  // Helper for shimmer filter items
  Widget _buildShimmerFilterItem() {
    return Row(
      // The Row here is implicitly constrained by the Expanded parent
      mainAxisSize:
          MainAxisSize
              .min, // Allow the row to take minimum space within Expanded
      children: [
        Container(width: 20.w, height: 20.h, color: Colors.white),
        SizedBox(width: 8.w),
        Container(width: 60.w, height: 15.h, color: Colors.white),
        // Removed the vertical divider and extra SizedBox, as Expanded will handle spacing
        // and a fixed divider might cause issues within the flexible layout.
      ],
    );
  }
}
