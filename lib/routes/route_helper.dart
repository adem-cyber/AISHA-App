import 'package:flutter_application_1/pages/home/food/food_detail.dart';
import 'package:flutter_application_1/pages/home/main_food_page.dart';
import 'package:flutter_application_1/pages/shop/food_shop/food_shop_page.dart';
import 'package:flutter_application_1/pages/shop/food_shop/food_store_list.dart';
import 'package:get/get.dart';

class RouteHelper{
  static const String initial="/";
  static const String foodDetail="/food-detail";
  static const String foodShop="/food-shop";
  static const String foodstore="/food-store";
   
  
  static  String getinitial()=>"$initial";
  static String getfoodDetail(int pageId)=>"$foodDetail?pageId=$pageId"; 
  static String  getfoodShop()=>'$foodShop';
  static String  getfoodstore()=>'$foodstore';



  static List<GetPage> routes=[
    GetPage(name: "/", page: ()=>const MainFoodPage()),


    GetPage(name: "/food-detail", page: (){

      var pageId=Get.parameters['pageId'];
        return  FoodDetail(pageId:int.parse(pageId!));
        },
        transition: Transition.native
        ),

    GetPage(name: "/food-shop", page: () {
      
       return const FoodShopPage();
},
        transition: Transition.native

),

    GetPage(name: "/food-store", page: () { 
      
      return const FoodStoreList();
    
    },
        transition: Transition.native

    ),

  ];
}