import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:test_firbase_project/features/auth/presentation/page/auth_page/wrapper_class.dart';
import 'package:test_firbase_project/features/auth/presentation/page/utilitis/colors.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      theme: lightTheme(),
      darkTheme: ThemeData.dark(),
      home: const WrapperScreen(),
    );

  }

     





  ThemeData lightTheme() {
    return ThemeData(
      textTheme: TextTheme(
        titleLarge: TextStyle(
          fontSize: 30,
          color: AppColors.navieBlurolors,
          fontWeight: FontWeight.bold,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          foregroundColor: AppColors.white,
          backgroundColor: AppColors.navieBlurolors,
          shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),),
          elevation: 5,
          maximumSize: Size(double.infinity, 55),
        ),
      ),
      inputDecorationTheme: InputDecorationThemeData(
        fillColor: AppColors.containerColor,
        filled: true,
        labelStyle: TextStyle(color: AppColors.textColors),
        border: OutlineInputBorder(borderSide: BorderSide.none),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.navieBlurolors),
        ),
      ),
       iconTheme: IconThemeData(
        color: AppColors.iconColors
       )
    );
  }
}
