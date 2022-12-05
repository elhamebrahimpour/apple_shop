import 'package:apple_shop/constants/app_colors.dart';
import 'package:apple_shop/screens/product_detail.dart';
import 'package:flutter/material.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: ((context) => const ProductDetail()),
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
                Expanded(
                  child: Container(),
                ), //width:double.infinity
                Image.asset('images/iphone.png'),
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
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 2, horizontal: 5),
                      child: Text(
                        '%3',
                        style: TextStyle(
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
            const Padding(
              padding: EdgeInsets.only(right: 10, bottom: 6, top: 10),
              child: Text(
                'آیفون 13 پرومکس',
                style: TextStyle(
                    fontFamily: 'sm',
                    color: AppColors.blackColor,
                    fontSize: 14),
              ),
            ),
            //price container handled
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
                      children: const [
                        Text(
                          '46.800.000',
                          style: TextStyle(
                              fontFamily: 'sm',
                              color: AppColors.whiteColor,
                              fontSize: 12,
                              decoration: TextDecoration.lineThrough),
                        ),
                        Text(
                          '45.000.000',
                          style: TextStyle(
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
