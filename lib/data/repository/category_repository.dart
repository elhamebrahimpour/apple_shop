import 'package:apple_shop/data/datasource/category_datasource.dart';
import 'package:apple_shop/data/model/category.dart';
import 'package:apple_shop/features/di/api_di.dart';
import 'package:apple_shop/features/utils/api_exception.dart';
import 'package:dartz/dartz.dart';

abstract class ICategoryRepository {
  Future<Either<String, List<Category>>> getCategoryList();
}

class CategoryRepository extends ICategoryRepository {
  final ICategoryDatasource _categoryDatasource = serviceLocator.get();
  @override
  Future<Either<String, List<Category>>> getCategoryList() async {
    try {
      var response = await _categoryDatasource.getCategoryList();
      return right(response);
    } on ApiException catch (e) {
      return left(e.message ?? 'Failed!');
    }
  }
}
