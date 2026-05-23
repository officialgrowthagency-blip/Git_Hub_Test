import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_firbase_project/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:test_firbase_project/features/auth/presentation/bloc/auth_event.dart';
import 'package:test_firbase_project/features/auth/presentation/bloc/auth_state.dart';
import 'package:test_firbase_project/features/auth/presentation/page/auth_page/login_screen.dart';
import 'package:test_firbase_project/features/auth/presentation/page/home_screen.dart';
import 'package:test_firbase_project/features/auth/presentation/widgets/reusable_circular_progress.dart';

class WrapperScreen extends StatelessWidget {
  const WrapperScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return cirularProgressIndicator();
        }

        if (snapshot.hasData && snapshot.data != null) {
          context.read<AuthBloc>().add(
            GetFireStoreDataEvent(uid: snapshot.data!.uid),
          );

          return BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              if (state is AuthProgress) {
                return cirularProgressIndicator();
              }
              if (state is UserAuthorized) {
                return HomeScreen(userData: state.user);
              }

              return LoginScreen();
            },
          );
        }
        return LoginScreen();
      },
    );
  }
}
