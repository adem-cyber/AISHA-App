import 'package:cloud_firestore/cloud_firestore.dart';

class StoreModelVendor{
  final String? id;
  final String name;
  final String location;
  final String image;
  final String? description;
  final String? storeid;
  final String? email;
  final String? phone;
  final String vendorid;
  final String? type;
 // final String typeId;

  StoreModelVendor({
    this.id,
    required this.name,
    required this.location,
    required this.image,
     this.description,
    this.email,
    this.phone,
     this.storeid,
     required  this.vendorid,
     this.type,
    //required this.typeId ,

  });
  toJson() {
    return {
      "Name": name,
      "Location": location,
      "Description": description ?? "",
      "ImageURL": image,
      "Phone": phone ?? "",
      "Store_id": storeid,
      "Email ": email,
      "Type":type,
    };
  }

  factory StoreModelVendor.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return StoreModelVendor(
      id:document.id,
        name: data["Name"], 
        location: data["Location"], 
        image: data["ImageURL"],
        description: data["Description"],
        storeid: data["Store_id"],
        email: data["Email"],
       phone: data["Phone"],
       vendorid:data["Vendor_id"],
       type: data["Type"]
     //   typeId: data["TypeID"],

        );
  }
}
