import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_firbase_project/features/auth/data/data_source.dart';
import 'package:test_firbase_project/features/auth/domain/entity.dart';
import 'package:test_firbase_project/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:test_firbase_project/features/auth/presentation/bloc/auth_event.dart';
import 'package:test_firbase_project/features/auth/presentation/bloc/auth_state.dart';
import 'package:test_firbase_project/features/auth/presentation/page/auth_page/sign_up_screen.dart';
import 'package:test_firbase_project/features/auth/presentation/page/home_screen.dart';
import 'package:test_firbase_project/features/auth/presentation/page/utilitis/colors.dart';
import 'package:test_firbase_project/features/auth/presentation/page/utilitis/regex_validator.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late final TapGestureRecognizer _gestureRecognizer = TapGestureRecognizer()
    ..onTap = () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const SignUpScreen()),
      );
    };

  final TextEditingController _emailControler = TextEditingController();
  final TextEditingController _passwordControler = TextEditingController();
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  final FirbaseAuthService firbaseAuth = FirbaseAuthService();

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Form(
        key: _globalKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 80),

                Center(
                  child: Text(
                    "Sign in",
                    style: TextTheme.of(context).titleLarge,
                  ),
                ),

                const SizedBox(height: 25),

                Row(
                  children: [
                    _socialMediaContainer(
                      "Facebook",
                      "lib/features/assets/facebook.png",
                    ),

                    const SizedBox(width: 20),

                    _socialMediaContainer(
                      "Google",
                      "lib/features/assets/google.png",
                    ),
                  ],
                ),

                const SizedBox(height: 10),

                _orDividerWidget("Or", AppColors.dividerColor),

                const SizedBox(height: 10),

                TextFormField(
                  decoration: InputDecoration(labelText: "Email"),
                  controller: _emailControler,
                  validator: Validator.validEmail,
                ),
                const SizedBox(height: 16),

                TextFormField(
                  decoration: InputDecoration(labelText: "Password"),
                  controller: _passwordControler,
                  validator: Validator.passwordValidator,
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {},
                      child: Text("Forget Password?"),
                    ),
                  ],
                ),

                const SizedBox(height: 10),

                BlocConsumer<AuthBloc, AuthState>(
                  listener: (context, state) {
                    if (state is UserAuthorized) {
                       
                      if(!context.mounted) return;
                      
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (_) => HomeScreen(userData: state.user)),
                      );

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Login Successful")),
                      );
                    } else if (state is ErrorRequest) {
                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(SnackBar(content: Text(state.message ?? 'Login failed')));
                    }
                  },

                  builder: (context, state) {
                   return  ElevatedButton(
                      onPressed: (state is AuthProgress)
                          ? null
                          : () async {
                              if (!_globalKey.currentState!.validate()) return;

                               context.read<AuthBloc>().add(FetchAuthEvent(
                                user: UserEntity(
                                  email: _emailControler.text.trim(), 
                                  password: _passwordControler.text)));
                            },

                      child: Center(
                        child: (state is AuthProgress)
                            ? Center(child: CircularProgressIndicator())
                            : Text(
                                "Login",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                      ),
                    );
                  },
                ),

                const SizedBox(height: 7),

                _stylishRichText(_gestureRecognizer),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _stylishRichText(GestureRecognizer page) {
    return Padding(
      padding: const EdgeInsets.all(17),
      child: RichText(
        text: TextSpan(
          text: "Don't Have Account? ",
          style: TextStyle(color: AppColors.textColors, fontSize: 14),
          children: <TextSpan>[
            TextSpan(
              text: "Sign Up",
              style: TextStyle(
                color: AppColors.navieBlurolors,
                fontWeight: FontWeight.bold,
              ),
              recognizer: page,
            ),
          ],
        ),
      ),
    );
  }

  Widget _orDividerWidget(String text, Color color) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: 50,
        child: Row(
          children: [
            Expanded(child: Container(height: 2, color: color)),
            const SizedBox(width: 7),
            Text(
              text,
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),
            const SizedBox(width: 7),
            Expanded(child: Container(height: 2, color: color)),
          ],
        ),
      ),
    );
  }

  Widget _socialMediaContainer(String text, String image) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.all(13),
        padding: EdgeInsets.symmetric(horizontal: 14),
        height: 50,
        decoration: BoxDecoration(
          color: AppColors.containerColor,

          borderRadius: BorderRadius.circular(13),
        ),
        child: Row(
          children: [
            Image.asset(
              image,
              fit: BoxFit.cover,
              height: 30,
              width: 30,
              errorBuilder: (context, e, stackTrace) {
                return Icon(Icons.error, color: Colors.red);
              },
            ),

            const SizedBox(width: 7),

            Expanded(
              child: Text(
                text,
                style: TextStyle(fontSize: 18, color: AppColors.textColors),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailControler.dispose();
    _passwordControler.dispose();
    _gestureRecognizer.dispose();
    super.dispose();
  }
}
