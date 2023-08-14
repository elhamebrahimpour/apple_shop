part of 'comment_bloc.dart';

@immutable
abstract class CommentState {}

class CommentLoadingState extends CommentState {}

class CommentResponseState extends CommentState {
  final Either<String, List<Comments>> comments;
  CommentResponseState(this.comments);
}
