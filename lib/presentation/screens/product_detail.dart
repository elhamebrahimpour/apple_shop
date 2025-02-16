// ignore_for_file: must_be_immutable

import 'dart:ui';

import 'package:apple_shop/business/bloc/comment/comment_bloc.dart';
import 'package:apple_shop/business/bloc/product_details/product_bloc.dart';
import 'package:apple_shop/business/bloc/shopping_card/card_bloc.dart';
import 'package:apple_shop/core/utils/extensions/int_extension.dart';
import 'package:apple_shop/core/utils/extensions/string_extension.dart';
import 'package:apple_shop/data/model/comment.dart';
import 'package:apple_shop/data/model/category.dart';
import 'package:apple_shop/data/model/product.dart';
import 'package:apple_shop/data/model/product_gallery_image.dart';
import 'package:apple_shop/data/model/product_properties.dart';
import 'package:apple_shop/data/model/product_variants.dart';
import 'package:apple_shop/data/model/variant_types.dart';
import 'package:apple_shop/presentation/widgets/cached_widget.dart';
import 'package:apple_shop/presentation/widgets/comment_bottomsheet.dart';
import 'package:apple_shop/presentation/widgets/loading_animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/constants/app_colors.dart';
import '../../data/model/variant.dart';
import '../../di/api_di.dart';

class ProductDetailScreen extends StatefulWidget {
  Product product;
  ProductDetailScreen(this.product, {super.key});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backColor,
      body: BlocProvider(
        create: (context) => ProductBloc(
          serviceLocator.get(),
          serviceLocator.get(),
          serviceLocator.get(),
        )..add(
            ProductDetailInitialized(
                widget.product.id, widget.product.categoryId),
          ),
        child: BlocBuilder<ProductBloc, ProductState>(
          builder: (context, state) {
            if (state is ProductDetailLoadingState) {
              return const LoadingAnimation();
            }
            return SafeArea(
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: CustomScrollView(
                  slivers: [
                    if (state is ProductDetailResponseState) ...{
                      //get single product appbar
                      state.productCategory.fold(
                        (exception) => SliverToBoxAdapter(
                          child: Center(
                            child: Text(exception),
                          ),
                        ),
                        (productCatgeory) =>
                            SingleProductAppbar(productCatgeory),
                      ),

                      //get product name
                      SingleProductName(widget.product.name),

                      //get product images from gallery
                      state.productImages.fold(
                        (exception) => SliverToBoxAdapter(
                          child: Center(
                            child: Text(exception),
                          ),
                        ),
                        (productImages) => SingleProductImage(
                            productImages, widget.product.thumbnail),
                      ),

                      //get product variants
                      state.productVariants.fold(
                        (exception) {
                          return SliverToBoxAdapter(
                            child: Center(
                              child: Text(exception),
                            ),
                          );
                        },
                        (productVariantList) {
                          return VariantContainerGenerator(productVariantList);
                        },
                      ),
                      //get product properties
                      state.productProperties.fold(
                        (exception) => SliverToBoxAdapter(
                          child: Center(
                            child: Text(exception),
                          ),
                        ),
                        (productPropertiesList) =>
                            ProductProperties(productPropertiesList),
                      ),

                      //get product descryption
                      ProductDescryption(widget.product.description),

                      //get users opinion
                      state.comments.fold(
                        (exception) => SliverToBoxAdapter(
                          child: Center(
                            child: Text(exception),
                          ),
                        ),
                        (comments) => GetUserOpinion(
                          parentWidget: widget,
                          comments: comments,
                        ),
                      ),
                      //price tag and add to card section
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 22),
                          child: Divider(
                            thickness: 2,
                            color: AppColors.whiteColor.withOpacity(0.5),
                          ),
                        ),
                      ),
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 22, vertical: 22),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              AddToCartButton(
                                widget.product,
                              ),
                              ProductPriceTag(
                                widget.product,
                              ),
                            ],
                          ),
                        ),
                      ),
                    }
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

//this class generates product variant container
class VariantContainerGenerator extends StatelessWidget {
  final List<ProductVaraint> productVariantList;
  const VariantContainerGenerator(this.productVariantList, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        children: [
          for (var currentProductVaraint in productVariantList) ...{
            if (currentProductVaraint.variantList.isNotEmpty) ...{
              VariantContainerChildGenerator(
                  productVariant: currentProductVaraint),
            }
          }
        ],
      ),
    );
  }
}

