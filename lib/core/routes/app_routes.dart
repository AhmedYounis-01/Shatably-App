// ignore_for_file: unreachable_switch_case

/* 
  This method is responsible for generating routes based on the given RouteSettings.
  The RouteSettings object contains information about the route, such as its name and any arguments passed to it.
 */
import 'package:flutter/material.dart';
import 'package:shatably_app/core/routes/routes.dart';
import 'package:shatably_app/feature/AI/ui/screens/ai_screen.dart';
import 'package:shatably_app/feature/AI/ui/screens/chat_bot_screen.dart';
import 'package:shatably_app/feature/Appointments/ui/screens/appointments_screen.dart';
import 'package:shatably_app/feature/Location/ui/confirm_location_screen.dart';
import 'package:shatably_app/feature/Location/ui/location_screen.dart';
import 'package:shatably_app/feature/auth/login/ui/login_screen.dart';
import 'package:shatably_app/feature/auth/login/ui/password_screen.dart';
import 'package:shatably_app/feature/auth/recover_password/ui/forgot_password_screen.dart';
import 'package:shatably_app/feature/auth/recover_password/ui/new_password_confirmation_screen.dart';
import 'package:shatably_app/feature/auth/recover_password/ui/password_reset_screen.dart';
import 'package:shatably_app/feature/auth/register/ui/register_screen.dart';
import 'package:shatably_app/feature/auth/type/ui/type_screen.dart';
import 'package:shatably_app/feature/booking%20process/ui/screens/hire_details_screen.dart';
import 'package:shatably_app/feature/booking%20process/ui/screens/payment_screen.dart';
import 'package:shatably_app/feature/booking%20process/ui/screens/book_screen.dart';
import 'package:shatably_app/feature/booking%20process/ui/screens/transaction_faield.dart';
import 'package:shatably_app/feature/booking%20process/ui/screens/transaction_sucess.dart';
import 'package:shatably_app/feature/home/ui/home_screen.dart';
import 'package:shatably_app/feature/home/ui/projects_screen.dart';
import 'package:shatably_app/feature/home/ui/service_screen.dart';
import 'package:shatably_app/feature/layouts/ui/app_layouts_screen.dart';
import 'package:shatably_app/feature/maintenance%20work/ui/screens/ac_setup_screen.dart';
import 'package:shatably_app/feature/maintenance%20work/ui/screens/surveillance_cameras.dart';
import 'package:shatably_app/feature/maintenance%20work/ui/screens/water_purifier.dart';
import 'package:shatably_app/feature/maintenance%20work/ui/screens/windows_screen.dart';
import 'package:shatably_app/feature/onboarding/ui/onboarding_screen.dart';
import 'package:shatably_app/feature/maintenance%20work/ui/screens/pest_control_screen.dart';
import 'package:shatably_app/feature/profile/ui/screens/profile_screen.dart';
import 'package:shatably_app/feature/projects/ui/screens/Handymen_screen.dart';
import 'package:shatably_app/feature/projects/ui/screens/bathroom_installation.dart';
import 'package:shatably_app/feature/projects/ui/screens/elegant_finishes_screen.dart';
import 'package:shatably_app/feature/projects/ui/screens/gas_installatioin.dart';
import 'package:shatably_app/feature/projects/ui/screens/kitchen_installation.dart';
import 'package:shatably_app/feature/services/ui/screens/carpentry_screen.dart';
import 'package:shatably_app/feature/services/ui/screens/cleaning_screen.dart';
import 'package:shatably_app/feature/services/ui/screens/electrician_screen.dart';
import 'package:shatably_app/feature/services/ui/screens/painting_screen.dart';
import 'package:shatably_app/feature/services/ui/screens/plumbing_screen.dart';
import 'package:shatably_app/feature/shop/ui/screens/cart_screen.dart';
import 'package:shatably_app/feature/shop/ui/screens/shop_screen.dart';
import 'package:shatably_app/feature/splash/ui/splash_screen.dart';
import 'package:shatably_app/test_file.dart';

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
        final email = settings.arguments as String;
        return MaterialPageRoute(builder: (_) => PasswordScreen(email: email));
      case Routes.forgotPasswordScreen:
        return MaterialPageRoute(builder: (_) => const ForgotPasswordScreen());
      // case Routes.otpScreen:
      //   return MaterialPageRoute(builder: (_) => const OtpScreen());
      // case Routes.passwordResetConfirmationScreen:
      //   return MaterialPageRoute(
      //     builder: (_) => const PasswordResetConfirmationScreen(),
      //   );
      case Routes.passwordResetScreen:
        final email = settings.arguments as String;
        return MaterialPageRoute(
          builder: (_) => PasswordResetScreen(email: email),
        );
      case Routes.browseProjectsScreen:
        return MaterialPageRoute(builder: (_) => const ProjectsScreen());
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
      //! Uncomment the following lines
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
      case Routes.pestControlScreen:
        return MaterialPageRoute(builder: (_) => const PestControlSCreen());
      case Routes.handymenServiceScreen:
        return MaterialPageRoute(
          builder: (_) => const HandymenServicePackageScreen(),
        );
      case Routes.bookingScreen:
        return MaterialPageRoute(builder: (_) => const BookingScreen());
      case Routes.testScreen:
        return MaterialPageRoute(builder: (_) => const TestScreen());
      case Routes.paymentScreen:
        return MaterialPageRoute(builder: (_) => const PaymentScreen());
      case Routes.transactionSucess:
        return MaterialPageRoute(builder: (_) => const TransactionSucess());
      case Routes.transactionFailed:
        return MaterialPageRoute(builder: (_) => const TransactionFaield());
      case Routes.customHireDetails:
        return MaterialPageRoute(builder: (_) => const BookingDetailScreen());
      // case Routes.workerScreen:
      //   return MaterialPageRoute(builder: (_) => const WorkerScreen());
      case Routes.acSetupScreen:
        return MaterialPageRoute(builder: (_) => const AcSetupScreen());
      case Routes.windowsScreen:
        return MaterialPageRoute(builder: (_) => const WindowsScreen());
      case Routes.waterPurifierScreen:
        return MaterialPageRoute(builder: (_) => const WaterPurifierScreen());
      case Routes.surveillanceCameras:
        return MaterialPageRoute(builder: (_) => const SurveillanceCameras());
      case Routes.kitchenInstallation:
        return MaterialPageRoute(builder: (_) => const KitchenInstallation());
      case Routes.elegantFinishesScreen:
        return MaterialPageRoute(builder: (_) => const ElegantFinishesScreen());
      case Routes.bathroomInstallationScreen:
        return MaterialPageRoute(
          builder: (_) => const BathroomInstallationScreen(),
        );
      case Routes.gasInstallatioinScreen:
        return MaterialPageRoute(
          builder: (_) => const GasInstallatioinScreen(),
        );
      case Routes.profileScreen:
        return MaterialPageRoute(builder: (_) => const ProfileScreen());
      case Routes.shopScreen:
        return MaterialPageRoute(builder: (_) => const ShopScreen());
      case Routes.cartScreen:
        return MaterialPageRoute(builder: (_) => const CartScreen());
      case Routes.appointmentsScreen:
        return MaterialPageRoute(builder: (_) => const AppointmentsScreen());
      case Routes.aiScreen:
        return MaterialPageRoute(builder: (_) => const AiScreen());
      case Routes.chatBotScreen:
        return MaterialPageRoute(builder: (_) => const ChatBotScreen());
    }
    return null;
  }
}
