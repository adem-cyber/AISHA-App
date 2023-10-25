
import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String? id;
  final String name;
  final String email;
  final String phone;
 
  late final String? address;
  String verificationId;
  

  UserModel({
    this.id,
    required this.name,
    required this.email,
    required this.phone,
    
    this.address,
     this.verificationId = '',
  });
 Map<String, dynamic>toJson() {
    return {
      "Name": name,
      "Email": email,
      "Phone": phone,
      
      "Address": address,
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
        address: data["Address"],
        );
  }
   void updateAddress(String newAddress) {
    // Update the address with the new location string
    address = newAddress;
  }
  

}
