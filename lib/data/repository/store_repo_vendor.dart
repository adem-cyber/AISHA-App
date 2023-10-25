import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/pages/vendor/home/store_model_vendor.dart';
import 'package:get/get.dart';


class StoreRepoVendor extends GetxController{
  static StoreRepoVendor get instance=> Get.find();

  final _db = FirebaseFirestore.instance;
//final storeRepo = StoreRepoVendor.instance;
  
   Future<List<StoreModelVendor>> getAllStore(String vendorid) async {
  final snapshot = await _db
      .collection("Grocery")
      .where("Vendor_id", isEqualTo: vendorid)
      .get();

  final storeData = snapshot.docs
      .map((e) => StoreModelVendor.fromSnapshot(e))
      .toList();

  return storeData;
}
Future<List<StoreModelVendor>> getStoreType(String type) async {
  final snapshot = await _db
      .collection("Grocery")
      .where("Type", isEqualTo: type)
      .get();

  final storeData = snapshot.docs
      .map((e) => StoreModelVendor.fromSnapshot(e))
      .toList();

  return storeData;
}
Future<List<StoreModelVendor>> getSearch(String search) async {
 
  final snapshot = await _db
      .collection("Grocery")
      .where("Name", isGreaterThanOrEqualTo: search)
      .where('Name', isLessThan: search + 'z')
      .get();

  final storeData = snapshot.docs
      .map((e) => StoreModelVendor.fromSnapshot(e))
      .toList();

  return storeData;


}
Future<List<StoreModelVendor>> getAllStoreuser() async{
    final snapshot = await _db.collection("Grocery").get(); 
    final productsData =    snapshot.docs.map((e)=>StoreModelVendor.fromSnapshot(e)).toList();
    return productsData;
}
Future<List<StoreModelVendor>> getStore(String storeid) async {
  final snapshot = await _db
      .collection("Grocery")
      .where("Store_id", isEqualTo: storeid)
      .get();

  final storeData = snapshot.docs
      .map((e) => StoreModelVendor.fromSnapshot(e))
      .toList();

  return storeData;
}
Future<void> deleteUser(String id) async {
  try {
    // Query for documents where 'Storeid' is equal to the provided 'storeid'
    final querySnapshot = await _db.collection("Grocery").where('Storeid', isEqualTo: id).get();

    // Loop through the query results and delete each document
    for (final doc in querySnapshot.docs) {
      await doc.reference.delete();
    }
  } catch (error) {
    // Handle any errors that may occur during the deletion process
    print("Error deleting user: $error");
  }
}
Future<void> deleteStore(String? id) async {
  
    final querySnapshot = await _db.collection('Grocery')
        .doc(id)
        .delete();

  
    
}
}