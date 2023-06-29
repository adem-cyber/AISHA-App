import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../utils/colors.dart';
import '../../../utils/dimensions.dart';
import '../../../widgets/app_icon.dart';
import '../../../widgets/big_text.dart';
import '../../../widgets/small_text.dart';
import '../../home/main_food_page.dart';
import 'food_shop_body.dart';

class  FoodShopPage extends StatefulWidget {
  const  FoodShopPage({super.key});

  @override
  State< FoodShopPage> createState() => _FoodShopPageState();
}

 
class _FoodShopPageState extends State< FoodShopPage> {
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: Column(
        children:[
           Container(
          
        child: Container(
          margin:  EdgeInsets.only(top:Dimensions.height45,bottom: Dimensions.height15),
          padding:  EdgeInsets.only(left: Dimensions.width20, right: Dimensions.width20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                 GestureDetector(
                 onTap: () {
                  Get.to(() => const MainFoodPage());
                    },
                   child: const AppIcon(
                                icon: Icons.arrow_back_ios_new_sharp,
                           backgroundColor: AppColors.mainColor,
                           iconColor: Colors.white,
                                            ),
                                    ),
                  
      
                ],
              ),
              
              Center(
              child:Container(
                width: Dimensions.height45,
                height: Dimensions.height45,
                decoration:BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radius15),
                  color: AppColors.mainColor, 

                ),
                child:  Icon(Icons.search,color:Colors.white, size: Dimensions.iconSize25 ),
              )
              ),
            ],
          ),
        ),
           ),
           
          const Expanded(child: SingleChildScrollView(
            child:FoodShopBody()
           ,)
          ),
        ],
      ),
    

     );
  }
}



