import 'package:flutter/material.dart';
import 'package:shatably_app/core/helpers/cache/storage_manager.dart';
import 'package:shatably_app/core/helpers/constant/constant.dart';
import 'package:shatably_app/core/helpers/extensions.dart';
import 'package:shatably_app/core/routes/routes.dart';
import 'package:shatably_app/core/themes/text_styles.dart';
import 'dart:async';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _startSplashScreenTimer();
  }

  void _startSplashScreenTimer() {
    Future.delayed(const Duration(seconds: 2), _checkLoginStatus);
  }

  Future<void> _checkLoginStatus() async {
    final bool hasSeenOnboarding =
        await StorageManager.instance.hasSeenOnboarding();

    final String accessToken = await StorageManager.instance.getSecuredString(
      key: Constants.kAccessToken,
    );

    // PrintDebugConsole.s('accessToken : $accessToken');
    Future.delayed(const Duration(seconds: 3), () {
      // first launch app
      if (!hasSeenOnboarding) {
        context.pushNamedAndRemoveUntil(
          Routes.onboardingScreen,
          predicate: (route) => false,
        );
        // .pushAndRemoveUntil(path: RoutesPath.onboardingScreen);
      } else if (accessToken.isNullOrEmpty()) {
        context.pushNamedAndRemoveUntil(
          Routes.loginScreen,
          predicate: (route) => false,
        );
      } else {
        context.pushNamedAndRemoveUntil(
          Routes.appLayoutsScreen,
          predicate: (route) => false,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          "Shatably",
          style: TextStyles.styleBold(
            context,
            fontSize: 36,
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
    );
  }
}
