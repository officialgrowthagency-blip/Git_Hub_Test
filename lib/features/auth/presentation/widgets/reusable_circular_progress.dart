import 'package:flutter/material.dart';

Widget cirularProgressIndicator () {
  return Center(
    child: CircularProgressIndicator(),
  );
}
  
  



 class CenterCircularProgress extends StatelessWidget {
  const CenterCircularProgress({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
