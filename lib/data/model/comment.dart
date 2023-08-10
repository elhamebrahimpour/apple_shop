class Comments {
  String? id;
  String? text;
  String? productId;
  String? userId;

  Comments(
    this.id,
    this.text,
    this.productId,
    this.userId,
  );

  factory Comments.fromJsonMap(Map<String, dynamic> jsonObject) {
    return Comments(
      jsonObject['id'],
      jsonObject['text'],
      jsonObject['product_id'],
      jsonObject['user_id'],
    );
  }
}
