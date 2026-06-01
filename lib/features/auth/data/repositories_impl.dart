import 'package:firebase_auth/firebase_auth.dart';
import 'package:test_firbase_project/features/auth/data/data_source.dart';
import 'package:test_firbase_project/features/auth/data/model.dart';
import 'package:test_firbase_project/features/auth/domain/entity.dart';
import 'package:test_firbase_project/features/auth/domain/repositories.dart';

class FirbaseRepository extends Repositories {
  final FirbaseAuthService firbaseService;

  FirbaseRepository(this.firbaseService);

  @override
  Future<AuthenticatedUser> loginRequest({
    required String email,
    required String password,
  }) async {
    final credentialt = await firbaseService.login(
      email: email,
      password: password,
    );

    try {
      return AuthenticatedUser(
        uid: credentialt.user!.uid, 
        email: email,
        name: credentialt.user?.displayName ?? 'Unknown Name',
        image: credentialt.user?.photoURL ?? "",
      );
    } on FirebaseAuthException catch (e) {
      throw Exception(e.message);
    }
  }

  @override
  Future<AuthenticatedUser> signUpRequest({
    required String email,
    required String password,
  }) async {
    final credential = await firbaseService.signUp(
      email: email,
      password: password,
    );

    try {
      return AuthenticatedUser(
        uid: credential.uid, 
        email: credential.email,
        name: credential.name,
        image: credential.image,
      );
    } on FirebaseAuthException catch (e) {
      throw Exception(e.message);
    }
  }

   
  
  @override
  Future<void> logOutUser() async {

   
    
   await firbaseService.logOut();
  }
  
  @override
  Future<void> changePasswordRequest({
    required String currentPassword, 
    required String newPassword}) async{
     
     await firbaseService.changePassword(
      currentPasswordControler: currentPassword, 
      newPasswordControler: newPassword,
    );
   
  }
  
  @override
  Future<UserModel> getUserData({required String uid}) async {
    
    final model = await firbaseService.getUserFireStore(uid: uid);

     return model;

  }
  
  @override
  Future<AuthenticatedUser> userGoogleSign() async {
     return await firbaseService.signInWithGoogle();
  }
}
