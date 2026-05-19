  import 'package:test_firbase_project/features/auth/domain/entity.dart';

abstract class AuthEvent {}

  class FetchAuthEvent extends AuthEvent {

    final UserEntity user;

    FetchAuthEvent({
      required this.user
    });
  }

   class  FetchSignAuthEvent extends AuthEvent {

    final UserEntity? user;

    FetchSignAuthEvent({
      required this.user
    });
     
   }

    class PasswordUpdateEvent extends AuthEvent {
       final String email;
       final String password;
       PasswordUpdateEvent({
        required this.email,
        required this.password,
       });
    }

    class LogOutEvent extends AuthEvent {}