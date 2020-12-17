import 'package:flutter/material.dart';
import 'package:meal_planner/screens/products/product-form.dart';
import 'package:meal_planner/screens/products/product_repository.dart';

class ProductAddDialog extends StatelessWidget {
  static Widget dialogBuilder(BuildContext context) => ProductAddDialog();

  @override
  Widget build(BuildContext context) {
    return ProductForm(createProduct);
  }
}
