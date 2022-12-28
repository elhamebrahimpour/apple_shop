import 'package:apple_shop/constants/app_colors.dart';
import 'package:apple_shop/widgets/custom_appbar.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';

class ShoppingCartScreen extends StatelessWidget {
  const ShoppingCartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backColor,
      body: SafeArea(
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Stack(
            alignment: AlignmentDirectional.bottomCenter,
            children: [
              CustomScrollView(
                slivers: [
                  const SliverToBoxAdapter(
                    child: CustomAppBar(
                      title: 'سبد خرید',
                      searchIconVisibility: false,
                    ),
                  ),
                  SliverPadding(
                    padding: const EdgeInsets.only(bottom: 80),
                    sliver: SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          return const CartItem();
                        },
                        childCount: 6,
                      ),
                    ),
                  )
                ],
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 22, vertical: 22),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 52,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.greenColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    onPressed: () {},
                    child: const Text(
                      'ادامه فرآیند خرید',
                      style: TextStyle(
                        fontFamily: 'sm',
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CartItem extends StatelessWidget {
  const CartItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 22, right: 22, bottom: 22),
      height: 255,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          Expanded(
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Image.asset('images/iphone.png'),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'آیفون 13 پرومکس دو سیم کارت',
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: AppColors.blackColor,
                            fontFamily: 'sb',
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        const Text(
                          'گارانتی 18 ماه مدیا پردازش',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: AppColors.greyColor,
                            fontFamily: 'sb',
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Row(
                          children: [
                            const Text(
                              '46.800.000',
                              style: TextStyle(
                                fontFamily: 'sm',
                                color: AppColors.greyColor,
                                fontSize: 14,
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            const Text(
                              'تومان',
                              style: TextStyle(
                                  fontFamily: 'sm',
                                  color: AppColors.greyColor,
                                  fontSize: 12),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: AppColors.redColor,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: const Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 2, horizontal: 5),
                                child: Text(
                                  '%3',
                                  style: TextStyle(
                                      fontFamily: 'sb',
                                      color: AppColors.whiteColor,
                                      fontSize: 10),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Wrap(
                          spacing: 12,
                          runSpacing: 6,
                          children: const [
                            OptionsCheap(),
                            OptionsCheap(),
                            OptionsCheap(),
                            OptionsCheap(),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: DottedLine(
              direction: Axis.horizontal,
              lineThickness: 1.5,
              dashLength: 8.0,
              dashColor: AppColors.greyColor.withOpacity(0.3),
              dashGapLength: 4.0,
              dashGapColor: Colors.transparent,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 20, top: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  '45.800.000',
                  style: TextStyle(
                    fontFamily: 'sb',
                    color: AppColors.blackColor,
                    fontSize: 16,
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  'تومان',
                  style: TextStyle(
                      fontFamily: 'sb',
                      color: AppColors.blackColor,
                      fontSize: 14),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class OptionsCheap extends StatelessWidget {
  const OptionsCheap({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: AppColors.greyColor.withOpacity(0.5),
          width: 1,
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('ذخیره'),
            const SizedBox(
              width: 10,
            ),
            Image.asset('images/icon_options.png'),
          ],
        ),
      ),
    );
  }
}
