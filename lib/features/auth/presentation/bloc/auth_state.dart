import 'package:test_firbase_project/features/auth/domain/entity.dart';

abstract class AuthState {}

class AuthInit extends AuthState {}

class AuthProgress extends AuthState {}

class UserAuthorized extends AuthState {
  final AuthenticatedUser user;
  
   bool isCheck;

  UserAuthorized({
    required this.user,
    this.isCheck = false,
    
    });
}

class UserUnAuthorized extends AuthState {}

class PasswordVerifyState extends AuthState {}

class PasswordShowState extends AuthState {}

class ErrorRequest extends AuthState {
  final String? message;

  ErrorRequest(this.message);
}
