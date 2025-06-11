part of 'login_cubit.dart';

@immutable
sealed class LoginStates {}

final class LoginInitial extends LoginStates {}

final class LoginLoadingState extends LoginStates {}

final class LoginSuccessState extends LoginStates {}

final class LoginErrorState extends LoginStates {
  final String message;

  LoginErrorState({required this.message});
}
