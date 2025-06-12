part of 'forgot_password_cubit.dart';

@immutable
sealed class ForgotPasswordStates {}

final class ForgotPasswordInitial extends ForgotPasswordStates {}

final class ForgotPasswordLoading extends ForgotPasswordStates {}

final class ForgotPasswordSuccess extends ForgotPasswordStates {
  final String seuccessMessage;
  final String email;
  ForgotPasswordSuccess({required this.email, required this.seuccessMessage});
}

final class ForgotPasswordError extends ForgotPasswordStates {
  final String errMessage;
  ForgotPasswordError({required this.errMessage});
}
