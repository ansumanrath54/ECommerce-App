import 'package:flutter/material.dart';
import 'package:ecommerce_app/others/item.dart';
import 'cartItem_card.dart';


class CartItemList extends StatelessWidget {
  CartItemList({required this.items});
  final List<Item> items;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Expanded(
        child: ListView.builder(
          itemCount: items.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return CartItemCard(
              item: items[index],
            );
          },
        ),
      ),
    );
  }
}