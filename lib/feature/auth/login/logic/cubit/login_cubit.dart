import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shatably_app/core/helpers/cache/storage_manager.dart';
import 'package:shatably_app/core/helpers/constant/constant.dart';
import 'package:shatably_app/feature/auth/login/data/repository/login_repository.dart';
import 'package:logger/logger.dart';
import 'package:shatably_app/core/services/api/server_failure.dart';
import 'package:shatably_app/feature/auth/login/data/model/login_model.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit(this._loginRepository) : super(LoginInitial());
  final LoginRepository _loginRepository;
  String? _email;

  void setEmail(String email) {
    _email = email;
  }

  Future<void> loginWithPassword(String password) async {
    if (_email == null) {
      emit(LoginErrorState(message: 'Email is null'));
      return;
    }

    emit(LoginLoadingState());
    try {
      final loginRequest = LoginRequest(email: _email!, password: password);
      final loginResponse = await _loginRepository.login(loginRequest);
      Logger().i('Login response: $loginResponse');
      //! save token
      await StorageManager.instance.setSecuredString(
        key: Constants.kAccessToken,
        value: loginResponse.token,
      );
      print(loginResponse.token);
      emit(LoginSuccessState());
    } on ServerFailure catch (e) {
      Logger().e('Login error: $e');
      emit(LoginErrorState(message: e.message));
    } catch (e) {
      Logger().e('Login error: $e');
      emit(LoginErrorState(message: e.toString()));
    }
  }
}
