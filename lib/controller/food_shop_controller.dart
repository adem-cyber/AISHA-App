import 'package:flutter_application_1/data/repository/product_repo.dart';
import 'package:flutter_application_1/model/product_model.dart';
import 'package:get/get.dart';

import '../data/repository/food_shop_repo.dart';

class FoodShopController extends GetxController{
  final FoodShopRepo foodshopRepo;
 FoodShopController({required this.foodshopRepo});
  List<ProductModel> _foodshopList=[];
  List<ProductModel> get foodshopList => _foodshopList ;

   bool _isLoaded=false;
   bool get isLoaded=>_isLoaded;

  Future <void> getFoodShopList()async{
   Response response= await   foodshopRepo.getFoodShopList();
   if(response.statusCode==200){
    
    _foodshopList=[];
   _foodshopList.addAll(Product.fromJson(response.body).products);
   _isLoaded=true;
    update();

   }else{

   }

  }
}