//this class generates and shows variantList according to its variantType
class VariantContainerChildGenerator extends StatelessWidget {
  const VariantContainerChildGenerator({Key? key, required this.productVariant})
      : super(key: key);

  final ProductVaraint productVariant;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            productVariant.variantTypes.title,
            style: const TextStyle(
              color: AppColors.blackColor,
              fontFamily: 'sb',
              fontSize: 12,
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          if (productVariant.variantTypes.type == VariantTypesEnum.color) ...{
            ColorVariantWidget(productVariant.variantList),
          },
          if (productVariant.variantTypes.type == VariantTypesEnum.storage) ...{
            StorageVariantWidget(productVariant.variantList),
          },
          const SizedBox(
            height: 12,
          ),
        ],
      ),
    );
  }
}

//this class use to create storageVariant ui as well as show storage data
class StorageVariantWidget extends StatefulWidget {
  final List<Variant> storageVariants;

  const StorageVariantWidget(this.storageVariants, {Key? key})
      : super(key: key);

  @override
  State<StorageVariantWidget> createState() => _StorageVariantWidgetState();
}

class _StorageVariantWidgetState extends State<StorageVariantWidget> {
  int _selectedItemIndex = 0;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 28,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: widget.storageVariants.length,
        itemBuilder: ((context, index) => GestureDetector(
              onTap: () => setState(() {
                _selectedItemIndex = index;
              }),
              child: Container(
                margin: const EdgeInsets.only(left: 12),
                width: 60,
                decoration: BoxDecoration(
                  color: AppColors.whiteColor,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    width: _selectedItemIndex == index ? 2 : 1,
                    color: _selectedItemIndex == index
                        ? AppColors.blueColor
                        : AppColors.greyColor,
                  ),
                ),
                child: Center(
                  child: Text(
                    widget.storageVariants[index].value,
                    style: const TextStyle(
                      color: AppColors.blackColor,
                      fontFamily: 'sb',
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
            )),
      ),
    );
  }
}

//this class use to create colorVariant ui as well as show color data
class ColorVariantWidget extends StatefulWidget {
  final List<Variant> colorVariants;
  const ColorVariantWidget(this.colorVariants, {Key? key}) : super(key: key);

  @override
  State<ColorVariantWidget> createState() => _ColorVariantWidgetState();
}

