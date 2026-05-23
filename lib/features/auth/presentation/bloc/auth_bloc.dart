import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_firbase_project/features/auth/domain/usecase.dart';
import 'package:test_firbase_project/features/auth/presentation/bloc/auth_event.dart';
import 'package:test_firbase_project/features/auth/presentation/bloc/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserAuthCase userAuthCase;

  AuthBloc(this.userAuthCase) : super(AuthInit()) {
    on<FetchAuthEvent>((event, emit) async {
      emit(AuthProgress());

      try {
        final userData = await userAuthCase.login(event.user);

        emit(UserAuthorized(user: userData));
      } catch (e) {
        emit(ErrorRequest(e.toString()));
      }
    });

    on<FetchSignAuthEvent>((event, emit) async {
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

        emit(VerifyState());
      } on FirebaseAuthException catch (e) {
        debugPrint("Error - $e");

        emit(ErrorRequest(e.toString()));
      }
    });

    on<GetFireStoreDataEvent>((event, emit) async {
      emit(AuthProgress());

      try {
        final data = await userAuthCase.getUserData(uid: event.uid);

        if(data != null) {

         emit(UserAuthorized(user: data));

        } else {
           
           emit(UserUnAuthorized());
        }

        

      } catch (e) {
        emit(ErrorRequest(e.toString()));
      }
    });
  }
}
