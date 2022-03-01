part of 'auth_cubit.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class LoginSuccess extends AuthState {}

class LoginFailure extends AuthState {
  final String errorMsg;

  LoginFailure({required this.errorMsg});
}

class RegisterSuccess extends AuthState {}

class RegisterFailure extends AuthState {
  final String errorMsg;

  RegisterFailure({required this.errorMsg});
}

class SignOutSuccess extends AuthState {}
