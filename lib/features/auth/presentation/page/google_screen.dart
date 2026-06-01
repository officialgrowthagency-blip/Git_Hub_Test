import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:test_firbase_project/features/auth/presentation/page/auth_page/login_screen.dart';

class GoogleScreen extends StatefulWidget {
  const GoogleScreen({super.key});

  @override
  State<GoogleScreen> createState() => _GoogleScreenState();
}

class _GoogleScreenState extends State<GoogleScreen> {
  
  Future<UserCredential> signInWithGoogle() async {
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

    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

   Future<void> signOutGoogle () async {

     await GoogleSignIn().signOut();

     await user.signOut();

      setState(() {
        
      });

   }

  final user = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Google Sign"),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Column(
         mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (user.currentUser == null)
              ElevatedButton(
                onPressed: () async{
        
                  await signInWithGoogle(); 
                 
                   setState(() {
                     Navigator.push(context, 
                     MaterialPageRoute(builder: (context)=> const LoginScreen()));
                   });
                },
                child: const Text("Sign In Google"),
              ),
        
            if (user.currentUser != null)...[
               Text(user.currentUser?.email ?? 'No Email'),
              ElevatedButton(
                onPressed: signOutGoogle,
                child: const Text("Sign Out Google"),
              ),
            ]

              
          ],
        ),
      ),
    );
  }
}
