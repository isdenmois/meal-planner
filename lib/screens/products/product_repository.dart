import 'package:cloud_firestore/cloud_firestore.dart';

import 'product.dart';

CollectionReference get _collection {
  return FirebaseFirestore.instance.collection('products');
}

Stream<List<Product>> productList() {
  return _collection.orderBy('title').snapshots().map((snapshot) {
    return snapshot.docs.map((s) => Product.fromJson(s.id, s.data())).toList();
  });
}

Future toggleProduct(Product product) {
  return _collection.doc(product.id).update({'bought': !product.bought});
}

Future createProduct(Product product) {
  return _collection.add(product.toMap());
}

Future updateProduct(Product product) {
  return _collection.doc(product.id).set(product.toMap());
}

Future removeProduct(Product product) {
  return _collection.doc(product.id).delete();
}

Future removeAllBoughtProducts() async {
  final products = await _collection.where('bought', isEqualTo: true).get();
  WriteBatch batch = FirebaseFirestore.instance.batch();

  for (QueryDocumentSnapshot product in products.docs) {
    batch.delete(product.reference);
  }

  batch.commit();
}

Future createUniqueProduct(Product product) async {
  final products = await _collection.where('title', isEqualTo: product.title).limit(1).get();

  if (products.size == 0) {
    return createProduct(product);
  }
}
