import 'package:shatably_app/core/services/api/api_consumer.dart';
import 'package:shatably_app/core/services/api/end_points.dart';
import 'package:shatably_app/feature/auth/login/data/model/login_model.dart';

class LoginRepository {
  final ApiConsumer _apiConsumer;

  LoginRepository(this._apiConsumer);
  Future<LoginResponse> login(LoginRequest loginReqest) async {
    final response = await _apiConsumer.post(
      EndPoints.login,
      data: loginReqest.toJson(),
    );
    return LoginResponse.fromJson(response.data);
  }
}
