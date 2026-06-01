import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_firbase_project/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:test_firbase_project/features/auth/presentation/bloc/auth_event.dart';
import 'package:test_firbase_project/features/auth/presentation/bloc/auth_state.dart';
import 'package:test_firbase_project/features/auth/presentation/page/auth_page/login_screen.dart';
import 'package:test_firbase_project/features/auth/presentation/page/home_screen.dart';
import 'package:test_firbase_project/features/auth/presentation/page/utilitis/colors.dart';
import 'package:test_firbase_project/features/auth/presentation/widgets/reusable_circular_progress.dart';

class WrapperScreen extends StatefulWidget {
  const WrapperScreen({super.key});

  @override
  State<WrapperScreen> createState() => _WrapperScreenState();
}

class _WrapperScreenState extends State<WrapperScreen> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return cirularProgressIndicator();
        }

        if (snapshot.hasData && snapshot.data != null) {
          return BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              if (state is AuthInit) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  context.read<AuthBloc>().add(
                    GetFireStoreDataEvent(uid: snapshot.data!.uid),
                  );
                });
              }

              if (state is AuthProgress) {
                return Scaffold(
                  backgroundColor: AppColors.white,

                  body: cirularProgressIndicator(),
                );
              }
              if (state is UserAuthorized) {
                return HomeScreen(userData: state.user);
              }

              return const LoginScreen();
            },
          );
        }
        return LoginScreen();
      },
    );
  }
}
