import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:ecommerce_app/screens/my_cart.dart';


class CartIcon extends StatefulWidget {
  const CartIcon({Key? key}) : super(key: key);

  @override
  _CartIconState createState() => _CartIconState();
}

class _CartIconState extends State<CartIcon> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Hive.openBox("cart"),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          final cartBox = Hive.box("cart");
          return Stack(
            children: [
              cartBox.length > 0
                  ? Container(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Text(
                  cartBox.length.toString(),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
              )
                  : Container(),
              IconButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => MyCart()));
                },
                icon: Icon(Icons.shopping_cart),
                color: Colors.black,
              ),
            ],
          );
        }
        return Container();
      },
    );
  }
}