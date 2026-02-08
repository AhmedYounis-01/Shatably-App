import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shatably_app/core/helpers/cache/storage_manager.dart';
import 'package:shatably_app/core/helpers/constant/constant.dart';
import 'package:shatably_app/core/helpers/extensions.dart';
import 'package:shatably_app/core/routes/routes.dart';
import 'package:shatably_app/core/utils/app_images.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    await Future.delayed(const Duration(seconds: 2));

    final bool hasSeenOnboarding = StorageManager.instance.hasSeenOnboarding();

    final String accessToken = await StorageManager.instance.getSecuredString(
      key: Constants.kAccessToken,
    );

    if (!hasSeenOnboarding) {
      context.pushNamedAndRemoveUntil(
        Routes.onboardingScreen,
        predicate: (_) => false,
      );
      return;
    }

    if (accessToken.isNullOrEmpty()) {
      context.pushNamedAndRemoveUntil(
        Routes.loginScreen,
        predicate: (_) => false,
      );
      return;
    }

    context.pushNamedAndRemoveUntil(
      Routes.appLayoutsScreen,
      predicate: (_) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(AppImages.splashIcon, width: 280.w, height: 100.h),
      ),
    );
  }
}
