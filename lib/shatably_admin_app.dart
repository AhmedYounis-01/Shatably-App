import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shatably_app/core/injection/injection_container.dart';
import 'package:shatably_app/core/routes/app_routes.dart';
import 'package:shatably_app/core/routes/navigatoin_service.dart';
import 'package:shatably_app/core/routes/routes.dart';
import 'package:shatably_app/core/themes/colors_manager.dart';
import 'package:shatably_app/feature/maintenance%20work/logic/cubit/maintenance_work_cubit.dart';
import 'core/localization/app_localization.dart';
import 'core/localization/localization_cubit.dart';

// final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class ShatablyAdminApp extends StatelessWidget {
  const ShatablyAdminApp({super.key});

  static final LocalizationCubit localizationCubit = LocalizationCubit();
  static AppRoutes appRoutes = AppRoutes();
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => localizationCubit..loadLanguage()),
        BlocProvider(create: (context) => sl<MaintenanceWorkCubit>()),
        // BlocProvider(create: (context) => sl<OrderCubit>()),
        // BlocProvider(create: (context) => sl<PendingCubit>()),
        // BlocProvider(create: (context) => sl<ProcessingCubit>()),
        // BlocProvider(create: (context) => sl<ShippingCubit>()),
        // BlocProvider(create: (context) => sl<DeliveredCubit>()),
      ],
      child: BlocBuilder<LocalizationCubit, Locale>(
        builder: (context, locale) {
          return ScreenUtilInit(
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
              locale: locale,
              supportedLocales: const [Locale('en'), Locale('ar')],
              localizationsDelegates: const [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              // initialRoute: Routes.splashScreen,
              initialRoute: Routes.browseProjectsScreen,
              onGenerateRoute: appRoutes.onGenerateRoute,
              navigatorKey: NavigationService.instance.rootNavKey,
            ),
          );
        },
      ),
    );
  }
}
