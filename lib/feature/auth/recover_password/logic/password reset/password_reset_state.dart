part of 'password_reset_cubit.dart';

@immutable
sealed class PasswordResetStates {}

final class PasswordResetInitial extends PasswordResetStates {}

final class PasswordResetLoadingState extends PasswordResetStates {}

final class PasswordResetSuccessState extends PasswordResetStates {
  final String successMessage;
  PasswordResetSuccessState({required this.successMessage});
}

final class PasswordResetErrorState extends PasswordResetStates {
  final String errMessage;

  PasswordResetErrorState({required this.errMessage});
}
