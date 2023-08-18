import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/home/home_page.dart';

import 'package:get/get.dart';

import '../../../utils/colors.dart';
import '../../../utils/dimensions.dart';
import '../../../widgets/app_icon.dart';
import 'grocery_shop_body.dart';

class  GroceryShopPage extends StatefulWidget {
  const  GroceryShopPage({super.key});

  @override
  State< GroceryShopPage> createState() => _GroceryShopPageState();
}

 
class _GroceryShopPageState extends State< GroceryShopPage> {
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
                  Get.to(()=>const HomePage());
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
                child:  Icon(Icons.search,color:Colors.white, size: Dimensions.iconSize24 ),
              )
              ),
            ],
          ),
        ),
           ),
           
          const Expanded(child: SingleChildScrollView(
            child:GroceryShopBody()
           ,)
          ),
        ],
      ),
    

     );
  }
}



