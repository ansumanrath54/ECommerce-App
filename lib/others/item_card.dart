import 'package:ecommerce_app/screens/buyingpage.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_app/others/products.dart';

class ItemCard extends StatelessWidget {
  ItemCard({required this.product});
  final Product product;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (_) => BuyingPage(product: product,),),);
      },
      child: Container(
        margin: const EdgeInsets.only(top: 16.0, left: 10, right: 10),
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
              width: 150,
              image: NetworkImage(product.image),
            ),
            VerticalDivider(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name,
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.w700),
                ),
                Divider(height: 2.0),
                Divider(),
                Text(
                  "\$ ${product.price}",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Colors.blueGrey),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}