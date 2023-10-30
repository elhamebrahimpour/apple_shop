import 'package:apple_shop/utils/constants/app_colors.dart';
import 'package:flutter/material.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.backColor,
      body: SafeArea(
        child: Column(
          children: [
            Text('401'),
            Text('You don\'t have an access to this page'),
          ],
        ),
      ),
    );
  }
}
