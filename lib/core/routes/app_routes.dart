// ignore_for_file: unreachable_switch_case

/* 
  This method is responsible for generating routes based on the given RouteSettings.
  The RouteSettings object contains information about the route, such as its name and any arguments passed to it.
 */
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shatably_app/core/injection/injection_container.dart';
import 'package:shatably_app/core/routes/routes.dart';
import 'package:shatably_app/feature/AI/data/repository/chat_repository.dart';
import 'package:shatably_app/feature/AI/data/repository/image_generator_repository.dart';
import 'package:shatably_app/feature/AI/logic/chat%20ai/chat_cubit.dart';
import 'package:shatably_app/feature/AI/logic/image%20generator/image_generator_cubit.dart';
import 'package:shatably_app/feature/AI/ui/screens/ai_screen.dart';
import 'package:shatably_app/feature/AI/ui/screens/chat_bot_screen.dart';
import 'package:shatably_app/feature/AI/ui/screens/home_vision.dart';
import 'package:shatably_app/feature/Appointments/ui/appointments_screen.dart';
import 'package:shatably_app/feature/Location/ui/screens/confirm_location_screen.dart';
import 'package:shatably_app/feature/Location/ui/screens/location_screen.dart';
import 'package:shatably_app/feature/auth/login/ui/login_screen.dart';
import 'package:shatably_app/feature/auth/login/ui/password_screen.dart';
import 'package:shatably_app/feature/auth/recover_password/ui/forgot_password_screen.dart';
import 'package:shatably_app/feature/auth/recover_password/ui/new_password_confirmation_screen.dart';
import 'package:shatably_app/feature/auth/recover_password/ui/password_reset_screen.dart';
import 'package:shatably_app/feature/auth/register/ui/register_screen.dart';
import 'package:shatably_app/feature/auth/type/ui/type_screen.dart';
import 'package:shatably_app/feature/booking%20process/ui/screens/booking_details_screen.dart';
import 'package:shatably_app/feature/booking%20process/ui/screens/payment_screen.dart';
import 'package:shatably_app/feature/booking%20process/ui/screens/transaction_faield.dart';
import 'package:shatably_app/feature/booking%20process/ui/screens/transaction_sucess.dart';
import 'package:shatably_app/feature/home/ui/screens/browse_services_screen.dart';
import 'package:shatably_app/feature/home/ui/screens/home_screen.dart';
import 'package:shatably_app/feature/home/ui/screens/browse_projects_screen.dart';
import 'package:shatably_app/feature/layouts/ui/app_layouts_screen.dart';
import 'package:shatably_app/feature/maintenance%20work/data/repository/maintenance_work_repository.dart';
import 'package:shatably_app/feature/maintenance%20work/logic/cubit/maintenance_work_cubit.dart';
import 'package:shatably_app/feature/maintenance%20work/ui/maintenance_work_screen.dart';
import 'package:shatably_app/feature/notification/ui/notification_screen.dart';
import 'package:shatably_app/feature/onboarding/ui/onboarding_screen.dart';
import 'package:shatably_app/feature/profile/ui/profile_screen.dart';
import 'package:shatably_app/feature/projects/ui/projects_screen.dart';
import 'package:shatably_app/feature/services/ui/screens/carpentry_screen.dart';
import 'package:shatably_app/feature/services/ui/screens/cleaning_screen.dart';
import 'package:shatably_app/feature/services/ui/screens/electrician_screen.dart';
import 'package:shatably_app/feature/services/ui/screens/painting_screen.dart';
import 'package:shatably_app/feature/services/ui/screens/plumbing_screen.dart';
import 'package:shatably_app/feature/shop/ui/screens/cart_screen.dart';
import 'package:shatably_app/feature/shop/ui/screens/shop_screen.dart';
import 'package:shatably_app/feature/splash/ui/splash_screen.dart';

class AppRoutes {
  Route? onGenerateRoute(RouteSettings settings) {
    var arguments = settings.arguments;

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
        final email = arguments as String;
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
        final email = arguments as String;
        return MaterialPageRoute(
          builder: (_) => PasswordResetScreen(email: email),
        );
      case Routes.browseProjectsScreen:
        return MaterialPageRoute(builder: (_) => const BrowseProjectsScreen());
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
        return MaterialPageRoute(builder: (_) => HomeScreen());
      case Routes.servicesScreen:
        return MaterialPageRoute(builder: (_) => const BrowseServicesScreen());
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
      // !!!!!!!!!! complete from here
      // case Routes.bookingScreen:
      //   return MaterialPageRoute(
      //     builder:
      //         (_) => BookingScreen(image: arguments as String, id: arguments),
      //   );
      // case Routes.bookingScreen:
      //   return MaterialPageRoute(builder: (_) => BookingScreen());
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
      case Routes.maintenanceWorkScreen:
        return MaterialPageRoute(
          builder:
              (_) => BlocProvider(
                create:
                    (context) =>
                        MaintenanceWorkCubit(sl<MaintenanceWorkRepository>())
                          ..getMaintenanceWork(id: arguments),
                child: MaintenanceWorkScreen(serviceId: arguments as String),
              ),
        );
      // case Routes.projectsScreen:
      //   return MaterialPageRoute(
      //     builder:
      //         (_) => BlocProvider(
      //           create:
      //               (context) =>
      //                   ProjectsCubit(sl<ProjectsRepository>())
      //                     ..getProjectDetails(arguments),
      //           child: ProjectsScreen(projectId: arguments as String),
      //         ),
      //   );
      case Routes.projectsScreen:
        return MaterialPageRoute(
          builder: (_) => ProjectsScreen(projectId: arguments as String),
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
        return MaterialPageRoute(
          builder:
              (_) => BlocProvider(
                create: (context) => ChatCubit(sl<ChatRepository>()),
                child: const ChatBotScreen(),
              ),
        );
      case Routes.homeVisionScreen:
        return MaterialPageRoute(
          builder:
              (_) => BlocProvider(
                create:
                    (context) =>
                        ImageGeneratorCubit(sl<ImageGeneratorRepository>()),
                child: const HomeVisionScreen(),
              ),
        );
      case Routes.notificationScreen:
        return MaterialPageRoute(builder: (_) => const NotificationScreen());
    }
    return null;
  }
}
