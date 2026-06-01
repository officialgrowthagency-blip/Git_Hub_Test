import 'package:test_firbase_project/features/auth/domain/entity.dart';

abstract class AuthEvent {}

 class ShowPasswordEvent extends AuthEvent {}

 class LoginEmailEvent extends AuthEvent {
  final UserEntity user;

  LoginEmailEvent({required this.user});
}

class SignUpEmailEvent extends AuthEvent {
  final UserEntity? user;

  SignUpEmailEvent({required this.user});
}

class PasswordUpdateEvent extends AuthEvent {
  final String currentPassword;
  final String newPassword;
  PasswordUpdateEvent({
    required this.currentPassword,
    required this.newPassword,
  });
}

class GetFireStoreDataEvent extends AuthEvent {

   final String uid;
  

  GetFireStoreDataEvent({required this.uid});
}

 class GoogleSignEvent extends AuthEvent {}

 

class LogOutEvent extends AuthEvent {}
 
  



