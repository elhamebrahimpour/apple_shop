class Category {
  String? collectionId;
  String? id;
  String? title;
  String? thumbnail;
  String? color;
  String? icon;

  Category(this.collectionId, this.id, this.title, this.thumbnail, this.color,
      this.icon);

  factory Category.fromJsonMap(Map<String, dynamic> jsonObject) {
    return Category(
      jsonObject['collectionId'],
      jsonObject['id'],
      jsonObject['title'],
      'http://startflutter.ir/api/files/${jsonObject['collectionId']}/${jsonObject['id']}/${jsonObject['thumbnail']}',
      jsonObject['color'],
      jsonObject['icon'],
    );
  }
}
