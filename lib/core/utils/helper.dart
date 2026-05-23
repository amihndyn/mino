import 'package:flutter/material.dart';

class Helper {
  // HIDE KEYBOARD
  static void hideKeyboard(
    BuildContext context,
  ) {
    FocusScope.of(context).unfocus();
  }

  // SCREEN WIDTH
  static double screenWidth(
    BuildContext context,
  ) {
    return MediaQuery.of(context).size.width;
  }

  // SCREEN HEIGHT
  static double screenHeight(
    BuildContext context,
  ) {
    return MediaQuery.of(context).size.height;
  }

  // SHOW SNACKBAR
  static void showSnackBar(
    BuildContext context,
    String message,
  ) {
    ScaffoldMessenger.of(context)
        .showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }
}