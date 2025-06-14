import 'package:logger/logger.dart';
import 'package:shatably_app/core/services/api/api_consumer.dart';
import 'package:shatably_app/core/services/api/end_points.dart';
import 'package:shatably_app/core/services/api/server_failure.dart';
import 'package:shatably_app/feature/projects/data/model/projects_model.dart';

class ProjectsRepository {
  final ApiConsumer _apiConsumer;

  ProjectsRepository(this._apiConsumer);
  Future<ProjectsModel> getProjects() async {
    try {
      final response = await _apiConsumer.get(EndPoints.projects);
      Logger().i('Response Data: ${response.data}');
      return ProjectsModel.fromJson(response.data);
    } on ServerFailure catch (err) {
      throw Exception(
        'Error fetching maintenance work: ${err.message} (${err.statusCode})',
      );
    }
  }

  // دالة جديدة لجلب تفاصيل مشروع معين باستخدام معرف المشروع (projectId)
  Future<ProjectsModel> getProjectDetails(String projectId) async {
    try {
      // نفترض أن نقطة نهاية الـ API لجلب مشروع معين هي على النحو التالي: '/projects/{projectId}'
      final response = await _apiConsumer.get(
          "${EndPoints.projects}/$projectId",
      );
      Logger().i('Response Data for Project ID $projectId: ${response.data}');
      return ProjectsModel.fromJson(response.data);
    } on ServerFailure catch (err) {
      Logger().e(
        'Error fetching project details for ID $projectId: ${err.message} (${err.statusCode})',
      );
      throw Exception(
        'Error fetching project details: ${err.message} (${err.statusCode})',
      );
    } catch (e) {
      Logger().e(
        'Unexpected error fetching project details for ID $projectId: $e',
      );
      throw Exception('An unexpected error occurred: $e');
    }
  }
}
