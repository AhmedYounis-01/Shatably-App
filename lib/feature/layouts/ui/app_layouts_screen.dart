import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shatably_app/core/helpers/extensions.dart';
import 'package:shatably_app/core/routes/routes.dart';
import '../../../core/themes/colors_manager.dart';
import '../../../core/utils/app_icons.dart';
import '../logic/cubit/applayout_cubit.dart';
import '../logic/cubit/applayout_state.dart';

class AppLayoutsScreen extends StatelessWidget {
  const AppLayoutsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ApplayoutCubit(),
      child: Scaffold(
        backgroundColor: const Color(0xFFFBF5DD),
        body: BlocBuilder<ApplayoutCubit, ApplayoutState>(
          builder: (context, state) {
            final cubit = context.read<ApplayoutCubit>();
            // Wrap each page with a Navigator to maintain separate navigation stacks
            return Navigator(
              // Key is important for maintaining state when switching tabs
              key: ValueKey<int>(cubit.currentIndex),
              // Don't observe parent navigator
              onGenerateRoute:
                  (settings) => MaterialPageRoute(
                    builder: (context) => cubit.pages[cubit.currentIndex],
                    settings: settings,
                  ),
            );
          },
        ),
        extendBody: true,
        bottomNavigationBar: BlocBuilder<ApplayoutCubit, ApplayoutState>(
          builder: (context, state) {
            final cubit = context.read<ApplayoutCubit>();
            return _CustomBottomNavBar(
              currentIndex: cubit.currentIndex,
              onTabTapped: (index) {
                cubit.changePage(index);
              },
              onAITapped: () {
                showDialog(
                  context: context,
                  builder:
                      (context) => AlertDialog(
                        title: const Text('AI Assistant'),
                        content: const Text(
                          'AI assistant functionality goes here.',
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text('Close'),
                          ),
                        ],
                      ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}

class _CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTabTapped;
  final VoidCallback onAITapped;

  const _CustomBottomNavBar({
    required this.currentIndex,
    required this.onTabTapped,
    required this.onAITapped,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // height: 90.h,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.bottomCenter,
        children: [
          // Main bar
          Container(
            height: 75.h,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25.r),
                topRight: Radius.circular(25.r),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildNavItem(0, AppIcons.homeIcon, 'Home'),
                _buildNavItem(1, AppIcons.calendarIcons, 'Calendar'),
                const SizedBox(width: 60), // space for AI button
                _buildNavItem(2, AppIcons.cartIcon, 'Cart'),
                _buildNavItem(3, AppIcons.userIcon, 'User'),
              ],
            ),
          ),

          // Positioned(
          //   top: -35,
          //   child: SizedBox(
          //     width: 70,
          //     height: 70,
          //     child: Stack(
          //       alignment: Alignment.center,
          //       children: [
          //         // White outer semicircle (top part only)
          //         Positioned(
          //           top: 0,
          //           left: 0,
          //           right: 0,
          //           child: Container(
          //             height: 30, // Half the height to show only top part
          //             decoration: BoxDecoration(
          //               color: Colors.redAccent,
          //               borderRadius: BorderRadius.vertical(
          //                 top: Radius.circular(
          //                   35,
          //                 ), // Half of the width to create the top curve
          //               ),
          //               boxShadow: [
          //                 BoxShadow(
          //                   color: Colors.black.withOpacity(0.1),
          //                   blurRadius: 4,
          //                   spreadRadius: 0,
          //                 ),
          //               ],
          //             ),
          //           ),
          //         ),
          //         // Teal circle
          //         Container(
          //           width: 55,
          //           height: 55,
          //           decoration: BoxDecoration(
          //             shape: BoxShape.circle,
          //             color: Color(0xFF0E3B43), // Dark teal color
          //           ),
          //           child: Center(
          //             child: Text(
          //               'AI',
          //               style: TextStyle(
          //                 color: Color(0xFFA6CDC6), // Light teal text color
          //                 fontSize: 24,
          //                 fontWeight: FontWeight.w500,
          //               ),
          //             ),
          //           ),
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
          Positioned(
            top: -25,
            child: GestureDetector(
              onTap: () {},
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Outer white ring/glow effect
                  Container(
                    width: 65,
                    height: 65,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      // color: Colors.redAccent,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withAlpha((0.1 * 255).toInt()),
                          blurRadius: 5,
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                  ),

                  // Inner teal circle with AI text
                  Container(
                    width: 55,
                    height: 55,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFF0E3B43), // Dark teal color
                    ),
                    child: Center(
                      child: InkWell(
                        onTap: () {
                          context.pushNamed(Routes.aiScreen);
                        },
                        child: Text(
                          'AI',
                          style: TextStyle(
                            color: Color(
                              0xFFA6CDC6,
                            ), // Light teal color for text
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(int index, String iconPath, String label) {
    bool isActive = index == currentIndex;

    return GestureDetector(
      onTap: () => onTabTapped(index),
      behavior: HitTestBehavior.opaque,
      child: Container(
        width: 60,
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              iconPath,
              height: 24.h,
              width: 24.w,
              colorFilter: ColorFilter.mode(
                isActive ? ColorsManager.primaryColor : const Color(0xFFA5B4CB),
                BlendMode.srcIn,
              ),
            ),
            const SizedBox(height: 2),
            if (isActive)
              Text(
                label,
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.bold,
                  color: ColorsManager.primaryColor,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
