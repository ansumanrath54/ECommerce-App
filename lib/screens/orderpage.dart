import 'dart:convert';

import 'package:ecommerce_app/others/response.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_app/others/order.dart';
import 'package:ecommerce_app/services/api.dart';
import 'package:ecommerce_app/others/cartItem_list.dart';


class OrderPage extends StatefulWidget {
  const OrderPage({Key? key}) : super(key: key);

  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.greenAccent,
          centerTitle: true,
          title: Text(
              'My Orders',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black
              )
          ),
        ),
        body: Container(
          child: FutureBuilder<Response>(
              future: Api.getOrders(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  Response response = snapshot.data!;
                  if (response.status) {
                    print(response.data!);
                    List<Order> orders = orderFromJson(jsonEncode(response.data));
                    return ListView.builder(
                      shrinkWrap: true,
                        itemCount: orders.length,
                        itemBuilder: (context, index) {
                          return SingleChildScrollView(
                              child: ListView(
                              shrinkWrap: true,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                                  child: Text('Order Id: ${orders[index].id}',
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.bold,
                                      )),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 16),
                                  child: Text('Created At: ${orders[index].createdAt.toLocal()}',
                                      style: TextStyle(
                                        color: Colors.grey,
                                      )),
                                ),
                                CartItemList(items: orders[index].products),
                                Divider(),
                              ],
                          ),
                            );
                        });
                  } else {
                    return Center(
                      child: Text(
                        response.error.toString(),
                      ),
                    );
                  }
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      snapshot.error.toString(),
                    ),
                  );
                }
                return
                  Center(child: CircularProgressIndicator());
              }),
        ),
      );
  }
}

