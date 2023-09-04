class Comments {
  String id;
  String text;
  String productId;
  String userId;
  String userAvatar;
  String userName;
  String avatar;

  Comments(
    this.id,
    this.text,
    this.productId,
    this.userId,
    this.userAvatar,
    this.userName,
    this.avatar,
  );

  factory Comments.fromJsonMap(Map<String, dynamic> jsonObject) {
    return Comments(
      jsonObject['id'],
      jsonObject['text'],
      jsonObject['product_id'],
      jsonObject['user_id'],
      'http://startflutter.ir/api/files/${jsonObject['expand']['user_id']['collectionName']}/${jsonObject['expand']['user_id']['id']}/${jsonObject['expand']['user_id']['avatar']}',
      jsonObject['expand']['user_id']['name'],
      jsonObject['expand']['user_id']['avatar'],
    );
  }
}
