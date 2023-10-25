import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/model/products_model.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class ProductsRepo extends GetxController{
  static ProductsRepo get instance=> Get.find();

  final _db = FirebaseFirestore.instance;


 Future<ProductsModel> getProductDetails(String phone) async{
    final snapshot = await _db.collection("Users" ).where("Phone", isEqualTo: phone).get(); 
    final productsData = snapshot.docs.map((e)=>ProductsModel.fromSnapshot(e)).single;
    return productsData;
  }
   Future<List<ProductsModel>> getallProduct() async{
    final snapshot = await _db.collection("Products").get(); 
    final productsData =    snapshot.docs.map((e)=>ProductsModel.fromSnapshot(e)).toList();
    return productsData;
  }
Future<List<ProductsModel>> getallProductG() async{
    final snapshot = await _db.collection("Products").get(); 
    final productsData =    snapshot.docs.map((e)=>ProductsModel.fromSnapshot(e)).toList();
    return productsData;

}
}