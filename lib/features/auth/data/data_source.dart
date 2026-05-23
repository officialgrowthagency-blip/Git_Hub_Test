import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:test_firbase_project/features/auth/data/model.dart';



class FirbaseAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  late final FirebaseFirestore firestore;

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
        uid: credential.user!.uid, email: credential.user!.email!);

        await FirebaseFirestore.instance.collection("users").doc(
          credential.user!.uid).set(
            user.toMap());

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

    
    Future<UserModel> getUserFireStore({
      required String uid,
    }) async {

      final docs = await firestore.collection("users").doc(uid).get();

       if(docs.exists){
         return UserModel.fromMap(docs.data()!);
       }
        else {
          throw Exception("user not found");
        }
    }


   Future<void> changePassword (
    {
      required String currentPasswordControler,
      required String newPasswordControler,
    }
   ) async {
    
     final user = _auth.currentUser!;

      debugPrint("User Data null");
      
     final credential = EmailAuthProvider.credential(
      email: user.email!.trim(), 
      password: currentPasswordControler.trim(),
      );
        

        
      await user.reauthenticateWithCredential(credential);

      await user.updatePassword(newPasswordControler);

   }
}
