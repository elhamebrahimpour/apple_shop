import 'package:apple_shop/data/model/comment.dart';
import 'package:apple_shop/di/api_di.dart';
import 'package:apple_shop/utils/api_exception.dart';
import 'package:dio/dio.dart';

abstract class ICommentDatasource {
  Future<List<Comments>> getComments(String productId);
}

class CommentDatasource extends ICommentDatasource {
  final Dio _dio = serviceLocator.get();

  @override
  Future<List<Comments>> getComments(String productId) async {
    try {
      var response = await _dio.get('collections/comments/records');
      return response.data['items']
          .map<Comments>((jsonObject) => Comments.fromJsonMap(jsonObject))
          .toList();
      // ignore: deprecated_member_use
    } on DioError catch (e) {
      throw ApiException(e.response!.statusCode, e.response!.data['message']);
    } catch (ex) {
      throw ApiException(0, 'unknown error!');
    }
  }
}
