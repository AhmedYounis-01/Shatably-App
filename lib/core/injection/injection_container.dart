import 'package:get_it/get_it.dart';
import 'package:shatably_app/feature/auth/login/data/repository/login_repository.dart';
import 'package:shatably_app/feature/auth/login/logic/cubit/login_cubit.dart';
import 'package:shatably_app/feature/auth/recover_password/data/repository/forgot_password_repository.dart';
import 'package:shatably_app/feature/auth/recover_password/data/repository/password_reset_repository.dart';
import 'package:shatably_app/feature/auth/recover_password/logic/forgot%20password/forgot_password_cubit.dart';
import 'package:shatably_app/feature/auth/recover_password/logic/password%20reset/password_reset_cubit.dart';
import 'package:shatably_app/feature/auth/register/data/repository/register_repository.dart';
import 'package:shatably_app/feature/auth/register/logic/cubit/register_cubit.dart';
import 'package:shatably_app/feature/layouts/logic/cubit/applayout_cubit.dart';

import '../services/api/api_consumer.dart';
import '../services/api/dio_consumer.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Api
  sl.registerLazySingleton<ApiConsumer>(() => DioConsumer());

  // Repositories
  sl.registerLazySingleton(() => RegisterRepository(sl<ApiConsumer>()));
  sl.registerLazySingleton(() => LoginRepository(sl<ApiConsumer>()));
  sl.registerLazySingleton(() => ForgotPasswordRepository(sl<ApiConsumer>()));
  sl.registerLazySingleton(() => PasswordResetRepository(sl<ApiConsumer>()));

  // Cubits
  sl.registerFactory(() => ApplayoutCubit());
  sl.registerFactory(() => LoginCubit(sl()));
  sl.registerFactory(() => RegisterCubit(sl()));
  sl.registerFactory(() => ForgotPasswordCubit(sl()));
  sl.registerFactory(() => PasswordResetCubit(sl()));
}
