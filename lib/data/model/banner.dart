class AdvertiseBanner {
  String? categoryId;
  String? collectionId;
  String? id;
  String? thumbnail;

  AdvertiseBanner(this.categoryId, this.collectionId, this.id, this.thumbnail);

  factory AdvertiseBanner.fromJson(Map<String, dynamic> jsonObject) {
    return AdvertiseBanner(
      jsonObject['categoryId'],
      jsonObject['collectionId'],
      jsonObject['id'],
      'http://startflutter.ir/api/files/${jsonObject['collectionId']}/${jsonObject['id']}/${jsonObject['thumbnail']}',
    );
  }
}
