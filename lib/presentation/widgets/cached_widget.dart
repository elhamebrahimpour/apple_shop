import 'package:apple_shop/core/constants/app_colors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ImageCachedWidget extends StatelessWidget {
  ImageCachedWidget({Key? key, required this.imageUrl, this.radius = 0.0})
      : super(key: key);
  String? imageUrl;
  double radius;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: CachedNetworkImage(
        imageUrl: imageUrl!,
        fit: BoxFit.fill,
        placeholder: (context, url) => Container(
          color: AppColors.greyColor,
        ),
        errorWidget: (context, url, error) => Container(
          decoration: BoxDecoration(
            color: AppColors.blueColor,
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
    );
  }
}
