// import 'package:device_preview/device_preview.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_localizations/flutter_localizations.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:shatably_app/core/injection/injection_container.dart';
// import 'package:shatably_app/core/routes/app_routes.dart';
// import 'package:shatably_app/core/routes/routes.dart';
// import 'package:shatably_app/core/themes/colors_manager.dart';
// import 'package:shatably_app/feature/AI/logic/chat%20ai/chat_cubit.dart';
// import 'package:shatably_app/feature/AI/logic/image%20generator/image_generator_cubit.dart';
// import 'package:shatably_app/feature/booking%20process/logic/booking%20cubit/booking_cubit.dart';
// import 'package:shatably_app/feature/booking%20process/logic/hire%20details/hire_details_cubit.dart';
// import 'package:shatably_app/feature/maintenance%20work/logic/cubit/maintenance_work_cubit.dart';
// import 'package:shatably_app/feature/projects/logic/cubit/projects_cubit.dart';
// import 'core/localization/app_localization.dart';
// import 'core/localization/localization_cubit.dart';

// final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

// class ShatablyAdminApp extends StatelessWidget {
//   const ShatablyAdminApp({super.key});

//   // static final LocalizationCubit localizationCubit = LocalizationCubit();
//   static AppRoutes appRoutes = AppRoutes();
//   @override
//   Widget build(BuildContext context) {
//     return MultiBlocProvider(
//       providers: [
//         // BlocProvider(create: (_) => localizationCubit..loadLanguage()),
//         BlocProvider(create: (context) => sl<MaintenanceWorkCubit>()),
//         BlocProvider(create: (context) => sl<ProjectsCubit>()),
//         BlocProvider(create: (context) => sl<ImageGeneratorCubit>()),
//         BlocProvider(create: (context) => sl<ChatCubit>()),
//         BlocProvider(create: (context) => sl<BookingCubit>()),
//         BlocProvider(create: (context) => sl<HireDetailsCubit>()),
//         // BlocProvider(create: (context) => sl<DeliveredCubit>()),
//       ],
//       child: BlocBuilder<LocalizationCubit, Locale>(
//         builder: (context, locale) {
//           return ScreenUtilInit(
//             designSize: const Size(390, 844),
//             child: MaterialApp(
//               builder: DevicePreview.appBuilder,
//               title: 'Shatably Admin',
//               debugShowCheckedModeBanner: false,
//               theme: ThemeData(
//                 colorScheme: ColorScheme.fromSeed(
//                   seedColor: ColorsManager.primaryColor,
//                 ),

//                 scaffoldBackgroundColor: const Color(0xFFFBF5DD),
//                 primaryColor: ColorsManager.primaryColor,
//                 useMaterial3: true,
//               ),
//               locale: locale,
//               supportedLocales: const [Locale('en'), Locale('ar')],
//               localizationsDelegates: const [
//                 // AppLocalizations.delegate,
//                 GlobalMaterialLocalizations.delegate,
//                 GlobalWidgetsLocalizations.delegate,
//                 GlobalCupertinoLocalizations.delegate,
//               ],
//               initialRoute: Routes.splashScreen,
//               onGenerateRoute: appRoutes.onGenerateRoute,
//               navigatorKey: navigatorKey,
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shatably_app/core/injection/injection_container.dart';
import 'package:shatably_app/core/routes/app_routes.dart';
import 'package:shatably_app/core/routes/routes.dart';
import 'package:shatably_app/core/themes/colors_manager.dart';
import 'package:shatably_app/feature/AI/logic/chat%20ai/chat_cubit.dart';
import 'package:shatably_app/feature/AI/logic/image%20generator/image_generator_cubit.dart';
import 'package:shatably_app/feature/booking%20process/logic/booking%20cubit/booking_cubit.dart';
import 'package:shatably_app/feature/booking%20process/logic/hire%20details/hire_details_cubit.dart';
import 'package:shatably_app/feature/maintenance%20work/logic/cubit/maintenance_work_cubit.dart';
import 'package:shatably_app/feature/projects/logic/cubit/projects_cubit.dart';
// import 'core/localization/app_localization.dart'; // Removed
// import 'core/localization/localization_cubit.dart'; // Removed

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class ShatablyAdminApp extends StatelessWidget {
  const ShatablyAdminApp({super.key});

  static AppRoutes appRoutes = AppRoutes();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => sl<MaintenanceWorkCubit>()),
        BlocProvider(create: (context) => sl<ProjectsCubit>()),
        BlocProvider(create: (context) => sl<ImageGeneratorCubit>()),
        BlocProvider(create: (context) => sl<ChatCubit>()),
        BlocProvider(create: (context) => sl<BookingCubit>()),
        BlocProvider(create: (context) => sl<HireDetailsCubit>()),
        // BlocProvider(create: (context) => sl<DeliveredCubit>()),
      ],
      child: ScreenUtilInit(
        designSize: const Size(390, 844),
        child: MaterialApp(
          builder: DevicePreview.appBuilder,
          title: 'Shatably Admin',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
              seedColor: ColorsManager.primaryColor,
            ),
            scaffoldBackgroundColor: const Color(0xFFFBF5DD),
            primaryColor: ColorsManager.primaryColor,
            useMaterial3: true,
          ),
          // Set default locale to English
          locale: const Locale('en'),
          supportedLocales: const [Locale('en'), Locale('ar')],
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          initialRoute: Routes.splashScreen,
          onGenerateRoute: appRoutes.onGenerateRoute,
          navigatorKey: navigatorKey,
        ),
      ),
    );
  }
}
