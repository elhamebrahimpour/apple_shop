import 'package:apple_shop/utils/constants/app_colors.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController textEditingController;
  final String fieldString;
  final bool isPassword;
  const CustomTextField({
    super.key,
    required this.textEditingController,
    required this.fieldString,
    this.isPassword = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          fieldString,
          style: const TextStyle(
            color: AppColors.blackColor,
            fontSize: 14,
            fontFamily: 'sm',
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        Container(
          padding: const EdgeInsets.only(right: 8),
          decoration: BoxDecoration(
            color: AppColors.greyColor.withOpacity(0.2),
          ),
          child: TextField(
            controller: textEditingController,
            obscureText: isPassword ? true : false,
            enableSuggestions: isPassword ? false : true,
            autocorrect: isPassword ? false : true,
            decoration: const InputDecoration(
              border: InputBorder.none,
            ),
          ),
        ),
      ],
    );
  }
}
