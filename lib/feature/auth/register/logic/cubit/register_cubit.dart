import 'package:bloc/bloc.dart';
import 'package:logger/logger.dart';
import 'package:meta/meta.dart';
import 'package:shatably_app/feature/auth/register/data/model/register_model.dart';
import 'package:shatably_app/feature/auth/register/data/repository/register_repository.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit(this._registerRepository) : super(RegisterInitial());
  final RegisterRepository _registerRepository;

  Future<void> register(
    String email,
    String firstName,
    String lastName,
    String password,
    String? role,
    String? userName,
    String phoneNumber,
  ) async {
    emit(RegisterLoading());
    try {
      final registerRequest = RegisterRequest(
        email: email,
        firstName: firstName,
        lastName: lastName,
        password: password,
        userName: userName,
        role: role,
        phoneNumber: phoneNumber,
      );

      final registerResponse = await _registerRepository.register(
        registerRequest,
      );

      Logger().i('Register response: $registerResponse');
      emit(RegisterSuccess());
    } catch (e) {
      Logger().e('Register error: $e');

      emit(RegisterError(message: e.toString()));
    }
  }

  void resetState() {
    emit(RegisterInitial());
  }
}
