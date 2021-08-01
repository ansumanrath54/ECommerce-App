import 'package:ecommerce_app/screens/buyingpage.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_app/others/products.dart';

class GridViewCard extends StatelessWidget {
  GridViewCard({required this.product});
  final Product product;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => (BuyingPage(product: product,))));
      },
      child: Container(
        margin: const EdgeInsets.all(15.0),
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
        child: Image(
          width: 300,
          image: NetworkImage(product.image),
        ),
      ),
    );
  }
}