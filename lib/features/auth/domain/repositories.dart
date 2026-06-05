

import 'package:test_firbase_project/features/auth/data/model.dart';
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

   Future<UserModel> getUserData ({
     required String uid,
   });

  Future<void> changePasswordRequest ({
    required String currentPassword,
    required String newPassword,
  });

  Future<AuthenticatedUser> userGoogleSign ();

  Future<AuthenticatedUser> facebookSign ();


   Future<void> logOutUser ();
 }