import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:shatably_app/bloc_observer.dart';
import 'package:shatably_app/core/helpers/cache/storage_manager.dart';
import 'package:shatably_app/core/helpers/constant/constant.dart';
import 'package:shatably_app/shatably_admin_app.dart';
import 'core/injection/injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  // print("Token manger ${TokenManager.getAccessToken()}");
  // print("Secure StorageHelper ${SecureStorageHelper.getUserId}");

  // Stripe.publishableKey = Constants.puplishableKey;
  await StorageManager.instance.init();
  await di.init();
  // await SecureStorageHelper.clearAll();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      // statusBarIconBrightness: Brightness.dark,
    ),
  );
  runApp(ShatablyAdminApp());
  // runApp(
  //   DevicePreview(
  //     enabled: !kReleaseMode,
  //     builder: (context) => ShatablyAdminApp(), // Wrap your app
  //   ),
  // );
}
