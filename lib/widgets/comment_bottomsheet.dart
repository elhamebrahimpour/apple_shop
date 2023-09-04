import 'dart:ui';

import 'package:apple_shop/bloc/comment/comment_bloc.dart';
import 'package:apple_shop/utils/constants/app_colors.dart';
import 'package:apple_shop/widgets/cached_widget.dart';
import 'package:apple_shop/widgets/loading_animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CommentBottomsheet extends StatelessWidget {
  final TextEditingController textEditingController = TextEditingController();

  final String productId;

  CommentBottomsheet({super.key, required this.productId});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CommentBloc, CommentState>(listener: (context, state) {
      if (state is CommentUpdateResponseState) {
        context.read<CommentBloc>().add(CommentInitializedEvent(productId));
      }
    }, builder: (context, snapshot) {
      return BlocBuilder<CommentBloc, CommentState>(
        builder: (context, state) {
          if (state is CommentLoadingState) {
            return const LoadingAnimation();
          }
          return Column(
            children: [
              const Text(
                'Comments',
                style: TextStyle(
                  color: AppColors.blackColor,
                  fontFamily: 'sm',
                  fontSize: 16,
                ),
              ),
              Expanded(
                child: CustomScrollView(
                  slivers: [
                    if (state is CommentResponseState) ...{
                      state.comments.fold((exception) {
                        return const SliverToBoxAdapter(
                          child: Center(
                            child: Text('!اتصال ناموفق'),
                          ),
                        );
                      }, (comments) {
                        if (comments.isEmpty) {
                          return const SliverToBoxAdapter(
                            child: Center(
                              child: Text('.کامنتی ثبت نشده است'),
                            ),
                          );
                        }
                        return SliverList(
                          delegate: SliverChildBuilderDelegate(
                            (context, index) {
                              return Container(
                                margin: const EdgeInsets.symmetric(
                                  vertical: 8,
                                  horizontal: 8,
                                ),
                                padding: const EdgeInsets.symmetric(
                                  vertical: 6,
                                  horizontal: 8,
                                ),
                                decoration: BoxDecoration(
                                  color: AppColors.whiteColor,
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    width: 1,
                                    color: AppColors.blueColor.withOpacity(0.1),
                                    strokeAlign: BorderSide.strokeAlignOutside,
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                            comments[index].userName.isEmpty
                                                ? 'کاربر'
                                                : comments[index].userName,
                                            textAlign: TextAlign.end,
                                            style: const TextStyle(
                                              color: AppColors.blackColor,
                                              fontFamily: 'sm',
                                              fontSize: 14,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 6,
                                          ),
                                          Text(
                                            comments[index].text,
                                            textAlign: TextAlign.end,
                                            style: const TextStyle(
                                              color: AppColors.blackColor,
                                              fontFamily: 'sm',
                                              fontSize: 14,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    CircleAvatar(
                                      radius: 18,
                                      backgroundColor: Colors.transparent,
                                      child: comments[index].avatar.isEmpty
                                          ? Image.asset('images/avatar.png')
                                          : ImageCachedWidget(
                                              imageUrl:
                                                  comments[index].userAvatar,
                                            ),
                                    ),
                                  ],
                                ),
                              );
                            },
                            childCount: comments.length,
                          ),
                        );
                      }),
                    }
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                child: Column(
                  children: [
                    Directionality(
                      textDirection: TextDirection.rtl,
                      child: SizedBox(
                        height: 52,
                        child: TextField(
                          controller: textEditingController,
                          decoration: const InputDecoration(
                            labelText: 'نوشتن نظر',
                            labelStyle: TextStyle(
                                color: AppColors.greyColor,
                                fontSize: 14,
                                fontFamily: 'sm'),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(15),
                              ),
                              borderSide: BorderSide(
                                  color: AppColors.blackColor, width: 2),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(15),
                              ),
                              borderSide: BorderSide(
                                color: AppColors.blueColor,
                                width: 3,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Stack(
                      alignment: AlignmentDirectional.bottomCenter,
                      children: [
                        Container(
                          height: 60,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: AppColors.blueColor,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            if (textEditingController.text.isEmpty) {
                              return;
                            }
                            context.read<CommentBloc>().add(
                                  CommentPostedEvent(
                                      productId, textEditingController.text),
                                );
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                              child: const SizedBox(
                                height: 53,
                                child: Center(
                                  child: Text(
                                    'ارسال نظر',
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
                    ),
                  ],
                ),
              )
            ],
          );
        },
      );
    });
  }
}
