import 'package:apple_shop/bloc/comment/comment_bloc.dart';
import 'package:apple_shop/utils/constants/app_colors.dart';
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
          return const Center(
            child: LoadingAnimation(),
          );
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
                          vertical: 12,
                          horizontal: 8,
                        ),
                        padding: const EdgeInsets.symmetric(
                          vertical: 6,
                          horizontal: 8,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.blueColor.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          comments[index].text,
                          textAlign: TextAlign.end,
                          style: const TextStyle(
                            color: AppColors.blackColor,
                            fontFamily: 'sm',
                            fontSize: 14,
                          ),
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
