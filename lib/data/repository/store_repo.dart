import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../../model/store_model.dart';

class StoreRepo extends GetxController{
  static StoreRepo get instance=> Get.find();

  final _db = FirebaseFirestore.instance;


 Future<StoreModel> getStoreDetails(String food) async{
    final snapshot = await _db.collection("Store" ).where("TypeID", isEqualTo: food).get(); 
    final storeData = snapshot.docs.map((e)=>StoreModel.fromSnapshot(e)).single;
    return storeData;
  }
   Future<List<StoreModel>> getAllStore() async{
    final snapshot = await _db.collection("Store").doc("mjeIFxXLrWkMqJ2TVuZq").collection("Restaurant").get(); 
    final storeData = snapshot.docs.map((e)=>StoreModel.fromSnapshot(e)).toList();
    return storeData;
  }
Future<List<StoreModel>> getAllStoreG() async{
    final snapshot = await _db.collection("Store" ).doc("mjeIFxXLrWkMqJ2TVuZq").collection("Grocery").get(); 
    final storeData = snapshot.docs.map((e)=>StoreModel.fromSnapshot(e)).toList();
    return storeData;
  }

}