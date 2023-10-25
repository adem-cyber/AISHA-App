import 'package:cloud_firestore/cloud_firestore.dart';

class UserModelVendor {
  final String? id;
  final String name;
  final String email;
  final String phone;
  final String password;
  final String vendorid;
  late final String? address;
 

  UserModelVendor({
    this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.password,
    required this.vendorid,
    this.address,
   
  });

  Map<String, dynamic> toJson() {
    return {
      "Name": name,
      "Email": email,
      "Phone": phone,
      "password": password,
      "Address": address,
      "VendorID": vendorid,
    };
  }

  factory UserModelVendor.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return UserModelVendor(
      id: document.id,
      name: data["Name"],
      email: data["Email"],
      phone: data["Phone"],
      password: data["password"],
      address: data["Address"],
      vendorid: data["VendorID"],
    );
  }
  void updateAddress(String newAddress) {
    // Update the address with the new location string
    address = newAddress;
  }
}
