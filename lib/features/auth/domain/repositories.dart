
import 'package:test_firbase_project/features/auth/domain/entity.dart';

abstract class Repositories {

  Future<AuthenticatedUser> loginRequest ({
     required String email,
     required String password,
  });

   Future<AuthenticatedUser> signUpRequest ({
     required String email,
     required String password,
  });

  Future<void> changePasswordRequest ({
    required String email,
    required String password,
  });

   Future<void> logOutUser ();
 }