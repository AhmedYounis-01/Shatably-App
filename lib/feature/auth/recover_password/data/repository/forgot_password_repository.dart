import 'package:shatably_app/core/services/api/api_consumer.dart';
import 'package:shatably_app/core/services/api/end_points.dart';
import 'package:shatably_app/feature/auth/recover_password/data/model/forgot_password_model.dart';

class ForgotPasswordRepository {
  final ApiConsumer _apiConsumer;
  ForgotPasswordRepository(this._apiConsumer);
  Future<ForgotPasswordResponse> forgotPassword(
    ForgotPasswordRequest passwordResetRequest,
  ) async {
    final response = await _apiConsumer.post(
      EndPoints.forgotPassword,
      data: passwordResetRequest.toJson(),
    );
    return ForgotPasswordResponse.fromJson(response.data);
  }
}
