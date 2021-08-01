import 'package:ecommerce_app/screens/my_cart.dart';
import 'package:ecommerce_app/others/products.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:ecommerce_app/others/cart_icon.dart';
import 'package:ecommerce_app/others/flutter_toast.dart';
import 'package:ecommerce_app/others/item.dart';


class BuyingPage extends StatefulWidget {
  const BuyingPage({Key? key, required this.product}) : super(key: key);
  final Product product;

  @override
  _BuyingPageState createState() => _BuyingPageState();
}

class _BuyingPageState extends State<BuyingPage> {
  addItemToCart() async {
    final cartBox = Hive.box("cart");
    print(cartBox.containsKey(widget.product.id));
    if (cartBox.containsKey(widget.product.id)) {
      Item item = await cartBox.get(widget.product.id);
      item.quantity += 1;
      await cartBox.put(widget.product.id, item);
    } else {
      await cartBox.put(
        widget.product.id,
        Item(product: widget.product, quantity: 1),
      );
    }
    CustomToast.showToast("Added to cart");
    Navigator.of(context).pop();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.greenAccent,
        centerTitle: true,
        iconTheme: IconThemeData(
            color: Colors.black
        ),
        title: Text(
            'SkillKart',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black
            )
        ),
        actions: <Widget>[
          CartIcon(),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image(
              width: 400,
              image: NetworkImage(widget.product.image),
            ),
            Divider(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 48),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.product.name,
                    style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                  ),
                  Divider(),
                  Text(
                    widget.product.description,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.normal,
                      color: Colors.black54,
                    ),
                  ),
                  Divider(),
                  Text(
                    "\$${widget.product.price}",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 130.0),
              child: RaisedButton(
                padding: EdgeInsets.fromLTRB(130, 10, 130, 10),
                onPressed: () {
                  addItemToCart();
                },
                color: Colors. amber,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius. circular(5)),
                child: Text("Add to Cart",
                  style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white
                  ),),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 20.0),
              child: RaisedButton(
                padding: EdgeInsets.fromLTRB(140, 10, 140, 10),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => (MyCart())));
                },
                color: Colors.blue,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius. circular(5)),
                child: Text("Buy Now",
                  style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white
                  ),),
              ),
            ),
            Divider(),
          ],
        ),
      ),
    );
  }
}
