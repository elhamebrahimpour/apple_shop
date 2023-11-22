import 'package:apple_shop/data/datasource/card_datasource.dart';
import 'package:apple_shop/data/model/card_model.dart';
import 'package:dartz/dartz.dart';

abstract class ICardLocalRepository {
  Future<Either<String, String>> addProductToCard(CardModel cardModel);

  Future<Either<String, List<CardModel>>> getAllCardProducts();

  Future<int> getShoppingCardFinalPrice();

  Future<void> removeProduct(int index);

  Future<void> deleteCardBox();
}

class CardLocalRepository extends ICardLocalRepository {
  final ICardLocalDataSource _localDataSource;

  CardLocalRepository(this._localDataSource);

  @override
  Future<Either<String, String>> addProductToCard(CardModel cardModel) async {
    try {
      await _localDataSource.addProductToCard(cardModel);
      return right('به سبد خرید شما افزوده شد.');
    } catch (ex) {
      return left('خطا در افزودن به سبد خرید!');
    }
  }

  @override
  Future<Either<String, List<CardModel>>> getAllCardProducts() async {
    try {
      final cardList = await _localDataSource.getAllCardProducts();
      return (right(cardList));
    } catch (ex) {
      return left('خطا در نمایش سبد خرید شما!');
    }
  }

  @override
  Future<int> getShoppingCardFinalPrice() async {
    return await _localDataSource.getShoppingCardFinalPrice();
  }

  @override
  Future<void> removeProduct(int index) async {
    _localDataSource.removeProduct(index);
  }

  @override
  Future<void> deleteCardBox() async {
    _localDataSource.deleteCardBox();
  }
}
