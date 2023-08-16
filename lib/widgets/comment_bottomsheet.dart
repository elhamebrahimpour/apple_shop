import 'package:apple_shop/bloc/comment/comment_bloc.dart';
import 'package:apple_shop/utils/constants/app_colors.dart';
import 'package:apple_shop/widgets/cached_widget.dart';
import 'package:apple_shop/widgets/loading_animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CommentBottomsheet extends StatelessWidget {
  final ScrollController scrollController;
  const CommentBottomsheet(this.scrollController, {super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CommentBloc, CommentState>(
      builder: (context, state) {
        if (state is CommentLoadingState) {
          return const LoadingAnimation();
        }
        return CustomScrollView(
          controller: scrollController,
          slivers: [
            if (state is CommentResponseState) ...{
              state.comments.fold((exception) {
                return SliverToBoxAdapter(
                  child: Center(
                    child: Text(exception),
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
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    comments[index].userName,
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
                              child: ImageCachedWidget(
                                imageUrl: comments[index].userAvatar,
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
        );
      },
    );
  }
}
