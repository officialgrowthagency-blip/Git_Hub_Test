import 'package:firebase_auth/firebase_auth.dart';
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

        emit(UserAuthorized(user: userData ));
      } catch (e) {
      
        emit(ErrorRequest(e.toString()));
      }
    });

     on<FetchSignAuthEvent>((event, emit) async {
      emit(AuthProgress());
      try {

        final userSign = await userAuthCase.signUp(event.user!); // The argument type 'UserEntity?' can't be assigned to the parameter type 'UserEntity'.

         emit(UserAuthorized(user: userSign));

      } on FirebaseAuthException catch (e) {
        
        emit(ErrorRequest(e.toString()));
      }
     });

     on<LogOutEvent>((event, emit) async {

      emit(AuthProgress());
       
       try {

       userAuthCase.logOut;

        emit(UserUnAuthorized());

       } catch (e) {
          emit(ErrorRequest(e.toString()));
       }
       
     });
  
    on<PasswordUpdateEvent>((event, emit) async {
      emit(AuthProgress());
       
       try {
         await userAuthCase.updatePassword(
          email: event.email, 
          password: event.password,
        );
         emit(VerifyState());

       } on FirebaseAuthException catch (e){
          ErrorRequest(e.toString());
       }
    });
  }
}
