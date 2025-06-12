import 'package:bloc/bloc.dart';
import 'package:logger/logger.dart';
import 'package:meta/meta.dart';
import 'package:shatably_app/feature/auth/recover_password/data/model/forgot_password_model.dart';
import 'package:shatably_app/feature/auth/recover_password/data/repository/forgot_password_repository.dart';

part 'forgot_password_state.dart';

class ForgotPasswordCubit extends Cubit<ForgotPasswordStates> {
  ForgotPasswordCubit(this._forgotPasswordRepository)
    : super(ForgotPasswordInitial());
  final ForgotPasswordRepository _forgotPasswordRepository;

  Future<void> forgotPassword(String email) async {
    emit(ForgotPasswordLoading());
    try {
      final forgotPassowrdRequest = ForgotPasswordRequest(email: email);
      final forgotPassowrdResponse = await _forgotPasswordRepository
          .forgotPassword(forgotPassowrdRequest);

      Logger().i('Login response: $forgotPassowrdResponse');
      emit(
        ForgotPasswordSuccess(
          seuccessMessage: forgotPassowrdResponse.message,
          email: email,
        ),
      );
    } catch (err) {
      Logger().e('Login error: $err');
      emit(ForgotPasswordError(errMessage: err.toString()));
    }
  }
}
