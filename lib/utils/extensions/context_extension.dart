import 'package:flutter/material.dart';

extension PushReplacementScreen on BuildContext {
  navigateToScreen(Widget destinationScreen) {
    Navigator.pushReplacement(
      this,
      MaterialPageRoute(
        builder: (context) {
          return destinationScreen;
        },
      ),
    );
  }
}
