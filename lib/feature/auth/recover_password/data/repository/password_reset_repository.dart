import 'package:shatably_app/core/services/api/api_consumer.dart';
import 'package:shatably_app/core/services/api/end_points.dart';
import 'package:shatably_app/feature/auth/recover_password/data/model/password_reset_model.dart';

class PasswordResetRepository {
  final ApiConsumer _apiConsumer;

  PasswordResetRepository(this._apiConsumer);

  Future<ResetPasswordResponse> resetPassword(
    ResetPasswordRequest resetPasswordRequest,
  ) async {
    final response = await _apiConsumer.post(
      EndPoints.resetPassword,
      data: resetPasswordRequest.toJson(),
    );
    return ResetPasswordResponse.fromJson(response.data);
  }
}
