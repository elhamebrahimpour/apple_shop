import 'package:apple_shop/features/utils/constants/app_colors.dart';
import 'package:flutter/material.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.backColor,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.error,
                size: 42,
                color: AppColors.redColor,
              ),
              SizedBox(
                height: 18,
              ),
              Text(
                'Connection Error!',
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'sb',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
