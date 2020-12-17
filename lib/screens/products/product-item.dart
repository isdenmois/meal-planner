import 'package:flutter/material.dart';

import 'product-edit_dialog.dart';
import 'product.dart';
import 'product_repository.dart';

class ProductLine extends StatelessWidget {
  final Product product;
  final onLongPress;
  final GlobalKey gkey;

  ProductLine({Key key, @required this.product, this.onLongPress})
      : gkey = GlobalKey(debugLabel: product.id),
        super(key: key);

  final lineThroughStyle = TextStyle(decoration: TextDecoration.lineThrough);

  @override
  Widget build(BuildContext context) {
    return Card(
      key: gkey,
      elevation: 2,
      child: InkWell(
        onTap: toggle,
        onLongPress: () => openProductMenu(context),
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

  openProductMenu(BuildContext context) async {
    RenderBox box = gkey.currentContext.findRenderObject();
    Offset offset = box.localToGlobal(Offset.zero);
    RelativeRect position = RelativeRect.fromLTRB(0, offset.dy, 0, 0);

    final result = await showMenu(context: context, position: position, items: [
      PopupMenuItem(value: 'edit', child: Text("Edit")),
      PopupMenuItem(value: 'delete', child: Text("Delete")),
    ]);

    if (result == 'edit') {
      openEditProductDialog(context);
    }

    if (result == 'delete') {
      removeProduct(product);
    }
  }

  openEditProductDialog(BuildContext context) {
    showModalBottomSheet(context: context, isScrollControlled: true, builder: (_) => ProductEditDialog(product));
  }
}
