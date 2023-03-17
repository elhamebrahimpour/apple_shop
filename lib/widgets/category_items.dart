import 'package:apple_shop/constants/app_colors.dart';
import 'package:apple_shop/data/model/category.dart';
import 'package:apple_shop/widgets/cached_widget.dart';
import 'package:flutter/material.dart';

class CategoryItems extends StatelessWidget {
  const CategoryItems(this.category, {Key? key}) : super(key: key);
  final Category category;

  @override
  Widget build(BuildContext context) {
    int hexColor = int.parse('ff${category.color}', radix: 16);
    return Padding(
      padding: const EdgeInsets.only(left: 12),
      child: Column(
        children: [
          Stack(
            alignment: AlignmentDirectional.center,
            children: [
              //get category small box
              Container(
                height: 56,
                width: 56,
                decoration: ShapeDecoration(
                  color: Color(hexColor),
                  shape: ContinuousRectangleBorder(
                    borderRadius: BorderRadius.circular(46),
                  ),
                  shadows: [
                    BoxShadow(
                      color: Color(hexColor),
                      blurRadius: 20,
                      spreadRadius: -8,
                      offset: const Offset(0.0, 6),
                    )
                  ],
                ),
              ),
              //get category icon
              SizedBox(
                height: 28,
                width: 28,
                child: Center(
                  child: ImageCachedWidget(imageUrl: category.icon),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          //get category title
          Text(
            category.title!,
            style: const TextStyle(
              color: AppColors.blackColor,
              fontSize: 12,
              fontFamily: 'sm',
            ),
          ),
        ],
      ),
    );
  }
}
