 
import 'package:get_it/get_it.dart';

 
import '../services/api/api_consumer.dart';
import '../services/api/dio_consumer.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Api
  sl.registerLazySingleton<ApiConsumer>(() => DioConsumer());

  // Repositories
  // sl.registerLazySingleton(() => AuthRepository(sl<ApiConsumer>()));
  

  // Cubits
  // sl.registerFactory(() => AppLayoutCubit());
   
}
