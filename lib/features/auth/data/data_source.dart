import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:test_firbase_project/features/auth/data/auth_service.dart';
import 'package:test_firbase_project/features/auth/data/model.dart';
import 'package:test_firbase_project/features/auth/domain/entity.dart';

class FirbaseAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;


  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  Future<UserModel> signUp({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = UserModel(
        uid: credential.user!.uid,
        email: credential.user!.email!,
        name: credential.user!.displayName!,
        image: credential.user!.photoURL!,
      );

      await firestore.collection("users")
          .doc(credential.user!.uid)
          .set(user.toMap());

       return user;
    } on FirebaseAuthException {
      rethrow;
    }
  }

  Future<UserCredential> login({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = await firestore
          .collection("users")
          .doc(credential.user!.uid)
          .get();

      if (!user.exists) {
        await firestore.collection("users").doc(credential.user!.uid).set({
          "uid": credential.user!.uid,
          "email": credential.user!.email,
        });
      }
      return credential;
    } on FirebaseAuthException {
      rethrow;
    }
  }

  Future<void> logOut() async {
    await GoogleSignIn().signOut();
    await FacebookAuth.instance.logOut();
    await _auth.signOut();
  }

  User? get currentUser => _auth.currentUser;

  Future<UserModel> getUserFireStore({required String uid}) async {
    final docs = await firestore.collection("users").doc(uid).get();

    if (docs.exists) {
      return UserModel.fromMap(docs.data()!);
    } else {
      throw Exception("user not found");
    }
  }

  Future<void> changePassword({
    required String currentPasswordControler,
    required String newPasswordControler,
  }) async {
    final user = _auth.currentUser!;

    debugPrint("User Data null");

    final credential = EmailAuthProvider.credential(
      email: user.email!.trim(),
      password: currentPasswordControler.trim(),
    );

    await user.reauthenticateWithCredential(credential);

    await user.updatePassword(newPasswordControler);
  }

  static Future<void> signUpEmailLink (String email) async {

     final actionCodeSettings = ActionCodeSettings(
      url: 'https://test-flutter-project-41421.web.app/login',
      handleCodeInApp: true,
      androidPackageName: "com.example.test_firbase_project",
      androidInstallApp: true,
      androidMinimumVersion: "10",
      
    );

     await FirebaseAuth.instance.sendSignInLinkToEmail(
      email: email, 
      actionCodeSettings: actionCodeSettings,
    );


  }

  static Future<User?> signInEmailLink (String emailLink) async {

      if(FirebaseAuth.instance.isSignInWithEmailLink(emailLink)) return null;

       final email = await AuthService.getEmail();

       if(email == null) return null;

       final result = await FirebaseAuth.instance.signInWithEmailLink(
        email: email, 
        emailLink: emailLink,
      );
       
       await AuthService.removeEmail();

      return result.user;
       
   }

    Future<AuthenticatedUser> signInWithGoogle() async {
    final GoogleSignIn googleSignIn = GoogleSignIn(scopes: ["email"]);
    final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

    if (googleUser == null) {
      throw Exception("User Not Selected");
    }

    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
      idToken: googleAuth.idToken,
      accessToken: googleAuth.accessToken,
    );

   final userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
   final user = userCredential.user!;

    return AuthenticatedUser(
      uid: user.uid, 
      email: user.email.toString(),
      name: user.displayName.toString(),
      image: user.photoURL.toString(),
      );
  }

  

Future<AuthenticatedUser> signInWithFacebook() async {
 
  final LoginResult loginResult = await FacebookAuth.instance.login();

 
   if(loginResult.status != LoginStatus.success) {
      
      throw Exception('Facebook login failed: ${loginResult.message}');
   }
     final OAuthCredential facebookAuthCredential = FacebookAuthProvider.credential(
    loginResult.accessToken!.tokenString
    );
     final UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(
      facebookAuthCredential
    );
    
     final user = userCredential.user!;
 
  return AuthenticatedUser(
    uid: user.uid, 
    email: user.email ?? '', 
    name: user.displayName ?? '', 
    image: user.photoURL ?? '');
}

}
