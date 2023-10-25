import 'package:apple_shop/data/model/card_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

abstract class ICardLocalDataSource {
  //add product to your shopping card
  Future<void> addProductToCard(CardModel cardModel);

  //get all card products from local database
  Future<List<CardModel>> getAllCardProducts();

  //calculate shopping card final price to pay
  Future<int> getShoppingCardFinalPrice();

  Future<void> removeProduct(int index);
}

class CardLocalDataSource extends ICardLocalDataSource {
  var cardBox = Hive.box<CardModel>('cardBox');
  @override
  Future<void> addProductToCard(CardModel cardModel) async {
    await cardBox.add(cardModel);
  }

  @override
  Future<List<CardModel>> getAllCardProducts() async {
    return cardBox.values.toList();
  }

  @override
  Future<int> getShoppingCardFinalPrice() async {
    var finalPrice = cardBox.values.toList().fold(
          0,
          (accumulator, cardModel) => accumulator + (cardModel.realPrice!),
        );
    return finalPrice;
  }

  @override
  Future<void> removeProduct(int index) async {
    cardBox.deleteAt(index);
  }
}
