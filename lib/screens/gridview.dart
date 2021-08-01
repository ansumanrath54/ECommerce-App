import 'package:ecommerce_app/others/products.dart';
import 'package:flutter/material.dart';
import '../others/gridview_card.dart';

class ItemGrid extends StatelessWidget {

  ItemGrid({required this.products});
  final List<Product> products;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Expanded(
          child: GridView.builder(
            itemCount: products.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
            itemBuilder: (context, index) {
              return GridViewCard(product: products[index]);
            },
          )),
    );
  }
}

