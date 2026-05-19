import 'package:firebase_auth/firebase_auth.dart';


class FirbaseAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<UserCredential> signUp({
    required String email,
    required String password,
  }) async {
    try {
      return await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException {
       rethrow;
    }
  }

  Future<UserCredential> login({
    required String email,
    required String password,
  }) async {
    try {
      return await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException {
       rethrow;
    }
  }

  Future<void> logOut () async {
     
    await _auth.signOut();
  }

   User? get currentUser => _auth.currentUser;



   Future<void> changePassword (
    {
      required String currentPasswordControler,
      required String newPasswordControler,
    }
   ) async {
    
     final user = _auth.currentUser!;
     final credential = EmailAuthProvider.credential(
      email: user.email!, 
      password: currentPasswordControler
      );
      
      await user.reauthenticateWithCredential(credential);

      await user.updatePassword(newPasswordControler);

   }
}
