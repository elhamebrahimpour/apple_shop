import 'package:apple_shop/utils/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';

class LoadingAnimation extends StatelessWidget {
  const LoadingAnimation({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SizedBox(
        height: 80,
        width: 80,
        child: LoadingIndicator(
          indicatorType: Indicator.ballSpinFadeLoader,
          colors: [AppColors.blueColor],
          strokeWidth: 1,
        ),
      ),
    );
  }
}
