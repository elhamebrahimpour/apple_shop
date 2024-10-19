import 'package:apple_shop/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

class Messenger {
  static void showErrorMessenger(BuildContext context, String errorString) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          errorString,
          style: const TextStyle(
            fontSize: 14,
            fontFamily: 'sm',
          ),
        ),
        behavior: SnackBarBehavior.floating,
        backgroundColor: AppColors.blackColor,
        duration: const Duration(seconds: 1),
      ),
    );
  }
}
