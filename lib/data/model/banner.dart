class Banner {
  String? categoryId;
  String? collectionId;
  String? id;
  String? thumbnail;

  Banner(this.categoryId, this.collectionId, this.id, this.thumbnail);

  factory Banner.fromJson(Map<String, dynamic> jsonObject) {
    return Banner(
      jsonObject['categoryId'],
      jsonObject['collectionId'],
      jsonObject['id'],
      'http://startflutter.ir/api/files/${jsonObject['collectionId']}/${jsonObject['id']}/${jsonObject['thumbnail']}',
    );
  }
}
