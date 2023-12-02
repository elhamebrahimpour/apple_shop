import 'package:apple_shop/data/datasource/comment_datasource.dart';
import 'package:apple_shop/data/model/comment.dart';
import 'package:apple_shop/features/di/api_di.dart';
import 'package:apple_shop/features/utils/api_exception.dart';
import 'package:dartz/dartz.dart';

abstract class ICommentRepository {
  Future<Either<String, List<Comments>>> getComments(String productId);

  Future<Either<String, String>> postComment(String productId, String comment);
}

class CommentRepository extends ICommentRepository {
  final ICommentDatasource _commentDatasource = serviceLocator.get();

  @override
  Future<Either<String, List<Comments>>> getComments(String productId) async {
    try {
      final productComments = await _commentDatasource.getComments(productId);
      return right(productComments);
    } on ApiException catch (e) {
      return left(e.message ?? 'Failed!');
    }
  }

  @override
  Future<Either<String, String>> postComment(
      String productId, String comment) async {
    try {
      await _commentDatasource.postComment(productId, comment);
      return right('.نظر شما ثبت شد');
    } on ApiException catch (e) {
      return left(e.message ?? 'Failed!');
    }
  }
}
