import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:test_firbase_project/features/auth/data/data_source.dart';
import 'package:test_firbase_project/features/auth/domain/entity.dart';
import 'package:test_firbase_project/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:test_firbase_project/features/auth/presentation/bloc/auth_event.dart';
import 'package:test_firbase_project/features/auth/presentation/bloc/auth_state.dart';
import 'package:test_firbase_project/features/auth/presentation/page/auth_page/login_screen.dart';
import 'package:test_firbase_project/features/auth/presentation/page/utilitis/colors.dart';
import 'package:test_firbase_project/features/auth/presentation/page/utilitis/regex_validator.dart';
import 'package:test_firbase_project/features/auth/presentation/widgets/reusable_snackbar.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _nameControler = TextEditingController();
  final TextEditingController _passwordControler = TextEditingController();
  final TextEditingController _emailControler = TextEditingController();
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  final FirbaseAuthService firbaseAuth = FirbaseAuthService();

  late final TapGestureRecognizer _gestureRecognizer = TapGestureRecognizer()
    ..onTap = () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    };

  bool removeRedEye = false;

   

  @override
  void dispose() {
    _gestureRecognizer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 10),
        child: SingleChildScrollView(
          child: Form(
            key: _globalKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 80),
                const Text(
                  "Create Account",
                  style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 10),

                const Text(
                  "Sign up get started",
                  style: TextStyle(fontSize: 14),
                ),

                const SizedBox(height: 40),

                TextFormField(
                  controller: _nameControler,
                  decoration: InputDecoration(
                    labelText: "Name",
                    hintText: "Enter First and Last Name",
                    prefixIcon: Icon(Icons.person),
                  ),
                  validator: Validator.validName,
                ),

                const SizedBox(height: 25),

                TextFormField(
                  controller: _emailControler,

                  decoration: InputDecoration(
                    labelText: "Email",
                    hintText: "Enter Email",
                    prefixIcon: Icon(Icons.email),
                  ),
                  validator: Validator.validEmail,
                ),

                const SizedBox(height: 25),

                TextFormField(
                  controller: _passwordControler,

                  obscureText: removeRedEye,
                  decoration: InputDecoration(
                    labelText: "Password",
                    hintText: "Enter Password",
                    prefixIcon: Icon(Icons.key_sharp),

                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          removeRedEye = !removeRedEye;
                        });
                      },
                      icon: Icon(
                        removeRedEye
                            ? Icons.remove_red_eye
                            : Icons.remove_red_eye_outlined,
                      ),
                    ),
                  ),
                  validator: Validator.passwordValidator,
                ),

                const SizedBox(height: 35),

                BlocConsumer<AuthBloc, AuthState>(
                  listener: (context, state) {
                    if (state is UserAuthorized) {
                      if (!context.mounted) return;

                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginScreen(),
                        ),
                      );

                      AppSnackbar.snackBar(
                        context,
                        "Account Create Successful",
                      );
                    } else if (state is ErrorRequest) {
                      AppSnackbar.snackBar(
                        context,
                        state.message ?? 'Sign error',
                      );
                    }
                  },
                  builder: (context, state) {
                    return SizedBox(
                      height: 55,
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: (state is AuthProgress)
                            ? null
                            : () async {
                                if (!_globalKey.currentState!.validate()) return;
                                 // kaj ache..
                                  context.read<AuthBloc>().add(
                                    SignUpEmailEvent(user: UserEntity(
                                      email: _emailControler.text.trim(), 
                                      password: _passwordControler.text,
                                    ),
                                  ),
                                );
                              },
                            child: (state is AuthProgress)
                            ? SizedBox(
                                height: 30,
                                width: 30,
                                child: Center(
                                  child: CircularProgressIndicator(),
                                ),
                              )
                            : Text(
                                "Create Account",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                      ),
                    );
                  },
                ),

                const SizedBox(height: 13),

                Center(
                  child: Column(
                    children: [
                      const Text(
                        "OR",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),

                      const SizedBox(height: 10),

                      const Text(
                        "Sign up with",
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0XFF555555),
                        ),
                      ),

                      const SizedBox(height: 7),

                      Row(
                        children: [
                          _socialAccount(
                           text: "Google",
                            image:"lib/features/assets/google.png",
                            callBack: () {

                            
                            },
                            
                            
                             
                          ),
                          _socialAccount(
                            text: "Facebook",
                            image: "lib/features/assets/facebook.png",
                            callBack: () {
                              
                            },
                          ),

                         
                        ],
                      ),

                      const SizedBox(height: 25),

                      _richTextCustom(_gestureRecognizer),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  RichText _richTextCustom(GestureRecognizer page) {
    return RichText(
      text: TextSpan(
        text: "Already have an account? ",
        style: TextStyle(fontSize: 14, color: Colors.black),
        children: <TextSpan>[
          TextSpan(
            text: "Login",
            style: TextStyle(
              fontSize: 15,
              color: AppColors.navieBlurolors,
              fontWeight: FontWeight.bold,
            ),
            recognizer: page,
          ),
        ],
      ),
    );
  }

  Widget _socialAccount({
    String? text, 
    String? image, 
   required VoidCallback callBack,
    }
    ) {
    return Expanded(
      child: GestureDetector(
        onTap: callBack,
        child: Container(
          margin: EdgeInsets.all(13),
          padding: EdgeInsets.symmetric(horizontal: 14),
          height: 50,
          decoration: BoxDecoration(
            color: AppColors.white,
            border: BoxBorder.all(width: 1, color: AppColors.borderColor),
        
            borderRadius: BorderRadius.circular(25),
          ),
          child: Row(
            children: [
              Image.asset(
                image!,
                fit: BoxFit.cover,
                height: 30,
                width: 30,
                errorBuilder: (context, e, stackTrace) {
                  debugPrint("Image Error : $e");
                  return Icon(Icons.error, color: Colors.red);
                },
              ),
        
              const SizedBox(width: 9),
        
              Expanded(
                child: Text(
                  text!,
                  style: TextStyle(fontSize: 18, color: AppColors.textColors),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
