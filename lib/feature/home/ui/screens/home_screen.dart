import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shatably_app/feature/home/ui/widgets/home widgets/app_colors.dart';
import 'package:shatably_app/feature/home/ui/widgets/home widgets/profile_section_widgets.dart';
import 'package:shatably_app/feature/home/ui/widgets/home widgets/search_section_widgets.dart';
import 'package:shatably_app/feature/home/ui/widgets/home widgets/main_content_widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    setSystemUIOverlayStyle();

    return Scaffold(
      // backgroundColor: AppColors.lightBlue,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            decoration: const BoxDecoration(color: AppColors.lightGreen),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ProfileSection(),
                SearchBarSection(),
                MainContentSection(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void setSystemUIOverlayStyle() {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarIconBrightness: Brightness.dark),
    );
  }
}
