import 'dart:convert';

import 'package:ecommerce_app/others/item.dart';

List<Order> orderFromJson(String str) =>
    List<Order>.from(json.decode(str).map((x) => Order.fromJson(x)));

String orderToJson(List<Order> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Order {
  Order({
    required this.id,
    required this.products,
    required this.createdAt,
  });

  final String id;
  final List<Item> products;
  final DateTime createdAt;

  factory Order.fromJson(Map<String, dynamic> json) => Order(
    id: json["_id"],
    products:
    List<Item>.from(json["products"].map((x) => Item.fromJson(x))),
    createdAt: DateTime.parse(json["createdAt"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "products": List<dynamic>.from(products.map((x) => x.toJson())),
    "createdAt": createdAt.toIso8601String()
  };
}