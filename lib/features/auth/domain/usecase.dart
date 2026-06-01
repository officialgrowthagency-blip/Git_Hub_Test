
import 'package:test_firbase_project/features/auth/domain/entity.dart';
import 'package:test_firbase_project/features/auth/domain/repositories.dart';

class UserAuthCase {
  final Repositories repositories;

  UserAuthCase(this.repositories);

  Future<AuthenticatedUser> login(UserEntity user) async {
    
     return await repositories.loginRequest(
      email: user.email, password: user.password);
  }

  Future<AuthenticatedUser> signUp(UserEntity user) async {
    return await repositories.signUpRequest(email: user.email, password: user.password);
  }

   Future<void> updatePassword ({
    required String curentPassword,
    required String password,
   }) async{
     
     await repositories.changePasswordRequest(currentPassword: curentPassword, newPassword: password);
   }

    Future<AuthenticatedUser> googleSign () async {
      return await repositories.userGoogleSign();
    }

  Future<void> logOut () async {
   return await repositories.logOutUser();
  }

   Future<AuthenticatedUser?> getUserData ({
    required String uid,
   }) async {

     return await repositories.getUserData(uid: uid);
   }
}
