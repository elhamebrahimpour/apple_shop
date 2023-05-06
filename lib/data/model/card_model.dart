import 'package:hive/hive.dart';

part 'card_model.g.dart';

@HiveType(typeId: 0)
class CardModel {
  @HiveField(0)
  String categoryId;
  @HiveField(1)
  String collectionId;
  @HiveField(2)
  String id;
  @HiveField(3)
  String name;
  @HiveField(4)
  String thumbnail;
  @HiveField(5)
  int price;
  @HiveField(6)
  int discount_price;
  @HiveField(7)
  int? realPrice;
  @HiveField(8)
  num? percent;

  CardModel(
    this.categoryId,
    this.collectionId,
    this.id,
    this.name,
    this.thumbnail,
    this.price,
    this.discount_price,
  ) {
    realPrice = price + discount_price;
    percent = ((price - realPrice!) / price) * 100;
    //'http://startflutter.ir/api/files/${jsonObject['collectionId']}/${jsonObject['id']}/${jsonObject['thumbnail']}',
  }
}
