class Product {
  String categoryId;
  String collectionId;
  String id;
  String name;
  String description;
  String thumbnail;
  String popularity;
  int quantity;
  int price;
  int discount_price;
  int? realPrice;
  num? percent;

  Product(
    this.categoryId,
    this.collectionId,
    this.id,
    this.name,
    this.description,
    this.thumbnail,
    this.popularity,
    this.quantity,
    this.price,
    this.discount_price,
  ) {
    realPrice = price + discount_price;
    percent = ((price - realPrice!) / price) * 100;
  }

  factory Product.fromJson(Map<String, dynamic> jsonObject) {
    return Product(
      jsonObject['category'],
      jsonObject['collectionId'],
      jsonObject['id'],
      jsonObject['name'],
      jsonObject['description'],
      'http://startflutter.ir/api/files/${jsonObject['collectionId']}/${jsonObject['id']}/${jsonObject['thumbnail']}',
      jsonObject['popularity'],
      jsonObject['quantity'],
      jsonObject['price'],
      jsonObject['discount_price'],
    );
  }
}
