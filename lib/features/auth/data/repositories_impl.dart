import 'package:firebase_auth/firebase_auth.dart';
import 'package:test_firbase_project/features/auth/data/data_source.dart';
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
        uid: credential.user?.uid ?? '', 
        email: credential.user?.email ?? "No Email",
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
    required String email, 
    required String password}) async{
    
     await firbaseService.changePassword(
      currentPasswordControler: email, 
      newPasswordControler: password,
    );
   
  }
}
