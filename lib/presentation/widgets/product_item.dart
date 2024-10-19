import 'package:apple_shop/business/bloc/shopping_card/card_bloc.dart';
import 'package:apple_shop/core/constants/app_colors.dart';
import 'package:apple_shop/data/model/product.dart';
import 'package:apple_shop/di/api_di.dart';
import 'package:apple_shop/presentation/screens/product_detail.dart';
import 'package:apple_shop/core/utils/extensions/int_extension.dart';
import 'package:apple_shop/presentation/widgets/cached_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductItem extends StatelessWidget {
  const ProductItem(this.product, {Key? key}) : super(key: key);
  final Product product;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: ((context) => BlocProvider.value(
                value: serviceLocator.get<CardBloc>(),
                child: ProductDetailScreen(product),
              )),
        ),
      ),
      child: Container(
        height: 216,
        width: 160,
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 10,
            ),
            Stack(
              alignment: AlignmentDirectional.center,
              children: [
                /*  Expanded(
                  child: Container(),
                ),*/
                const SizedBox(width: double.infinity),
                SizedBox(
                    height: 91,
                    width: 91,
                    child: ImageCachedWidget(imageUrl: product.thumbnail)),
                Positioned(
                  top: 0,
                  right: 8,
                  child: Image.asset('images/active_fav_product.png'),
                ),
                Positioned(
                  bottom: 10,
                  left: 8,
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.redColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 2, horizontal: 5),
                      child: Text(
                        '%${product.percent!.round()}',
                        style: const TextStyle(
                            fontFamily: 'sb',
                            color: AppColors.whiteColor,
                            fontSize: 12),
                      ),
                    ),
                  ),
                )
              ],
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.only(right: 10, bottom: 6, top: 10),
              child: Text(
                product.name,
                maxLines: 2,
                style: const TextStyle(
                    fontFamily: 'sm',
                    color: AppColors.blackColor,
                    fontSize: 12,
                    overflow: TextOverflow.ellipsis),
              ),
            ),
            //price container
            Container(
              height: 53,
              decoration: const BoxDecoration(
                color: AppColors.blueColor,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15),
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.blueColor,
                    blurRadius: 25,
                    spreadRadius: -7,
                    offset: Offset(0.0, 15),
                  )
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Row(
                  children: [
                    Image.asset(
                      'images/icon_right_arrow_cricle.png',
                      height: 24,
                      width: 24,
                    ),
                    const Spacer(),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          product.price.convertToPrice(),
                          style: const TextStyle(
                              fontFamily: 'sm',
                              color: AppColors.whiteColor,
                              fontSize: 12,
                              decoration: TextDecoration.lineThrough),
                        ),
                        Text(
                          product.realPrice.convertToPrice(),
                          style: const TextStyle(
                              fontFamily: 'sm',
                              color: AppColors.whiteColor,
                              fontSize: 14),
                        ),
                      ],
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    const Text(
                      'تومان',
                      style: TextStyle(
                          fontFamily: 'sm',
                          color: AppColors.whiteColor,
                          fontSize: 14),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
