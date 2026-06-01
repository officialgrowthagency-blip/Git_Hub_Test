import 'package:test_firbase_project/features/auth/domain/entity.dart';

abstract class AuthState {}

class AuthInit extends AuthState {}

class AuthProgress extends AuthState {}

class UserAuthorized extends AuthState {
  final AuthenticatedUser user;

  UserAuthorized({required this.user});
}

class UserUnAuthorized extends AuthState {}

class PasswordVerifyState extends AuthState {}

class PasswordShowState extends AuthState {
  final bool obsecurePassword;

    PasswordShowState({
      required this.obsecurePassword,
    });
}

class ErrorRequest extends AuthState {
  final String? message;

  ErrorRequest(this.message);
}
