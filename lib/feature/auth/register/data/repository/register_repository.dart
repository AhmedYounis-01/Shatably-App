import 'package:shatably_app/core/services/api/api_consumer.dart';
import 'package:shatably_app/core/services/api/end_points.dart';
import 'package:shatably_app/feature/auth/register/data/model/register_model.dart';

class RegisterRepository {
  final ApiConsumer _apiConsumer;
  RegisterRepository(this._apiConsumer);

  Future<RegisterResponse> register(RegisterRequest registerRequest) async {
    final response = await _apiConsumer.post(
      EndPoints.register,
      data: registerRequest.toJson(),
    );
    return RegisterResponse.fromJson(response.data);
  }
}
