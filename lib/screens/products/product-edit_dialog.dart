import 'package:flutter/material.dart';
import 'package:meal_planner/screens/products/product-form.dart';
import 'package:meal_planner/screens/products/product_repository.dart';

import 'product.dart';

class ProductEditDialog extends StatelessWidget {
  final Product product;

  ProductEditDialog(this.product);

  @override
  Widget build(BuildContext context) {
    return ProductForm(updateProduct, product: product);
  }
}
