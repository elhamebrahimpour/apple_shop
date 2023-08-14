part of 'comment_bloc.dart';

@immutable
abstract class CommentEvent {}

class CommentInitializedEvent extends CommentEvent {
  final String productId;
  CommentInitializedEvent(this.productId);
}
