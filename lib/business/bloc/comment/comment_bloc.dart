import 'package:apple_shop/data/model/comment.dart';
import 'package:apple_shop/data/repository/comment_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

part 'comment_event.dart';
part 'comment_state.dart';

class CommentBloc extends Bloc<CommentEvent, CommentState> {
  final ICommentRepository _commentRepository;

  CommentBloc(this._commentRepository) : super(CommentLoadingState()) {
    on<CommentInitializedEvent>((event, emit) async {
      final comments = await _commentRepository.getComments(event.productId);

      emit(CommentResponseState(comments));
    });

    on<CommentPostedEvent>((event, emit) async {
      emit(CommentLoadingState());

      await _commentRepository.postComment(event.productId, event.comment);

      emit(CommentUpdateResponseState());
    });
  }
}
