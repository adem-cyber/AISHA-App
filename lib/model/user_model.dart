
import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String? id;
  final String name;
  final String email;
  final String phone;
  final String password;

  UserModel({
    this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.password,
  });
  toJson() {
    return {
      "Name": name,
      "Email": email,
      "Phone": phone,
      "password": password,
    };
  }

  factory UserModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return UserModel(
      id:document.id,
        name: data["Name"], 
        email: data["Email"], 
        phone: data["Phone"], 
        password: data["password"],
        );
  }
}
