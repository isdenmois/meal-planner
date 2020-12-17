import 'package:flutter/material.dart';

import 'product.dart';
import 'product_repository.dart';

class ProductLine extends StatelessWidget {
  final Product product;
  final onLongPress;

  ProductLine({Key key, @required this.product, this.onLongPress}) : super(key: key);

  final lineThroughStyle = TextStyle(decoration: TextDecoration.lineThrough);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: InkWell(
        onTap: toggle,
        onLongPress: longTap,
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(
              product.title,
              style: product.bought ? lineThroughStyle : null,
            ),
            Text(product.count ?? ''),
          ]),
        ),
      ),
    );
  }

  toggle() {
    toggleProduct(product);
  }

  longTap() {
    onLongPress(product);
  }
}
