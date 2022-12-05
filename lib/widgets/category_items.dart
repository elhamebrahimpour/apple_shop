import 'package:apple_shop/constants/app_colors.dart';
import 'package:flutter/material.dart';

class CategoryItems extends StatelessWidget {
  const CategoryItems({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 12),
      child: Column(
        children: [
          Stack(
            alignment: AlignmentDirectional.center,
            children: [
              Container(
                height: 56,
                width: 56,
                decoration: ShapeDecoration(
                  color: AppColors.blueColor,
                  shape: ContinuousRectangleBorder(
                    borderRadius: BorderRadius.circular(46),
                  ),
                  shadows: const [
                    BoxShadow(
                      color: AppColors.blueColor,
                      blurRadius: 20,
                      spreadRadius: -8,
                      offset: Offset(0.0, 6),
                    )
                  ],
                ),
              ),
              const Icon(
                Icons.ads_click,
                color: AppColors.whiteColor,
                size: 32,
              ),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          const Text('همه'),
        ],
      ),
    );
  }
}
