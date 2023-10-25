import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/pages/vendor/home/products_model_vendor.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class ProductsRepoVendor extends GetxController{
  static ProductsRepoVendor get instance=> Get.find();

  final _db = FirebaseFirestore.instance;


 Future<ProductsModelVendor> getProductDetails(String phone) async{
    final snapshot = await _db.collection("Users" ).where("Phone", isEqualTo: phone).get(); 
    final productsData = snapshot.docs.map((e)=>ProductsModelVendor.fromSnapshot(e)).single;
    return productsData;
  }
   Future<List<ProductsModelVendor>> getallProduct() async{
    final snapshot = await _db.collection("Products").get(); 
    final productsData =    snapshot.docs.map((e)=>ProductsModelVendor.fromSnapshot(e)).toList();
    return productsData;
  }
Future<List<ProductsModelVendor>> getallProductG() async{
    final snapshot = await _db.collection("Products").get(); 
    final productsData =    snapshot.docs.map((e)=>ProductsModelVendor.fromSnapshot(e)).toList();
    return productsData;

}
Future<List<ProductsModelVendor>> getallGroceryUser(String storeid) async {
  final snapshot = await _db
      .collection("Products")
      .where("Storeid", isEqualTo: storeid)
      .where("Availability", isEqualTo: "Available")
      .get();

  final productsData =
      snapshot.docs.map((e) => ProductsModelVendor.fromSnapshot(e)).toList();

  return productsData;
}

Future<List<ProductsModelVendor>> getallGrocery(storeid) async{
    final snapshot = await _db.collection("Products").where("Storeid", isEqualTo: storeid).get(); 
    final productsData =    snapshot.docs.map((e)=>ProductsModelVendor.fromSnapshot(e)).toList();
    return productsData;

}
Future<void> updateProduct(String? id, ProductsModelVendor updatedProduct) async {
  try {
    await _db
        .collection('Products')
        .doc(id)
        .update(updatedProduct.toJson());
  } catch (e) {
    print('Error updating product: $e');
    // Handle any errors that may occur during the update operation
  }
}
Future<void> deleteProduct(String? id) async {
  
    final querySnapshot = await _db.collection('Products')
        .doc(id)
        .delete();

  
    
}

}