import 'package:logger/logger.dart';
import 'package:shatably_app/core/services/api/api_consumer.dart';
import 'package:shatably_app/core/services/api/end_points.dart';
import 'package:shatably_app/core/services/api/server_failure.dart';
import 'package:shatably_app/feature/maintenance%20work/data/model/maintenance_work_model.dart';

class MaintenanceWorkRepository {
  final ApiConsumer _apiConsumer;

  MaintenanceWorkRepository(this._apiConsumer);

  Future<MaintenanceServiceModel> getMaintenanceWorkProducts(String id) async {
    try {
      final response = await _apiConsumer.get(
        "${EndPoints.maintenanceWorkById}/$id",
      );
      Logger().i('Response Data: ${response.data}');
      return MaintenanceServiceModel.fromJson(response.data);
    } on ServerFailure catch (err) {
      throw Exception(
        'Error fetching maintenance work: ${err.message} (${err.statusCode})',
      );
    }
  }
}
