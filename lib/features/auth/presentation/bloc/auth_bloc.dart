import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_firbase_project/features/auth/domain/entity.dart';
import 'package:test_firbase_project/features/auth/domain/usecase.dart';
import 'package:test_firbase_project/features/auth/presentation/bloc/auth_event.dart';
import 'package:test_firbase_project/features/auth/presentation/bloc/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserAuthCase userAuthCase;

  AuthBloc(this.userAuthCase) : super(AuthInit()) {
    on<LoginEmailEvent>((event, emit) async {
      emit(AuthProgress());

      try {
        final data = await userAuthCase.login(event.user);

        emit(
          UserAuthorized(
            user: AuthenticatedUser(
              uid: data.uid,
              email: data.email,
              name: data.name,
              image: data.image,
              provider: "email",
            ),
          ),
        );
      } catch (e) {
        emit(ErrorRequest(e.toString()));
      }
    });

    on<SignUpEmailEvent>((event, emit) async {
      emit(AuthProgress());
      try {
        final userSign = await userAuthCase.signUp(event.user!);
        emit(UserAuthorized(user: userSign));
      } on FirebaseAuthException catch (e) {
        emit(ErrorRequest(e.toString()));
      }
    });

    on<LogOutEvent>((event, emit) async {
      emit(AuthProgress());

      try {
        await userAuthCase.logOut();

        emit(UserUnAuthorized());
      } catch (e) {
        emit(ErrorRequest(e.toString()));
      }
    });

    on<PasswordUpdateEvent>((event, emit) async {
      debugPrint("Auth Start");
      emit(AuthProgress());

      try {
        await userAuthCase.updatePassword(
          curentPassword: event.currentPassword,
          password: event.newPassword,
        );
        debugPrint("Auth Success");

        emit(PasswordVerifyState());
      } on FirebaseAuthException catch (e) {
        debugPrint("Error - $e");

        emit(ErrorRequest(e.toString()));
      }
    });

    on<ShowPasswordEvent>((event, emit) {
      try {
        if (state is PasswordShowState) {
          final currentState = state as PasswordShowState;

          emit(
            PasswordShowState(obsecurePassword: !currentState.obsecurePassword),
          );
        } else {
    emit(
      PasswordShowState(obsecurePassword: false
        
      ),
    );
  }
      } catch (e) {
        emit(ErrorRequest(e.toString()));
      }
    });

    on<GetFireStoreDataEvent>((event, emit) async {
      emit(AuthProgress());

      try {
        final data = await userAuthCase.getUserData(uid: event.uid);

        if (data != null) {
          emit(UserAuthorized(user: data));
        } else {
          emit(UserUnAuthorized());
        }
      } catch (e) {
        emit(ErrorRequest(e.toString()));
      }
    });

    on<GoogleSignEvent>((event, emit) async {
      try {
        final data = await userAuthCase.googleSign();

        // if(data == null)

        emit(
          UserAuthorized(
            user: AuthenticatedUser(
              uid: data.uid,
              email: data.email,
              name: data.name,
              image: data.image,
              provider: "google",
            ),
          ),
        );
      } catch (e) {
        emit(ErrorRequest(e.toString()));
      }
    });
  }
}
