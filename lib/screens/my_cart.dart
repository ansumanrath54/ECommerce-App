import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:ecommerce_app/others/item.dart';
import 'package:ecommerce_app/others/response.dart';
import 'package:ecommerce_app/services/api.dart';
import 'package:ecommerce_app/others/cartItem_list.dart';
import 'package:ecommerce_app/others/flutter_toast.dart';

class MyCart extends StatefulWidget {
  MyCart({Key? key}) : super(key: key);

  @override
  _MyCartState createState() => _MyCartState();
}

class _MyCartState extends State<MyCart> {
  Future<List<Item>> getItemFromCartBox() async {
    final cartBox = Hive.box("cart");
    List<Item> item = cartBox.values.cast<Item>().toList();
    print(item);
    return item;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //automaticallyImplyLeading: false,
        backgroundColor: Colors.greenAccent,
        centerTitle: true,
        title: Text(
            'My Cart',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black
            )
        ),
        iconTheme: IconThemeData(
            color: Colors.black
        ),
      ),
      body: Container(
        child: FutureBuilder<List<Item>>(
            future: getItemFromCartBox(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data!.isNotEmpty) {
                  return Column(
                    children: [
                      CartItemList(items: snapshot.data!),
                      Container(
                        padding: EdgeInsets.only(top: 20.0),
                        child: RaisedButton(
                          padding: EdgeInsets.fromLTRB(120, 10, 120, 10),
                          onPressed: () async {
                            print("Order placed successfully");
                            addItemToOrder(snapshot.data!);
                          },
                          color: Colors.blue,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius. circular(5)),
                          child: Text("Place Order",
                            style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.white
                            ),),
                        ),
                      ),
                      Divider(),
                    ],
                  );
                } else {
                  return Center(
                    child: Text("No Items in the Cart"),
                  );
                }
              } else if (snapshot.hasError) {
                return Center(
                  child: Text("${snapshot.error}"),
                );
              }
              return CircularProgressIndicator();
            }),
      ),
    );
  }

  Future<void> addItemToOrder(List<Item> items) async {
    Response response = await Api.postOrder(items);
    if (response.status) {
      CustomToast.showToast("Ordered Successfully");
      final cartBox = Hive.box("cart");
      await cartBox.clear();
      Navigator.pop(context);
    } else {
      CustomToast.showToast(response.error.toString());
    }
  }
}