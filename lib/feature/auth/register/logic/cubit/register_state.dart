// part of 'register_cubit.dart';

// @immutable
// sealed class RegisterStates {}

// final class RegisterInitial extends RegisterStates {}

// final class RegisterLoading extends RegisterStates {}

// final class RegisterSuccess extends RegisterStates {}

// final class RegisterError extends RegisterStates {}
// Updated Register States
part of 'register_cubit.dart';

@immutable
abstract class RegisterStates {}

class RegisterInitial extends RegisterStates {}

class RegisterLoading extends RegisterStates {}

class RegisterSuccess extends RegisterStates {}

class RegisterError extends RegisterStates {
  final String message;
  RegisterError({required this.message});
}
