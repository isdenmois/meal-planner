class Product {
  String id;
  String title;
  bool bought;
  String count;

  Product({this.id, this.title, this.bought, this.count});

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'bought': bought,
      'count': count,
    };
  }

  static Product fromJson(String id, Map<String, dynamic> map) => Product(
        id: id,
        title: map['title'],
        bought: map['bought'],
        count: map['count'],
      );
}
