import 'dart:convert';

import 'package:hive/hive.dart';
part 'products.g.dart';

List<Product> productFromJson(String str) =>
    List<Product>.from(json.decode(str).map((x) => Product.fromJson(x)));

String productToJson(List<Product> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

@HiveType(typeId: 2)
class Product {
  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.image,
    required this.price,
  });

  @HiveField(0)
  String id;
  @HiveField(1)
  String name;
  @HiveField(2)
  String description;
  @HiveField(3)
  String image;
  @HiveField(4)
  double price;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json["_id"],
    name: json["name"],
    description: json["description"],
    image: json["image"],
    price: json["price"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "description": description,
    "image": image,
    "price": price
  };
}