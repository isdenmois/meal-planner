import 'package:flutter/material.dart';
import 'package:meal_planner/screens/products/product_repository.dart';
import 'package:meal_planner/widgets/stream-progress-builder.dart';

import 'product-item.dart';
import 'product.dart';

class ProductListPage extends StatelessWidget {
  final products = productList();

  final headerStyle = TextStyle(color: Colors.black);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: Text('Shopping list', style: headerStyle), backgroundColor: Colors.white, elevation: 0),
      body: StreamProgressBuilder(
        stream: products,
        builder: (context, List<Product> list) {
          return ListView(
            children: list.map((product) => ProductLine(key: Key(product.id.toString()), product: product)).toList(),
          );
        },
      ),
    );
  }
}
