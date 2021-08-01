import 'package:flutter/material.dart';
import 'package:ecommerce_app/others/item.dart';

class CartItemCard extends StatelessWidget {
  const CartItemCard({required this.item, Key? key}) : super(key: key);
  final Item item;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 4.0, left: 16, right: 16),
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 2,
            offset: Offset(4, 4),
          )
        ],
      ),
      child: Row(
        children: [
          Image(
            width: 50,
            image: NetworkImage(item.product.image),
          ),
          VerticalDivider(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item.product.name,
                style: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.w700),
              ),
              Divider(height: 2.0),
              Divider(),
              Text(
                "Price: \$ ${item.product.price}",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Colors.black54),
              ),
              Divider(height: 2.0),
              Divider(),
              Text(
                "Quantity: ${item.quantity}",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Colors.black54),
              ),
            ],
          ),
        ],
      ),
    );
  }
}