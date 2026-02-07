import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:shatably_app/bloc_observer.dart';
import 'package:shatably_app/core/helpers/cache/storage_manager.dart';
import 'package:shatably_app/core/helpers/constant/constant.dart';
import 'package:shatably_app/shatably_admin_app.dart';
import 'core/injection/injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();

  // Initialize StorageManager first before using it
  await StorageManager.instance.init();

  Stripe.publishableKey = Constants.puplishableKey;
  await Stripe.instance.applySettings();

  await di.init();

  //? Remove token from both SharedPreferences AND FlutterSecureStorage
  // await StorageManager.instance.removeData(key: Constants.kAccessToken);
  // await StorageManager.instance.removeSecuredString(
  //   key: Constants.kAccessToken,
  // );
  //? Clear hasSeenOnboarding to force showing onboarding after clearing token
  // await StorageManager.instance.removeData(key: "hasSeenOnboarding");

  runApp(ShatablyAdminApp());
  // runApp(
  //   DevicePreview(
  //     enabled: !kReleaseMode,
  //     builder: (context) => ShatablyAdminApp(), // Wrap your app
  //   ),
  // );
}
