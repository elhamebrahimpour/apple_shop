import 'package:apple_shop/data/datasource/card_datasource.dart';
import 'package:apple_shop/data/model/card_model.dart';
import 'package:apple_shop/di/api_di.dart';
import 'package:dartz/dartz.dart';

abstract class ICardLocalRepository {
  Future<Either<String, String>> addProductToCard(CardModel cardModel);
}

class CardLocalRepository extends ICardLocalRepository {
  final ICardLocalDataSource _localDataSource = serviceLocator.get();

  @override
  Future<Either<String, String>> addProductToCard(CardModel cardModel) async {
    try {
      await _localDataSource.addProductToCard(cardModel);
      return right('به سبد خرید شما افزوده شد.');
    } catch (ex) {
      return left(ex.toString());
    }
  }
}
