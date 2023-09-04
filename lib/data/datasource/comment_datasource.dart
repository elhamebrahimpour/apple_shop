import 'package:apple_shop/data/model/comment.dart';
import 'package:apple_shop/di/api_di.dart';
import 'package:apple_shop/utils/api_exception.dart';
import 'package:dio/dio.dart';

abstract class ICommentDatasource {
  Future<List<Comments>> getComments(String productId);

  Future<void> postComment(String productId, String comment);
}

class CommentDatasource extends ICommentDatasource {
  final Dio _dio = serviceLocator.get();

  @override
  Future<List<Comments>> getComments(String productId) async {
    try {
      Map<String, String> queryParams = {
        'filter': 'product_id="$productId"',
        'expand': 'user_id'
      };

      var response = await _dio.get('collections/comment/records',
          queryParameters: queryParams);

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

  @override
  Future<void> postComment(String productId, String comment) async {
    try {
      await _dio.post('collections/comment/records', data: {
        'product_id': productId,
        'user_id': '8nzv4ubo59ohmbp',
        'text': comment,
      });
    } on DioError catch (e) {
      throw ApiException(e.response!.statusCode, e.response!.data['message']);
    } catch (ex) {
      throw ApiException(0, 'unknown error!');
    }
  }
}
