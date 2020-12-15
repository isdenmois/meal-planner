import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  int id;
  String title;
  bool bought;

  Product({this.id, this.title, this.bought});

  static Product fromJson(Map<String, dynamic> map) =>
      Product(id: map['id'], title: map['title'], bought: map['bought']);
}

class ProductListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product list'),
      ),
      body: PagingProduct(),
    );
  }
}

class PagingProduct extends StatelessWidget {
  CollectionReference products = FirebaseFirestore.instance.collection('products');

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: products.orderBy('title').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text("Something went wrong");
        }

        if (!snapshot.hasData) {
          return Text("loading");
        }

        List<QueryDocumentSnapshot> data = snapshot.data.docs;

        return ListView(children: data.map((e) => DisplayProduct(key: Key(e.id), snapshot: e)).toList());
      },
    );
  }
}

class DisplayProduct extends StatelessWidget {
  DisplayProduct({
    Key key,
    @required this.snapshot,
  })  : product = Product.fromJson(snapshot.data()),
        super(key: key);

  final QueryDocumentSnapshot snapshot;
  final Product product;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: const EdgeInsets.all(15.0),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [Text(product.title), Checkbox(value: product.bought, onChanged: toggle)]),
      ),
    );
  }

  toggle(bool value) {
    snapshot.reference.update({'bought': value});
  }
}
