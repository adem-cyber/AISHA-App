import 'package:cloud_firestore/cloud_firestore.dart';

class ProductsModelVendor {
  final String? id;
  final String name;
  final String description;
  final String price;
  final String image;
  final String storeid;
  final String available;
  int quantity;

  ProductsModelVendor(
      {this.id,
      required this.name,
      required this.description,
      required this.price,
      required this.image,
      required this.storeid,
      required this.available,
      this.quantity = 1});
  ProductsModelVendor copyWith(
      {String? id,
      String? name,
      String? description,
      String? price,
      String? image,
      int? quantity,
      String? storeid,
      String? available}) {
    return ProductsModelVendor(
        id: id ?? this.id,
        name: name ?? this.name,
        description: description ?? this.description,
        price: price ?? this.price,
        image: image ?? this.image,
        quantity: quantity ?? this.quantity,
        storeid: storeid ?? this.storeid,
        available: available ?? this.available);
  }

  toJson() {
    return {
      "Name": name,
      "Description": description,
      "Price": price,
      "image": image,
      "Storeid": storeid,
      "Availability": available
    };
  }

  factory ProductsModelVendor.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return ProductsModelVendor(
        id: document.id,
        name: data["Name"],
        description: data["Description"],
        price: data["Price"],
        image: data["image"],
        storeid: data["Storeid"],
        available: data["Availability"]);
  }
}
