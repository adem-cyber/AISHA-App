import 'package:flutter_application_1/data/repository/store_repo.dart';
import 'package:get/get.dart';

class StoreController extends GetxController{
  static StoreController get instance => Get.find();
   
   
   final _storeRepo = Get.put(StoreRepo());


    
  getStoreData() {
    

  }
  }