class _ColorVariantWidgetState extends State<ColorVariantWidget> {
  double containerWidth = 24;
  int selectedItemIndex = 0;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 20,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: widget.colorVariants.length,
        itemBuilder: ((context, index) {
          return GestureDetector(
            onTap: () => setState(() {
              selectedItemIndex = index;
            }),
            child: Container(
              margin: const EdgeInsets.only(left: 12),
              width: selectedItemIndex == index
                  ? containerWidth + 12
                  : containerWidth,
              decoration: BoxDecoration(
                color: widget.colorVariants[index].value.parseToColor(),
                borderRadius: BorderRadius.circular(6),
                border: Border.all(
                  strokeAlign: BorderSide.strokeAlignOutside,
                  color: selectedItemIndex == index
                      ? AppColors.whiteColor
                      : AppColors.blueColor,
                  width: selectedItemIndex == index ? 2.25 : 1.25,
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}

class GetUserOpinion extends StatelessWidget {
  final ProductDetailScreen parentWidget;
  final List<Comments> comments;
  const GetUserOpinion({
    Key? key,
    required this.parentWidget,
    required this.comments,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: GestureDetector(
        onTap: () => showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          isDismissible: true,
          useSafeArea: true,
          showDragHandle: true,
          builder: ((context) {
            return BlocProvider(
              create: (context) => CommentBloc(serviceLocator.get())
                ..add(
                  CommentInitializedEvent(parentWidget.product.id),
                ),
              child: Padding(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ),
                child: CommentBottomsheet(
                  productId: parentWidget.product.id,
                ),
              ),
            );
          }),
        ),
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
              comments.isEmpty
                  ? Container()
                  : Container(
                      height: 28,
                      width: 32,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: AppColors.blueColor,
                      ),
                      child: Center(
                        child: Text(
                          '${comments.length >= 20 ? '+ 20' : comments.length}',
                          style: const TextStyle(
                            color: AppColors.whiteColor,
                            fontFamily: 'sb',
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
              /*Stack(
                      clipBehavior: Clip.none,
                      children: [
                        SizedBox(
                          width: 80,
                          height: 26,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: comments.length < 3 ? comments.length : 3,
                            itemBuilder: (context, index) {
                              return Container(
                                decoration: const BoxDecoration(
                                  color: Colors.transparent,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(8),
                                  ),
                                ),
                                child: comments[index].avatar.isEmpty
                                    ? Image.asset('images/avatar.png')
                                    : ImageCachedWidget(
                                        imageUrl: comments[index].userAvatar,
                                      ),
                              );
                            },
                          ),
                        ),
                        Positioned(
                          right: comments.length <= 3
                              ? comments.length * 2
                              : 3 * 24,
                          child: Container(
                            height: 26,
                            width: 26,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: AppColors.greyColor,
                            ),
                            child: Center(
                              child: Text(
                                '+ ${comments.length}',
                                style: const TextStyle(
                                  color: AppColors.whiteColor,
                                  fontFamily: 'sb',
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),*/
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
    );
  }
}

class ProductDescryption extends StatefulWidget {
  String productDescrption;
  ProductDescryption(this.productDescrption, {Key? key}) : super(key: key);

  @override
  State<ProductDescryption> createState() => _ProductDescryptionState();
}

class _ProductDescryptionState extends State<ProductDescryption> {
  bool isClicked = false;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        children: [
          GestureDetector(
            onTap: () => setState(() {
              isClicked = !isClicked;
            }),
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
                    'توضیحات محصول:',
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
          Visibility(
            visible: isClicked,
            child: Container(
              margin: const EdgeInsets.only(top: 22, left: 22, right: 22),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: AppColors.whiteColor,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(width: 1, color: AppColors.greyColor),
              ),
              child: Text(
                widget.productDescrption,
                textAlign: TextAlign.justify,
                style: const TextStyle(
                  color: AppColors.blackColor,
                  fontFamily: 'sb',
                  fontSize: 13,
                  height: 2,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ProductProperties extends StatefulWidget {
  List<Property> productPropertiesList;
  ProductProperties(this.productPropertiesList, {Key? key}) : super(key: key);

  @override
  State<ProductProperties> createState() => _ProductPropertiesState();
}

class _ProductPropertiesState extends State<ProductProperties> {
  bool isClicked = false;
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        children: [
          GestureDetector(
            onTap: () => setState(() {
              isClicked = !isClicked;
            }),
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
          Visibility(
            visible: isClicked,
            child: Container(
              margin: const EdgeInsets.only(top: 22, left: 22, right: 22),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: AppColors.whiteColor,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(width: 1, color: AppColors.greyColor),
              ),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: widget.productPropertiesList.length,
                itemBuilder: ((context, index) {
                  return Text(
                    '${widget.productPropertiesList[index].title} : ${widget.productPropertiesList[index].value}',
                    textAlign: TextAlign.justify,
                    style: const TextStyle(
                      color: AppColors.blackColor,
                      fontFamily: 'sb',
                      fontSize: 13,
                      height: 2,
                    ),
                  );
                }),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

//this class shows product images
class SingleProductImage extends StatefulWidget {
  List<ProductImage> productImages;
  String defaultProductImageUrl;
  int selectedItemIndex = 0;
  SingleProductImage(this.productImages, this.defaultProductImageUrl,
      {Key? key})
      : super(key: key);

  @override
  State<SingleProductImage> createState() => _SingleProductImageState();
}

class _SingleProductImageState extends State<SingleProductImage> {
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

class SingleProductName extends StatelessWidget {
  String productName;
  SingleProductName(this.productName, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Text(
        productName,
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: AppColors.blackColor,
          fontFamily: 'sb',
          fontSize: 16,
        ),
      ),
    );
  }
}

class ProductPriceTag extends StatelessWidget {
  Product product;
  ProductPriceTag(
    this.product, {
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
  Product product;
  AddToCartButton(
    this.product, {
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
        GestureDetector(
          onTap: () {
            BlocProvider.of<ProductBloc>(context)
                .add(ProductAddToCardEvent(product));
            //use this event call to inform shoppingCard
            //new product added to you update your list in screen
            BlocProvider.of<CardBloc>(context)
                .add(CardFetchedDataFromHiveEvent());
          },
          child: ClipRRect(
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
          ),
        )
      ],
    );
  }
}

class SingleProductAppbar extends StatelessWidget {
  Category productCategory;
  SingleProductAppbar(this.productCategory, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.height / 42,
          vertical: MediaQuery.of(context).size.height / 42,
        ),
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
              Expanded(
                child: Text(
                  productCategory.title!,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
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
      ),
    );
  }
}
