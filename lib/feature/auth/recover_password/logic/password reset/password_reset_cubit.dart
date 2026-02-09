import 'package:bloc/bloc.dart';
import 'package:logger/logger.dart';
import 'package:meta/meta.dart';
import 'package:shatably_app/core/services/api/server_failure.dart';
import 'package:shatably_app/feature/auth/recover_password/data/model/password_reset_model.dart';
import 'package:shatably_app/feature/auth/recover_password/data/repository/password_reset_repository.dart';

part 'password_reset_state.dart';

class PasswordResetCubit extends Cubit<PasswordResetStates> {
  PasswordResetCubit(this._passwordResetRepository)
    : super(PasswordResetInitial());
  final PasswordResetRepository _passwordResetRepository;

  Future<void> resetPassword(
    String email,
    String token,
    String newPassword,
    String confirmNewPassword,
  ) async {
    emit(PasswordResetLoadingState());
    try {
      final resetPasswordReqest = ResetPasswordRequest(
        email: email,
        token: token,
        newPassword: newPassword,
        confirmNewPassword: confirmNewPassword,
      );
      final resetPasswordResponse = await _passwordResetRepository
          .resetPassword(resetPasswordReqest);
      Logger().i('reset password response: $resetPasswordResponse');
    } on ServerFailure catch (err) {
      Logger().e('reset password error: $err');
      emit(PasswordResetErrorState(errMessage: err.message));
    } catch (e) {
      Logger().e('reset password error: $e');
      emit(PasswordResetErrorState(errMessage: e.toString()));
    }
  }
}
