import 'dart:convert';

import 'package:ecommerce_app/others/cart_icon.dart';
import 'package:ecommerce_app/screens/gridview.dart';
import 'package:ecommerce_app/screens/listview.dart';
import 'package:ecommerce_app/others/products.dart';
import 'package:ecommerce_app/others/response.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_app/services/api.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  bool isList = false;
  var getData;

  @override

  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.greenAccent,
        centerTitle: true,
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
      body: Center(
        child: Container(
          child: FutureBuilder<Response> (
              future: Api.getProducts(),
              builder: (context, snapshot) {
                if(snapshot.hasData) {
                  Response response = snapshot.data!;
                  List<Product> products = productFromJson(jsonEncode(response.data));
                  return Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(20.0),
                            child: Text('View',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold
                              ),),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 250.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      isList = false;
                                    });
                                  },
                                  child: Icon(Icons.apps),
                                ),
                                SizedBox(width: 10,),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      isList = true;
                                    });
                                  },
                                  child: Icon(Icons.list_outlined),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Container(
                        child: isList ? ItemsList(products: products,) : ItemGrid(products: products,),
                      ),
                    ],
                  );
                }
                else if (snapshot.hasError) {
                  return Text(snapshot.error.toString());
                }
                return new CircularProgressIndicator();
              }
          ),
        ),
      ),
    );
  }
}


