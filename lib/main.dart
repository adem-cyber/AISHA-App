import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/home/food/food_detail.dart';
import 'package:flutter_application_1/pages/home/food/recommanded_food_detail.dart';
import 'package:flutter_application_1/pages/home/food_page_body.dart';
import 'package:flutter_application_1/pages/home/main_food_page.dart';
import 'package:flutter_application_1/pages/shop/food_shop/food_shop_page.dart';
import 'package:flutter_application_1/pages/shop/food_shop/food_store_list.dart';
import 'package:flutter_application_1/routes/route_helper.dart';
import 'package:get/get.dart';
import 'controller/food_shop_controller.dart';
import 'controller/product_controller.dart';
import 'helper/dependencies.dart' as dep;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dep.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Get.find< ProductController>().getProductList();
    Get.find< FoodShopController>().getFoodShopList();
    return  GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      
      home: const FoodStoreList(),
      initialRoute: RouteHelper.initial,
      getPages: RouteHelper.routes,
    );
  }
}
