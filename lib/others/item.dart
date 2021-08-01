import 'package:ecommerce_app/others/products.dart';
import 'package:hive/hive.dart';
import 'dart:convert';

part 'item.g.dart';

List<Item> itemFromJson(String str) =>
    List<Item>.from(json.decode(str).map((x) => Item.fromJson(x)));

String itemToJson(List<Item> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));


@HiveType(typeId: 1)
class Item {
  @HiveField(0)
  late final Product product;
  @HiveField(1)
  late final int quantity;

  Item({
    required this.product, this.quantity = 1
  });

  factory Item.fromJson(Map<String, dynamic> json) => Item(
    product: Product.fromJson(json["product"]),
    quantity: json["quantity"],
  );

  Map<String, dynamic> toJson() => {
    "product": product.toJson(),
    "quantity": quantity,
  };
}