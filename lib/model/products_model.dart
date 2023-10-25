import 'package:cloud_firestore/cloud_firestore.dart';

class ProductsModel {
  final String? id;
  final String name;
  final String description;
  final String price;
  final String image;
    int quantity;

  ProductsModel({
    this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.image,
    this.quantity = 1

  });
  toJson() {
    return {
      "Name": name,
      "Description": description,
      "Price": price,
      "image": image,
    };
  }

  factory ProductsModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return ProductsModel(
      id:document.id,
        name: data["Name"], 
        description: data["Description"], 
        price: data["Price"], 
        image: data["image"],
        );
  }
}
