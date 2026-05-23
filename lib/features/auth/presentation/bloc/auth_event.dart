import 'package:test_firbase_project/features/auth/domain/entity.dart';

abstract class AuthEvent {}

class FetchAuthEvent extends AuthEvent {
  final UserEntity user;

  FetchAuthEvent({required this.user});
}

class FetchSignAuthEvent extends AuthEvent {
  final UserEntity? user;

  FetchSignAuthEvent({required this.user});
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

class LogOutEvent extends AuthEvent {}
