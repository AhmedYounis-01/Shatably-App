import 'package:get_it/get_it.dart';
import 'package:shatably_app/feature/AI/data/repository/chat_repository.dart';
import 'package:shatably_app/feature/AI/data/repository/image_generator_repository.dart';
import 'package:shatably_app/feature/AI/logic/chat%20ai/chat_cubit.dart';
import 'package:shatably_app/feature/AI/logic/image%20generator/image_generator_cubit.dart';
import 'package:shatably_app/feature/auth/login/data/repository/login_repository.dart';
import 'package:shatably_app/feature/auth/login/logic/cubit/login_cubit.dart';
import 'package:shatably_app/feature/auth/recover_password/data/repository/forgot_password_repository.dart';
import 'package:shatably_app/feature/auth/recover_password/data/repository/password_reset_repository.dart';
import 'package:shatably_app/feature/auth/recover_password/logic/forgot%20password/forgot_password_cubit.dart';
import 'package:shatably_app/feature/auth/recover_password/logic/password%20reset/password_reset_cubit.dart';
import 'package:shatably_app/feature/auth/register/data/repository/register_repository.dart';
import 'package:shatably_app/feature/auth/register/logic/cubit/register_cubit.dart';
import 'package:shatably_app/feature/layouts/logic/cubit/applayout_cubit.dart';
import 'package:shatably_app/feature/maintenance%20work/data/repository/maintenance_work_repository.dart';
import 'package:shatably_app/feature/maintenance%20work/logic/cubit/maintenance_work_cubit.dart';
import 'package:shatably_app/feature/projects/data/repository/projects_repository.dart';
import 'package:shatably_app/feature/projects/logic/cubit/projects_cubit.dart';

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
  sl.registerLazySingleton(() => MaintenanceWorkRepository(sl<ApiConsumer>()));
  sl.registerLazySingleton(() => ProjectsRepository(sl<ApiConsumer>()));
  sl.registerLazySingleton(() => ImageGeneratorRepository(sl<ApiConsumer>()));
  sl.registerLazySingleton(() => ChatRepository(sl<ApiConsumer>()));

  // Cubits
  sl.registerFactory(() => ApplayoutCubit());
  sl.registerFactory(() => LoginCubit(sl()));
  sl.registerFactory(() => RegisterCubit(sl()));
  sl.registerFactory(() => ForgotPasswordCubit(sl()));
  sl.registerFactory(() => PasswordResetCubit(sl()));
  sl.registerFactory(() => MaintenanceWorkCubit(sl()));
  sl.registerFactory(() => ProjectsCubit(sl()));
  sl.registerFactory(() => ImageGeneratorCubit(sl()));
  sl.registerFactory(() => ChatCubit(sl()));
}
