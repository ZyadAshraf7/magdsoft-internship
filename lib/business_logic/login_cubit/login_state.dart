part of 'login_cubit.dart';

@immutable
abstract class LoginState {}

class LoginInitial extends LoginState {}
class LoginLoading extends LoginState {}
class LoginSuccess extends LoginState {}
class LoginErrorOccurred extends LoginState {}
class LoginEmptyField extends LoginState {}
class LoginInvalidEmail extends LoginState {}
class LoginWeakPassword extends LoginState {}
class ChangePasswordVisibility extends LoginState{}

