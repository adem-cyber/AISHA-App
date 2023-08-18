import 'package:cloud_firestore/cloud_firestore.dart';

class StoreModel {
  final String? id;
  final String name;
  final String location;
  final String image;
  final String typeId;

  StoreModel({
    this.id,
    required this.name,
    required this.location,
    required this.image,
    required this.typeId ,

  });
  toJson() {
    return {
      "Name": name,
      "Location": location,
      "image": image,
    };
  }

  factory StoreModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return StoreModel(
      id:document.id,
        name: data["Name"], 
        location: data["Location"], 
        image: data["Image"],
        typeId: data["TypeID"],

        );
  }
}
