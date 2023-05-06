import 'package:flutter/material.dart';

//int hexColor = int.parse('ff${category.color}', radix: 16);

extension ColorParsing on String? {
  Color parseToColor() {
    return Color(
      int.parse('ff${this}', radix: 16),
    );
  }
}
