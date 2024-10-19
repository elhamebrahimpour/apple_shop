// ignore_for_file: must_be_immutable

import 'package:apple_shop/business/bloc/shopping_card/card_bloc.dart';
import 'package:apple_shop/data/model/card_model.dart';
import 'package:apple_shop/core/constants/app_colors.dart';
import 'package:apple_shop/core/utils/extensions/int_extension.dart';
import 'package:apple_shop/core/utils/extensions/string_extension.dart';
import 'package:apple_shop/presentation/widgets/custom_appbar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShoppingCardScreen extends StatefulWidget {
  const ShoppingCardScreen({Key? key}) : super(key: key);

  @override
  State<ShoppingCardScreen> createState() => _ShoppingCardScreenState();
}

class _ShoppingCardScreenState extends State<ShoppingCardScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CardBloc, CardState>(
      listener: (context, state) {
        if (state is CardUpdateState) {
          context.read<CardBloc>().add(
                CardFetchedDataFromHiveEvent(),
              );
        }
      },
      builder: (context, state) {
        return BlocBuilder<CardBloc, CardState>(
          builder: (context, state) {
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
                          //fetching shopping card products from hive local D.B
                          if (state is CardFetchDataFromHiveState) ...[
                            state.cardList.fold(
                              (exception) => SliverToBoxAdapter(
                                child: Text(exception),
                              ),
                              (cardList) => cardList.isEmpty
                                  ? SliverPadding(
                                      padding: EdgeInsets.only(
                                        top:
                                            MediaQuery.of(context).size.height /
                                                3,
                                      ),
                                      sliver: const SliverToBoxAdapter(
                                        child: Center(
                                          child: Text(
                                            'سبد خرید شما خالی می‌باشد.',
                                            style: TextStyle(
                                              fontFamily: 'sm',
                                              fontSize: 18,
                                              color: AppColors.greyColor,
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  : SliverPadding(
                                      padding:
                                          const EdgeInsets.only(bottom: 80),
                                      sliver: SliverList(
                                        delegate: SliverChildBuilderDelegate(
                                          (context, index) {
                                            return CardItem(
                                              cardList[index],
                                              index,
                                            );
                                          },
                                          childCount: cardList.length,
                                        ),
                                      ),
                                    ),
                            )
                          ],
                        ],
                      ),
                      if (state is CardFetchDataFromHiveState) ...[
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 22, vertical: 22),
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
                              onPressed: () {
                                context
                                    .read<CardBloc>()
                                    .add(CardPaymentInitialEvent());

                                context
                                    .read<CardBloc>()
                                    .add(CardPaymentRequestEvent());
                              },
                              child: Text(
                                'قابل پرداخت: ${state.finalPrice.convertToPrice()}',
                                style: const TextStyle(
                                  fontFamily: 'sm',
                                  fontSize: 18,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}

class CardItem extends StatelessWidget {
  final CardModel cardModel;
  final int index;
  const CardItem(this.cardModel, this.index, {Key? key}) : super(key: key);

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
                  child: SizedBox(
                    height: 120,
                    width: 80,
                    child: CachedNetworkImage(imageUrl: cardModel.thumbnail),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          cardModel.name,
                          textAlign: TextAlign.start,
                          //overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
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
                            Text(
                              cardModel.price.convertToPrice(),
                              style: const TextStyle(
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
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 2, horizontal: 5),
                                child: Text(
                                  '%${cardModel.percent!.round()}',
                                  style: const TextStyle(
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
                          runSpacing: 8,
                          children: [
                            OptionsChip(
                              'قرمز',
                              color: 'd02026',
                            ),
                            GestureDetector(
                              onTap: () {
                                context.read<CardBloc>().add(
                                      CardRemoveProductEvent(index),
                                    );
                              },
                              child: OptionsChip('حذف'),
                            ),
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
              children: [
                Text(
                  cardModel.realPrice.convertToPrice(),
                  style: const TextStyle(
                    fontFamily: 'sb',
                    color: AppColors.blackColor,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                const Text(
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

class OptionsChip extends StatelessWidget {
  String? color;
  String title;
  OptionsChip(this.title, {Key? key, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey.withOpacity(0.5),
          width: 1,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontFamily: 'sm',
                  color: AppColors.blackColor,
                  fontSize: 12,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              if (color != null) ...{
                Container(
                  height: 14,
                  width: 14,
                  decoration: BoxDecoration(
                    color: color.parseToColor(),
                    shape: BoxShape.circle,
                  ),
                )
              } else ...{
                Image.asset('images/icon_trash.png'),
              }
            ],
          ),
        ),
      ),
    );
  }
}
