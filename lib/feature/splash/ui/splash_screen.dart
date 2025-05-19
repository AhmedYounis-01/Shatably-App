import 'package:flutter/material.dart';
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
    // final String? accessToken = await TokenManager.getAccessToken();
    // final String? refreshToken = await TokenManager.getRefreshToken();
    // if (!mounted) return;
    // if (accessToken == null ||
    //     accessToken.isEmpty ||
    //     refreshToken == null ||
    //     refreshToken.isEmpty) {
    //   Navigator.pushReplacementNamed(
    //     context,
    //     Routes.loginScreen,
    //   );
    // } else {
    //   Navigator.pushReplacementNamed(
    //     context,
    //     Routes.appLayoutScreen,
    //   );
    // }

    // await checkIfLoggedInUser();
    // if (!mounted) return;
    // if (isLoggedInUser) {
    //   context.pushReplacementNamed(Routes.onboardingScreen);
    // } else {
    //   context.pushReplacementNamed(Routes.onboardingScreen);
    // }
    context.pushReplacementNamed(Routes.onboardingScreen);
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
