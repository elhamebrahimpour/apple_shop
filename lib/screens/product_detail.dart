import 'dart:ui';
import 'package:apple_shop/bloc/product/product_bloc.dart';
import 'package:apple_shop/constants/app_colors.dart';
import 'package:apple_shop/data/model/product.dart';
import 'package:apple_shop/data/model/product_gallery_image.dart';
import 'package:apple_shop/data/model/product_variants.dart';
import 'package:apple_shop/widgets/cached_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductDetailScreen extends StatefulWidget {
  Product product;
  ProductDetailScreen(this.product, {super.key});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<ProductBloc>(context)
        .add(ProductDetailInitialized(widget.product.id));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductBloc, ProductState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColors.backColor,
          body: SafeArea(
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: CustomScrollView(
                slivers: [
                  if (state is ProductDetailLoadingState) ...{
                    const SliverToBoxAdapter(
                      child: Center(
                        child: CircularProgressIndicator(
                          color: AppColors.blueColor,
                          strokeWidth: 4,
                        ),
                      ),
                    ),
                  } else ...{
                    //get appbar
                    const SliverToBoxAdapter(
                      child: SingleProductAppbar(),
                    ),
                    //get product name
                    const _GetProductName(),
                    //get product image
                    if (state is ProductDetailResponseState) ...{
                      state.productImages.fold(
                        (exception) => SliverToBoxAdapter(
                          child: Center(
                            child: Text(exception),
                          ),
                        ),
                        (productImages) => _GetProductImage(
                            productImages, widget.product.thumbnail),
                      )
                    },
                    //get product color
                    if (state is ProductDetailResponseState) ...{
                      state.productVariants.fold((exception) {
                        return SliverToBoxAdapter(
                          child: Center(
                            child: Text(exception),
                          ),
                        );
                      }, (productVariantList) {
                        for (var typeObject in productVariantList) {
                          print(typeObject.variantTypes.title);

                          for (var variantObject in typeObject.variantList) {
                            print(variantObject.name);
                          }
                        }
                        return _GetProductColor(productVariantList);
                      })
                    },
                    //get product memory
                    const _GetProductMemory(),
                    //get product properties
                    const _GetProductProperties(),
                    //get product descryption
                    const _GetProductDescryption(),
                    //get users opinion
                    const _GetUserOpinion(),
                    //price tag and add to card section
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 22, vertical: 22),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            AddToCartButton(),
                            ProductPriceTag(),
                          ],
                        ),
                      ),
                    ),
                  }
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _GetUserOpinion extends StatelessWidget {
  const _GetUserOpinion({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
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
      ),
    );
  }
}

class _GetProductDescryption extends StatelessWidget {
  const _GetProductDescryption({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
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
    );
  }
}

class _GetProductProperties extends StatelessWidget {
  const _GetProductProperties({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
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
    );
  }
}

class _GetProductMemory extends StatelessWidget {
  const _GetProductMemory({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
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
                        border:
                            Border.all(width: 2, color: AppColors.blueColor),
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
    );
  }
}

class _GetProductColor extends StatelessWidget {
  List<ProductVaraint> productVaraint;
  _GetProductColor(
    this.productVaraint, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(right: 22),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              productVaraint[0].variantTypes.title,
              style: const TextStyle(
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
    );
  }
}

class _GetProductImage extends StatefulWidget {
  List<ProductImage> productImages;
  String defaultProductImageUrl;
  int selectedItemIndex = 0;
  _GetProductImage(this.productImages, this.defaultProductImageUrl, {Key? key})
      : super(key: key);

  @override
  State<_GetProductImage> createState() => _GetProductImageState();
}

class _GetProductImageState extends State<_GetProductImage> {
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 22, vertical: 22),
        height: 320,
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          child: Column(
            children: [
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset('images/icon_favorite_deactive.png'),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 12, right: 12, bottom: 6),
                        child: ImageCachedWidget(
                            imageUrl: (widget.productImages.isEmpty)
                                ? widget.defaultProductImageUrl
                                : widget.productImages[widget.selectedItemIndex]
                                    .imageUrl),
                      ),
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
              //product gallery images
              if (widget.productImages.isNotEmpty) ...{
                SizedBox(
                  height: 90,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: widget.productImages.length,
                    itemBuilder: ((context, index) {
                      return GestureDetector(
                        onTap: () => setState(() {
                          widget.selectedItemIndex = index;
                        }),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 2, vertical: 2),
                          margin: const EdgeInsets.only(left: 12),
                          height: 90,
                          width: 90,
                          decoration: BoxDecoration(
                            border: Border.all(
                                width: 1, color: AppColors.greyColor),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: ImageCachedWidget(
                            imageUrl: widget.productImages[index].imageUrl,
                            radius: 10,
                          ),
                        ),
                      );
                    }),
                  ),
                ),
              }
            ],
          ),
        ),
      ),
    );
  }
}

class _GetProductName extends StatelessWidget {
  const _GetProductName({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SliverToBoxAdapter(
      child: Text(
        'آیفون 13 پرومکس',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: AppColors.blackColor,
          fontFamily: 'sb',
          fontSize: 16,
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
