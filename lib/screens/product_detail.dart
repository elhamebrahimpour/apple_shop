import 'dart:ui';

import 'package:apple_shop/constants/app_colors.dart';
import 'package:flutter/material.dart';

class ProductDetail extends StatelessWidget {
  const ProductDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backColor,
      body: SafeArea(
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: getScrollableSection(),
        ),
      ),
    );
  }

  Widget getScrollableSection() {
    return CustomScrollView(
      slivers: [
        const SliverToBoxAdapter(
          child: SingleProductAppbar(),
        ),
        const SliverToBoxAdapter(
          child: Text(
            'آیفون 13 پرومکس',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.blackColor,
              fontFamily: 'sb',
              fontSize: 16,
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: getProductImageBox(),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.only(right: 22),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'انتخاب رنگ',
                  style: TextStyle(
                    color: AppColors.blackColor,
                    fontFamily: 'sb',
                    fontSize: 12,
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                SizedBox(
                  height: 20,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 3,
                    itemBuilder: ((context, index) => Container(
                          margin: const EdgeInsets.only(left: 12),
                          height: 20,
                          width: 20,
                          decoration: BoxDecoration(
                            color: AppColors.redColor,
                            borderRadius: BorderRadius.circular(6),
                          ),
                        )),
                  ),
                ),
              ],
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.only(right: 22),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 12,
                ),
                const Text(
                  'انتخاب حافظه داخلی',
                  style: TextStyle(
                    color: AppColors.blackColor,
                    fontFamily: 'sb',
                    fontSize: 12,
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                SizedBox(
                  height: 30,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 3,
                    itemBuilder: ((context, index) => Container(
                          margin: const EdgeInsets.only(left: 12),
                          width: 60,
                          decoration: BoxDecoration(
                            color: AppColors.whiteColor,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                                width: 2, color: AppColors.blueColor),
                          ),
                          child: const Center(
                            child: Text(
                              '512',
                              style: TextStyle(
                                color: AppColors.blackColor,
                                fontFamily: 'sb',
                                fontSize: 12,
                              ),
                            ),
                          ),
                        )),
                  ),
                ),
              ],
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Container(
            margin: const EdgeInsets.only(top: 22, left: 22, right: 22),
            padding: const EdgeInsets.symmetric(horizontal: 16),
            height: 46,
            decoration: BoxDecoration(
              color: AppColors.whiteColor,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(width: 1, color: AppColors.greyColor),
            ),
            child: Row(
              children: [
                const Text(
                  'مشخصات فنی: ',
                  style: TextStyle(
                    color: AppColors.blackColor,
                    fontFamily: 'sb',
                    fontSize: 14,
                  ),
                ),
                const Spacer(),
                const Text(
                  'مشاهده ',
                  style: TextStyle(
                    color: AppColors.blueColor,
                    fontFamily: 'sb',
                    fontSize: 12,
                  ),
                ),
                const SizedBox(
                  width: 6,
                ),
                Image.asset('images/icon_left_categroy.png')
              ],
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Container(
            margin: const EdgeInsets.only(top: 22, left: 22, right: 22),
            padding: const EdgeInsets.symmetric(horizontal: 16),
            height: 46,
            decoration: BoxDecoration(
              color: AppColors.whiteColor,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(width: 1, color: AppColors.greyColor),
            ),
            child: Row(
              children: [
                const Text(
                  'توضیحات محصول: ',
                  style: TextStyle(
                    color: AppColors.blackColor,
                    fontFamily: 'sb',
                    fontSize: 14,
                  ),
                ),
                const Spacer(),
                const Text(
                  'مشاهده ',
                  style: TextStyle(
                    color: AppColors.blueColor,
                    fontFamily: 'sb',
                    fontSize: 12,
                  ),
                ),
                const SizedBox(
                  width: 6,
                ),
                Image.asset('images/icon_left_categroy.png')
              ],
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: getUsersOpinion(),
        ),
        //button's section
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 22),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                AddToCartButton(),
                ProductPriceTag(),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget getUsersOpinion() {
    return Container(
      margin: const EdgeInsets.only(top: 22, left: 22, right: 22),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      height: 46,
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(width: 1, color: AppColors.greyColor),
      ),
      child: Row(
        children: [
          const Text(
            'نظرات کاربران: ',
            style: TextStyle(
              color: AppColors.blackColor,
              fontFamily: 'sb',
              fontSize: 14,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                height: 26,
                width: 26,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  color: AppColors.greyColor,
                ),
              ),
              Positioned(
                right: 15,
                child: Container(
                  height: 26,
                  width: 26,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: AppColors.greenColor,
                  ),
                ),
              ),
              Positioned(
                right: 30,
                child: Container(
                  height: 26,
                  width: 26,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: AppColors.greyColor,
                  ),
                  child: const Center(
                    child: Text(
                      '+10',
                      style: TextStyle(
                        color: AppColors.whiteColor,
                        fontFamily: 'sb',
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
          const Spacer(),
          const Text(
            'مشاهده ',
            style: TextStyle(
              color: AppColors.blueColor,
              fontFamily: 'sb',
              fontSize: 12,
            ),
          ),
          const SizedBox(
            width: 6,
          ),
          Image.asset('images/icon_left_categroy.png')
        ],
      ),
    );
  }

  Widget getProductImageBox() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 22, vertical: 22),
      height: 284,
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Column(
          children: [
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset('images/icon_favorite_deactive.png'),
                  Expanded(
                    child: Image.asset('images/iphone.png'),
                  ),
                  const Text(
                    '2.4',
                    style: TextStyle(
                      color: AppColors.blackColor,
                      fontFamily: 'sm',
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(
                    width: 3,
                  ),
                  Image.asset('images/icon_star.png'),
                ],
              ),
            ),
            SizedBox(
              height: 90,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 3,
                itemBuilder: ((context, index) {
                  return Container(
                    padding: const EdgeInsets.only(top: 6, bottom: 6),
                    margin: const EdgeInsets.only(left: 12),
                    height: 90,
                    width: 90,
                    decoration: BoxDecoration(
                      border: Border.all(width: 2, color: AppColors.greyColor),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Image.asset('images/iphone.png'),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProductPriceTag extends StatelessWidget {
  const ProductPriceTag({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        Container(
          height: 60,
          width: 140,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: AppColors.greenColor,
          ),
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
            child: SizedBox(
              height: 53,
              width: 160,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: AppColors.redColor,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 2, horizontal: 5),
                        child: Text(
                          '%3',
                          style: TextStyle(
                              fontFamily: 'sb',
                              color: AppColors.whiteColor,
                              fontSize: 10),
                        ),
                      ),
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
                          fontSize: 12),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class AddToCartButton extends StatelessWidget {
  const AddToCartButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        Container(
          height: 60,
          width: 140,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: AppColors.blueColor,
          ),
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
            child: const SizedBox(
              height: 53,
              width: 160,
              child: Center(
                child: Text(
                  'افزودن به سبد خرید',
                  style: TextStyle(
                    color: AppColors.whiteColor,
                    fontFamily: 'sb',
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}

class SingleProductAppbar extends StatelessWidget {
  const SingleProductAppbar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 22, left: 22, bottom: 26, top: 6),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        height: 46,
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          children: [
            Image.asset('images/icon_back.png'),
            const Expanded(
              child: Text(
                'آیفون',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.blueColor,
                  fontFamily: 'sb',
                  fontSize: 16,
                ),
              ),
            ),
            Image.asset('images/icon_apple_blue.png'),
          ],
        ),
      ),
    );
  }
}
