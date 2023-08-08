import 'package:apple_shop/utils/constants/app_colors.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar(
      {Key? key, required this.title, required this.searchIconVisibility})
      : super(key: key);
  final String title;
  final bool searchIconVisibility;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 22, left: 22, bottom: 26, top: 6),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        height: 46,
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          children: [
            Visibility(
              visible: searchIconVisibility,
              child: Image.asset('images/icon_search.png'),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Text(
                title,
                textAlign:
                    searchIconVisibility ? TextAlign.start : TextAlign.center,
                style: TextStyle(
                  color: searchIconVisibility
                      ? AppColors.greyColor
                      : AppColors.blueColor,
                  fontFamily: 'sb',
                  fontSize: 16,
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Image.asset('images/icon_apple_blue.png'),
          ],
        ),
      ),
    );
  }
}
