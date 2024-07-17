import 'package:flutter/material.dart';
import 'package:weather_app/styles/colors.dart';

class Messenger {
  static success({
    required BuildContext context,
    required String message,
  }) {
    snackBar(
      context: context,
      message: message,
      backgroundColor: Colors.green,
    );
  }

  static error({
    required BuildContext context,
    required String message,
  }) {
    snackBar(
      context: context,
      message: message,
      backgroundColor: AppColors.error,
    );
  }

  static info({
    required BuildContext context,
    required String message,
  }) {
    snackBar(
      context: context,
      message: message,
      backgroundColor: Colors.black,
    );
  }

  static snackBar({
    required BuildContext context,
    required String message,
    required Color backgroundColor,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: backgroundColor,
      ),
    );
  }
}
