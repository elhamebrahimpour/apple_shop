import 'package:apple_shop/constants/app_colors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

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
          color: AppColors.redColor,
        ),
      ),
    );
  }
}
