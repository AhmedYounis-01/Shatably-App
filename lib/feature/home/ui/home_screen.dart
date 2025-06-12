import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shatably_app/core/routes/routes.dart';
import 'package:shatably_app/core/themes/colors_manager.dart';
import 'package:shatably_app/core/utils/app_icons.dart';
import 'package:shatably_app/core/utils/app_images.dart';
import 'package:shatably_app/core/themes/text_styles.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Set system UI overlay style
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Color(0xFFFBF5DD),
        statusBarIconBrightness: Brightness.dark,
      ),
    );
    return Scaffold(
      backgroundColor: const Color(0xFFE5F1EF), // Light blue background
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // SizedBox(height: 30.h),
              // Profile section with cream background
              Container(
                color: const Color(0xFFFBF5DD),
                width: double.infinity,
                padding: const EdgeInsets.only(
                  // top: 20,
                  bottom: 0,
                  left: 23,
                  right: 23,
                  // horizontal: 23,
                  // vertical: 20,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16),
                    // Profile & notification row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 22,
                              backgroundImage: AssetImage(
                                AppImages.morganImage,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Hi Morgan',
                                  style: TextStyles.styleRegular(
                                    context,
                                    fontSize: 12.sp,
                                    color: Color.fromRGBO(22, 64, 77, 0.8),
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  children: [
                                    SvgPicture.asset(AppIcons.locationHomeIcon),
                                    const SizedBox(width: 4),
                                    Text(
                                      'Location name here',
                                      style: TextStyles.styleRegular(
                                        context,
                                        fontSize: 14.sp,
                                        color: ColorsManager.primaryColor,
                                      ),
                                    ),
                                    const SizedBox(width: 2),
                                    SvgPicture.asset(AppIcons.arrowHomeIcon),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                        Stack(
                          alignment: AlignmentDirectional.topEnd,
                          children: [
                            SvgPicture.asset(AppIcons.bellHomeIcon),
                            Container(
                              width: 6,
                              height: 6,
                              decoration: BoxDecoration(
                                color: ColorsManager.yellowTextColor,
                                borderRadius: BorderRadius.circular(25),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),

                    const SizedBox(height: 15),

                    // What service do you want section
                    Text(
                      'What service do you want',
                      style: TextStyles.styleRegular(
                        context,
                        fontSize: 14.sp,
                        color: ColorsManager.primaryColor,
                      ),
                    ),
                    SizedBox(height: 5.h),
                  ],
                ),
              ),

              // Search bar - positioned between the two colored sections
              Stack(
                children: [
                  // Background containers to create the two-color background
                  Column(
                    children: [
                      Container(
                        height: 25.h, // Half of search bar height
                        color: const Color(0xFFFAF6EC), // Top cream color
                      ),
                      Container(
                        height: 25.h, // Half of search bar height
                        color: const Color(
                          0xFFE6F4F1,
                        ), // Bottom light blue color
                      ),
                    ],
                  ),
                  // Search bar centered between the two colors
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 23),
                    child: Container(
                      // height: 54.h,
                      height: 50.h,
                      decoration: BoxDecoration(
                        color: Color(0xFFDADADA),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withAlpha((0.25 * 255).toInt()),
                            spreadRadius: 2,
                            blurRadius: 10.4,
                          ),
                        ],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextField(
                        // controller: _searchController,
                        textInputAction: TextInputAction.search,
                        // onSubmitted: _searchLocation,
                        decoration: InputDecoration(
                          hintText: 'Search for service',
                          hintStyle: TextStyles.styleRegular(
                            context,
                            fontSize: 14.sp,
                            color: ColorsManager.geryIconColor,
                          ),
                          // prefixIcon: Icon(
                          //   Icons.location_on_outlined,
                          //   color: ColorsManager.geryIconColor,
                          // ),
                          suffixIcon: InkWell(
                            onTap: () {},
                            // onTap:
                            // () => _searchLocation(_searchController.text),
                            child: Padding(
                              padding: EdgeInsets.all(15.h),

                              // child: SvgPicture.asset(
                              //   AppIcons.searchIcon1,

                              //   color: ColorsManager.geryIconColor,
                              // ),
                              child: Image.asset(
                                // width: 14,
                                // height: 14,
                                AppIcons.searchIcon1,
                                color: ColorsManager.geryIconColor,
                              ),
                            ),
                          ),
                          border: InputBorder.none,
                          // contentPadding: EdgeInsets.symmetric(vertical: 23.h),
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 18.h,
                            horizontal: 16.w,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              // Main content
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16),

                    // Timeless offer
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Timeless offer',
                          style: TextStyles.styleRegular(
                            context,
                            fontSize: 14.sp,
                            color: ColorsManager.primaryColor,
                          ),
                        ),
                        Text(
                          '18:32:14 h',
                          style: TextStyles.styleRegular(
                            context,
                            fontSize: 12.sp,
                            color: ColorsManager.yellowTextColor,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),

                    // Promotion card
                    Stack(
                      clipBehavior:
                          Clip.none, // هذا مهم لمنع قص الصورة خارج حدود الـ Stack
                      children: [
                        // البطاقة الأساسية
                        Container(
                          // height: 146.h,
                          // constraints: BoxConstraints(minHeight: 170.h),
                          decoration: BoxDecoration(
                            color: const Color(0xFF0B4A6F),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              // محتوى النص (الجزء الأيسر)
                              Expanded(
                                flex: 3,
                                child: Padding(
                                  padding: EdgeInsetsDirectional.only(
                                    top: 16.h,
                                    start: 13.w,
                                    // end: 10.w,
                                    bottom: 18.h,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            '25% ',
                                            style: TextStyles.styleMedium(
                                              context,
                                              fontSize: 20.sp,
                                              fontWeight: FontWeight.bold,
                                              color:
                                                  ColorsManager.yellowTextColor,
                                            ),
                                          ),
                                          Icon(
                                            Icons.local_fire_department,
                                            color:
                                                ColorsManager.yellowTextColor,
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 20.h),
                                      Text(
                                        'Today\'s special!',
                                        style: TextStyles.styleBold(
                                          context,
                                          fontSize: 20.sp,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                      SizedBox(height: 8.h),
                                      Text(
                                        'Get discount for every\nservice,only valid for today',
                                        style: TextStyles.styleRegular(
                                          context,
                                          fontSize: 13.sp,
                                          color: Colors.white.withAlpha(
                                            (0.25 * 255).toInt(),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),

                              // ترك مساحة للصورة
                              Expanded(flex: 2, child: Container()),
                            ],
                          ),
                        ),

                        // صورة الخلفية (الأمواج) - موضوعة في الزاوية اليمنى السفلية
                        Positioned(
                          right: 0,
                          bottom: 0,
                          child: ClipRRect(
                            borderRadius: const BorderRadius.only(
                              bottomRight: Radius.circular(16),
                            ),
                            child: Image.asset(
                              AppImages.homeBackgroundImage,
                              width:
                                  MediaQuery.of(context).size.width *
                                  0.4, // ريسبونسيف بنسبة من عرض الشاشة
                              height: 120.h, // ارتفاع متناسب مع الشاشة
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),

                        // صورة العامل - موضوعة فوق صورة الأمواج
                        Positioned(
                          right: 0,
                          bottom:
                              0, // بدون قيمة سالبة ليبقى داخل حدود البطاقة كما في الصورة المرجعية
                          child: Image.asset(
                            AppImages.plumberImage,
                            width:
                                MediaQuery.of(context).size.width *
                                0.4, // ريسبونسيف بنسبة من عرض الشاشة
                            height: 180.h, // ارتفاع متناسب مع الشاشة
                            fit: BoxFit.contain,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),

                    // Trending Services section
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Trending Services',
                          style: TextStyles.styleRegular(
                            context,
                            fontSize: 14.sp,
                            color: ColorsManager.primaryColor,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.of(
                              context,
                              rootNavigator: false,
                            ).pushNamed(Routes.servicesScreen);
                          },
                          child: Text(
                            'View all',
                            style: TextStyles.styleRegular(
                              context,
                              fontSize: 12.sp,
                              color: ColorsManager.yellowTextColor,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),

                    // Service categories
                    SizedBox(
                      height: 95,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          _buildServiceCategory(
                            'Electrician',
                            AppIcons.electricianIcon,
                            () => Navigator.of(
                              context,
                              rootNavigator: false,
                            ).pushNamed(Routes.electricianServiceScreen),
                          ),
                          const SizedBox(width: 12),
                          _buildServiceCategory(
                            'Carpenter',
                            AppIcons.carpenterIcon,
                            () => Navigator.of(
                              context,
                              rootNavigator: false,
                            ).pushNamed(Routes.carpentryServiceScreen),
                          ),
                          const SizedBox(width: 12),
                          _buildServiceCategory(
                            'Painter',
                            AppIcons.painterIcon,
                            () => Navigator.of(
                              context,
                              rootNavigator: false,
                            ).pushNamed(Routes.paintingServiceScreen),
                          ),
                          const SizedBox(width: 12),
                          _buildServiceCategory(
                            'Plumber',
                            AppIcons.plumberIcon,
                            () => Navigator.of(
                              context,
                              rootNavigator: false,
                            ).pushNamed(Routes.plumbingServiceScreen),
                          ),
                          const SizedBox(width: 12),
                          _buildServiceCategory(
                            'Cleaning',
                            AppIcons.housekeepingIcon,
                            () => Navigator.of(
                              context,
                              rootNavigator: false,
                            ).pushNamed(Routes.cleaningServiceScreen),
                          ),
                          const SizedBox(width: 12),
                        ],
                      ),
                    ),

                    SizedBox(height: 20.h),

                    // Explore Our Projects section
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Explore\nOur Projects',
                              style: TextStyles.styleRegular(
                                context,
                                fontSize: 16.sp,
                                color: ColorsManager.primaryColor,
                              ),
                            ),
                          ],
                        ),
                        InkWell(
                          onTap:
                              () => Navigator.of(
                                context,
                                rootNavigator: false,
                              ).pushNamed(Routes.browseProjectsScreen),
                          child: Text(
                            'View all',
                            style: TextStyles.styleRegular(
                              context,
                              fontSize: 12.sp,
                              color: ColorsManager.yellowTextColor,
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 12.h),

                    SizedBox(
                      height: 164.h,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          buildCardImage(
                            context,
                            'From 1500 EGP',
                            'Kitchen Finishing',
                            AppImages.browseBrojectImage,
                            () => Navigator.of(
                              context,
                              rootNavigator: false,
                            ).pushNamed(Routes.kitchenInstallation),
                          ),
                          SizedBox(width: 12.5.w),
                          buildCardImage(
                            context,
                            'From 3000 EGP',
                            'Handymen service',
                            AppImages.browseBrojectImag1,
                            () => Navigator.of(
                              context,
                              rootNavigator: false,
                            ).pushNamed(Routes.handymenServiceScreen),
                          ),
                          SizedBox(width: 12.5.w),
                          buildCardImage(
                            context,
                            'From 1000 EGP',
                            ' Elegant finishes',
                            AppImages.browseBrojectImag2,
                            () => Navigator.of(
                              context,
                              rootNavigator: false,
                            ).pushNamed(Routes.elegantFinishesScreen),
                          ),
                          SizedBox(width: 12.5.w),
                          buildCardImage(
                            context,
                            'From 4000 EGP',
                            'Bathroom installation',
                            AppImages.browseBrojectImag3,
                            () => Navigator.of(
                              context,
                              rootNavigator: false,
                            ).pushNamed(Routes.bathroomInstallationScreen),
                          ),
                          SizedBox(width: 12.5.w),
                          buildCardImage(
                            context,
                            'From 6520 EGP',
                            'Gas installation',
                            AppImages.browseBrojectImag4,
                            () => Navigator.of(
                              context,
                              rootNavigator: false,
                            ).pushNamed(Routes.gasInstallatioinScreen),
                          ),
                          SizedBox(width: 12.5.w),
                        ],
                      ),
                    ),

                    const SizedBox(
                      height: 50,
                    ), // Add space for bottom navigation
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildServiceCategory(
    String title,
    String imagePath,
    void Function()? onTap,
  ) {
    return Container(
      width: 95,
      height: 95,
      decoration: BoxDecoration(
        color: const Color(0XFFE5E3DB),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withAlpha((0.1 * 255).toInt()),
            spreadRadius: 1,
            blurRadius: 2,
          ),
        ],
      ),
      child: InkWell(
        onTap: onTap,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundColor: Colors.white,
                child: SvgPicture.asset(
                  imagePath,
                  width: 26.w,
                  height: 26.h,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 3),
              Text(title),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildCardImage(
    BuildContext context,
    String price,
    String title,
    String imageUrl,
    void Function()? onTap,
  ) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 210.w,
        height: 164.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          image: DecorationImage(
            image: AssetImage(imageUrl),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),

                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withAlpha((0.4 * 255).toInt()),
                  ],
                ),
              ),
            ),

            Positioned(
              bottom: 10,
              left: 5,
              right: 5,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 5),
                decoration: BoxDecoration(
                  color: Colors.grey.withAlpha((0.81 * 255).toInt()),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withAlpha((0.25 * 255).toInt()),
                      // spreadRadius: 2,
                      blurRadius: 4,
                    ),
                  ],
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            children: [
                              Image.asset(
                                AppImages.boltImage,
                                width: 12.w,
                                height: 12.h,
                              ),

                              SizedBox(width: 2),
                              Text(
                                "From $price",
                                style: TextStyles.styleRegular(
                                  context,
                                  fontSize: 10.sp,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 3),
                          Text(
                            title,
                            style: TextStyles.styleRegular(
                              context,
                              fontSize: 12.sp,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      width: 22.w,
                      height: 22.h,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: SvgPicture.asset(AppIcons.arrowRightIcon),
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
}
