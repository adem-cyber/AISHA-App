
import 'package:flutter_application_1/controller/cart_controller.dart';
import 'package:flutter_application_1/controller/product_controller.dart';
import 'package:flutter_application_1/data/repository/cart_repo.dart';
import 'package:flutter_application_1/data/repository/product_repo.dart';
import 'package:flutter_application_1/utils/app_constants.dart';
import 'package:get/get.dart';
import '../controller/food_shop_controller.dart';
import '../data/api/api_client.dart';
import '../data/repository/food_shop_repo.dart';

Future<void> init() async {
  // api
  Get.lazyPut(() => ApiClient(appBaseUrl: AppConstants.BASE_URL));

  // repo
  Get.lazyPut(() => ProductRepo(apiClient: Get.find()));
  Get.lazyPut(() => FoodShopRepo(apiClient: Get.find()));
  Get.lazyPut(() => CartRepo ());



  // controller
  Get.lazyPut(() => ProductController(productRepo: Get.find()));
  Get.lazyPut(() => FoodShopController(foodshopRepo: Get.find()));
  Get.lazyPut(() => CartController(cartRepo: Get.find()));

  

}
