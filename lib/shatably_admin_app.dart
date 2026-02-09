import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shatably_app/core/injection/injection_container.dart';
import 'package:shatably_app/core/routes/app_routes.dart';
import 'package:shatably_app/core/routes/routes.dart';
import 'package:shatably_app/core/themes/colors_manager.dart';
import 'package:shatably_app/feature/booking%20process/logic/booking%20cubit/booking_cubit.dart';
import 'package:shatably_app/feature/booking%20process/logic/hire%20details/hire_details_cubit.dart';
import 'package:shatably_app/feature/maintenance%20work/logic/cubit/maintenance_work_cubit.dart';
import 'package:shatably_app/feature/projects/data/repository/projects_repository.dart';
import 'package:shatably_app/feature/projects/logic/cubit/projects_cubit.dart';
import 'package:shatably_app/feature/shop/logic/cubit/products_cubit.dart';
// import 'core/localization/app_localization.dart'; // Removed
// import 'core/localization/localization_cubit.dart'; // Removed

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class ShatablyAdminApp extends StatelessWidget {
  const ShatablyAdminApp({super.key});

  static AppRoutes appRoutes = AppRoutes();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
    );
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => sl<MaintenanceWorkCubit>()),
        BlocProvider(
          create:
              (context) =>
                  ProjectsCubit(sl<ProjectsRepository>())..getProjects(),
        ),
        // BlocProvider(create: (context) => sl<ProjectsCubit>()),
        BlocProvider(create: (context) => sl<BookingCubit>()),
        BlocProvider(create: (context) => sl<HireDetailsCubit>()),
        BlocProvider(create: (context) => sl<ProductsCubit>()),
      ],
      child: ScreenUtilInit(
        designSize: const Size(390, 844),
        child: MaterialApp(
          builder: DevicePreview.appBuilder,
          title: 'Shatably',
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
