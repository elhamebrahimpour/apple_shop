import 'package:apple_shop/data/model/card_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

abstract class ICardLocalDataSource {
  Future<void> addProductToCard(CardModel cardModel);
}

class CardLocalDataSource extends ICardLocalDataSource {
  var cardBox = Hive.box<CardModel>('cardBox');
  @override
  Future<void> addProductToCard(CardModel cardModel) async{
     await cardBox.add(cardModel);
  }
}
