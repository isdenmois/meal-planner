import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

import 'product.dart';

class ProductForm extends StatefulWidget {
  final onSave;
  final Product product;

  ProductForm(this.onSave, {this.product});

  @override
  _ProductFormState createState() => _ProductFormState();
}

class _ProductFormState extends State<ProductForm> {
  final form = fb.group({
    'title': ['', Validators.required],
  });

  @override
  void initState() {
    if (widget.product != null) {
      final product = widget.product;
      final count = product.count != null && product.count.isNotEmpty ? ' : ${product.count}' : '';
      final title = product.title + count;

      form.reset(value: {'title': title});
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ReactiveForm(
        formGroup: form,
        child: Container(
          padding: MediaQuery.of(context).viewInsets,
          child: ReactiveTextField(
            autofocus: true,
            formControlName: 'title',
            decoration: InputDecoration(
              labelText: 'Item : amount',
              filled: true,
              isDense: true,
            ),
            textCapitalization: TextCapitalization.sentences,
            textInputAction: TextInputAction.done,
            onSubmitted: () => submit(context),
          ),
        ));
  }

  submit(BuildContext context) {
    if (!form.valid) return;
    final String input = form.value['title'].trim();

    Navigator.pop(context);

    final parts = input.split(':');
    final product = Product(
      id: widget.product?.id,
      title: parts[0].trim(),
      bought: false,
    );

    if (parts.length > 1 && parts[1].trim().isNotEmpty) {
      product.count = parts[1].trim();
    }

    widget.onSave(product);
  }
}
