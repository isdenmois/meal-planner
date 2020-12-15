import 'package:cloud_firestore/cloud_firestore.dart';

import 'product.dart';

Stream<List<Product>> productList() {
  return FirebaseFirestore.instance
      .collection('products')
      .orderBy('bought')
      // .orderBy('title')
      .snapshots()
      .map((snapshot) {
    return snapshot.docs.map((s) => Product.fromJson(s.id, s.data())).toList();
  });
}

Future toggleProduct(Product product) {
  return FirebaseFirestore.instance.collection('products').doc(product.id).update({'bought': !product.bought});
}
