import 'package:apple_shop/bloc/product_category/product_category_bloc.dart';
import 'package:apple_shop/utils/constants/app_colors.dart';
import 'package:apple_shop/data/model/category.dart';
import 'package:apple_shop/di/api_di.dart';
import 'package:apple_shop/screens/products_screen.dart';
import 'package:apple_shop/utils/extensions/string_extension.dart';
import 'package:apple_shop/widgets/cached_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryItemChip extends StatelessWidget {
  const CategoryItemChip(this.category, {Key? key}) : super(key: key);
  final Category category;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: ((context) => BlocProvider(
                create: (context) => ProductCategoryBloc(serviceLocator.get()),
                child: ProductsListScreen(category),
              )),
        ),
      ),
      child: Padding(
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
                    color: category.color.parseToColor(),
                    shape: ContinuousRectangleBorder(
                      borderRadius: BorderRadius.circular(46),
                    ),
                    shadows: [
                      BoxShadow(
                        color: category.color.parseToColor(),
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
      ),
    );
  }
}
