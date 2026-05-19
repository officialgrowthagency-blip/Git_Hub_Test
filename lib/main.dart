import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_firbase_project/features/auth/data/data_source.dart';
import 'package:test_firbase_project/features/auth/data/repositories_impl.dart';
import 'package:test_firbase_project/features/auth/domain/usecase.dart';
import 'package:test_firbase_project/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:test_firbase_project/firebase_options.dart';
import 'package:test_firbase_project/my_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  final dataSource = FirbaseAuthService();
  final repo = FirbaseRepository(dataSource);
  final useCase = UserAuthCase(repo);

  runApp(

   MultiBlocProvider(
    providers: [
    BlocProvider(create: (context) => AuthBloc(useCase)),
    //BlocProvider(create: (context)=> AuthBloc(useCase)),
   ], 
   child: const MyApp()
   ),   
  );
}
   
    