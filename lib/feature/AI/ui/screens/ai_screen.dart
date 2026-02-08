import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shatably_app/feature/AI/ui/widgets/ai%20widgets/ai_card.dart';
import 'package:shatably_app/feature/AI/ui/widgets/ai%20widgets/app_bar.dart';
import 'package:shatably_app/feature/AI/ui/widgets/ai%20widgets/home_vision_card.dart';
import 'package:shatably_app/feature/AI/ui/widgets/ai%20widgets/simple_discription.dart';

class AiScreen extends StatelessWidget {
  const AiScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0XFFEFEFEF),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(30.w),
          child: SingleChildScrollView(
            child: Column(
              children: [
                AiAppBar(),
                SizedBox(height: 12.h),
                SimpleDiscription(),
                SizedBox(height: 55.h),
                // AI Bot Section
                AiCard(),
                SizedBox(height: 24.h),
                // Home Vision Section
                HomeVisionCard(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
