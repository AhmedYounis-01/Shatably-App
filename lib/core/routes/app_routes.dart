// ignore_for_file: unreachable_switch_case

/* 
  This method is responsible for generating routes based on the given RouteSettings.
  The RouteSettings object contains information about the route, such as its name and any arguments passed to it.
 */
import 'package:flutter/material.dart';
import 'package:shatably_app/core/routes/routes.dart';
import 'package:shatably_app/feature/Location/ui/confirm_location_screen.dart';
import 'package:shatably_app/feature/Location/ui/location_screen.dart';
import 'package:shatably_app/feature/auth/login/ui/login_screen.dart';
import 'package:shatably_app/feature/auth/login/ui/password_screen.dart';
import 'package:shatably_app/feature/auth/recover_password/ui/forgot_password_screen.dart';
import 'package:shatably_app/feature/auth/recover_password/ui/new_password_confirmation_screen.dart';
import 'package:shatably_app/feature/auth/recover_password/ui/otp_screen.dart';
import 'package:shatably_app/feature/auth/recover_password/ui/password_reset_confirmation_screen.dart';
import 'package:shatably_app/feature/auth/recover_password/ui/password_reset_screen.dart';
import 'package:shatably_app/feature/auth/register/ui/register_screen.dart';
import 'package:shatably_app/feature/auth/type/ui/type_screen.dart';
import 'package:shatably_app/feature/home/ui/home_screen.dart';
import 'package:shatably_app/feature/home/ui/service_screen.dart';
import 'package:shatably_app/feature/layouts/ui/app_layouts_screen.dart';
import 'package:shatably_app/feature/onboarding/ui/onboarding_screen.dart';
import 'package:shatably_app/feature/maintenance%20work/ui/screens/service_catalog_screen.dart';
import 'package:shatably_app/feature/projects/ui/screens/Handymen_screen.dart';
import 'package:shatably_app/feature/services/ui/carpentry_screen.dart';
import 'package:shatably_app/feature/services/ui/cleaning_screen.dart';
import 'package:shatably_app/feature/services/ui/electrician_screen.dart';
import 'package:shatably_app/feature/services/ui/painting_screen.dart';
import 'package:shatably_app/feature/services/ui/plumbing_screen.dart';
import 'package:shatably_app/feature/splash/ui/splash_screen.dart';

class AppRoutes {
  Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splashScreen:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case Routes.onboardingScreen:
        return MaterialPageRoute(builder: (_) => const OnboardingScreen());
      case Routes.typeScreen:
        return MaterialPageRoute(builder: (_) => const TypeScreen());
      case Routes.loginScreen:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case Routes.passwordScreen:
        return MaterialPageRoute(builder: (_) => const PasswordScreen());
      case Routes.forgotPasswordScreen:
        return MaterialPageRoute(builder: (_) => const ForgotPasswordScreen());
      case Routes.otpScreen:
        return MaterialPageRoute(builder: (_) => const OtpScreen());
      case Routes.passwordResetConfirmationScreen:
        return MaterialPageRoute(
          builder: (_) => const PasswordResetConfirmationScreen(),
        );
      case Routes.passwordResetScreen:
        return MaterialPageRoute(builder: (_) => const PasswordResetScreen());
      case Routes.newPasswordConfirmationScreen:
        return MaterialPageRoute(
          builder: (_) => const NewPasswordConfirmationScreen(),
        );
      case Routes.registerScreen:
        return MaterialPageRoute(builder: (_) => const RegisterScreen());
      case Routes.locationDetectionScreen:
        return MaterialPageRoute(
          builder: (_) => const LocationDetectionScreen(),
        );
      case Routes.confirmLocationScreen:
        return MaterialPageRoute(builder: (_) => const ConfirmLocationScreen());
      case Routes.appLayoutsScreen:
        return MaterialPageRoute(builder: (_) => const AppLayoutsScreen());
      case Routes.homeScreen:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case Routes.servicesScreen:
        return MaterialPageRoute(builder: (_) => const ServicesScreen());
      case Routes.electricianServiceScreen:
        return MaterialPageRoute(
          builder: (_) => const ElectricianServiceScreen(),
        );
      case Routes.carpentryServiceScreen:
        return MaterialPageRoute(
          builder: (_) => const CarpentryServiceScreen(),
        );
      case Routes.paintingServiceScreen:
        return MaterialPageRoute(builder: (_) => const PaintingServiceScreen());
      case Routes.plumbingServiceScreen:
        return MaterialPageRoute(builder: (_) => const PlumbingServiceScreen());
      case Routes.cleaningServiceScreen:
        return MaterialPageRoute(builder: (_) => const CleaningServiceScreen());
      case Routes.serviceCatalogScreen:
        return MaterialPageRoute(builder: (_) => const PestControlPage());
      case Routes.handymenServicePackageScreen:
        return MaterialPageRoute(
          builder: (_) => const HandymenServicePackageScreen(),
        );
    }
    return null;
  }
}
