part of 'register_cubit.dart';

@immutable
abstract class RegisterState {}

class RegisterInitial extends RegisterState {}
class RegisterLoading extends RegisterState {}
class RegisterSuccess extends RegisterState {}
class RegisterErrorOccurred extends RegisterState {}
class ChangePasswordVisibility extends RegisterState {}
class ChangeConfirmPasswordVisibility extends RegisterState {}
class PasswordsNotEquivalent extends RegisterState {}
