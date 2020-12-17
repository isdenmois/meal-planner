import 'package:flutter/material.dart';
import 'package:meal_planner/screens/products/product-add_dialog.dart';
import 'package:meal_planner/screens/products/product-edit_dialog.dart';
import 'package:meal_planner/screens/products/product_repository.dart';
import 'package:meal_planner/services/auth.dart';
import 'package:meal_planner/widgets/stream-progress-builder.dart';

import 'product-item.dart';
import 'product.dart';

class ProductListPage extends StatelessWidget {
  final products = productList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Shopping list')),
      body: StreamProgressBuilder(
        stream: products,
        builder: (context, List<Product> list) {
          return ListView(
            children: list
                .map((product) => ProductLine(
                      key: Key(product.id.toString()),
                      product: product,
                      onLongPress: (product) => openEditProductDialog(context, product),
                    ))
                .toList(),
          );
        },
      ),
      floatingActionButton:
          FloatingActionButton(child: new Icon(Icons.add), onPressed: () => openAddProductDialog(context)),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            DrawerHeader(
              child: Text('Drawer Header'),
              decoration: BoxDecoration(
                color: Color(0xFF3D9098),
              ),
            ),
            ListTile(
              title: Text('Log out'),
              onTap: () {
                AuthService().logOut();
              },
            ),
          ],
        ),
      ),
    );
  }

  openAddProductDialog(BuildContext context) {
    showModalBottomSheet(context: context, isScrollControlled: true, builder: ProductAddDialog.dialogBuilder);
  }

  openEditProductDialog(BuildContext context, Product product) {
    showModalBottomSheet(context: context, isScrollControlled: true, builder: (_) => ProductEditDialog(product));
  }
}
