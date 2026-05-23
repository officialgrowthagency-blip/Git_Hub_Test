import 'package:flutter/material.dart';

class AppSnackbar {
 static void snackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }
}
