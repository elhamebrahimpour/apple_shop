import 'package:apple_shop/constants/app_colors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CachedWidget extends StatelessWidget {
  CachedWidget({Key? key, required this.imageUrl}) : super(key: key);
  String? imageUrl;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: CachedNetworkImage(
        imageUrl: imageUrl!,
        fit: BoxFit.fill,
        placeholder: (context, url) => Container(
          color: AppColors.greyColor,
        ),
        errorWidget: (context, url, error) => Container(
          color: AppColors.redColor,
        ),
      ),
    );
  }
}
