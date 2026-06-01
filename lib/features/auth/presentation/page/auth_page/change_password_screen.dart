import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_firbase_project/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:test_firbase_project/features/auth/presentation/bloc/auth_event.dart';
import 'package:test_firbase_project/features/auth/presentation/bloc/auth_state.dart';
import 'package:test_firbase_project/features/auth/presentation/page/utilitis/colors.dart';
import 'package:test_firbase_project/features/auth/presentation/widgets/reusable_circular_progress.dart';
import 'package:test_firbase_project/features/auth/presentation/widgets/reusable_snackbar.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ForgetScreen();
}

class _ForgetScreen extends State<ChangePasswordScreen> {
  final TextEditingController _currentPasswordControler =
      TextEditingController();
  final TextEditingController _newPasswordControler = TextEditingController();
  final TextEditingController _confirmPasswordControler =
      TextEditingController();
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  final user = FirebaseAuth.instance.currentUser!;

  @override
  void dispose() {
    _currentPasswordControler.dispose();
    _newPasswordControler.dispose();
    _confirmPasswordControler.dispose();
    super.dispose();
  }

  void clearFormField() {
    _currentPasswordControler.clear();
    _newPasswordControler.clear();
    _confirmPasswordControler.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Form(
          key: _globalKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 90),

                Text(
                  "Mahfuz Developer",
                  style: TextTheme.of(context).titleLarge,
                ),

                const SizedBox(height: 120),

                TextFormField(
                  controller: _currentPasswordControler,
                  decoration: InputDecoration(labelText: "Current Password"),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "Please Enter Current Password";
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 20),

                TextFormField(
                  controller: _newPasswordControler,
                  decoration: InputDecoration(labelText: "New Password"),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "Please Enter New Password";
                    }
                    if (value.length < 6) {
                      return "Minimum 6 Digit";
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 20),

                TextFormField(
                  controller: _confirmPasswordControler,
                  decoration: InputDecoration(labelText: "Confirm Password"),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "Please Enter Confirm Password";
                    }
                    if (value != _newPasswordControler.text) {
                      return "New Password Not Match";
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 20),


                BlocConsumer<AuthBloc, AuthState>(
                listener: (context, state){
                  if(state is PasswordVerifyState) {

                   if(context.mounted){
                     Navigator.pop(context);
                      AppSnackbar.snackBar(
                      context, 
                      "Password Change Successful",
                    );
                     
                   }
                  } else if(state is ErrorRequest) {
                     AppSnackbar.snackBar(
                      context, 
                      state.message.toString(),
                    );
                  }
                },

                builder: (context, state){

                  return ElevatedButton(
                   onPressed: state is AuthProgress ? null : () {
                    if (!_globalKey.currentState!.validate()) return;

                   // clearFormField();

                     context.read<AuthBloc>().add(PasswordUpdateEvent(
                      currentPassword: _currentPasswordControler.text , 
                      newPassword: _newPasswordControler.text));
                  },
                  child: state is AuthProgress? 
                    SizedBox(
                      height: 30,
                      width: 30,
                      child: cirularProgressIndicator(), // loader থামছে নাহ
                    )   : Text("Confirm"),
                );

                },
              ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
