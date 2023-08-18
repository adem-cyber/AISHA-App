import 'package:flutter/material.dart';

import 'package:flutter_application_1/pages/home/main_food_page.dart';
import 'package:flutter_application_1/utils/colors.dart';
import 'package:flutter_application_1/utils/dimensions.dart';
import 'package:flutter_application_1/widgets/app_column.dart';
import 'package:flutter_application_1/widgets/app_icon.dart';
import 'package:flutter_application_1/widgets/big_text.dart';
import 'package:flutter_application_1/widgets/exandable_taxt_widget.dart';
import 'package:get/get.dart';


class FoodDetail extends StatelessWidget {
 
  const FoodDetail({super.key });
  


  @override
  Widget build(BuildContext context) {
  
    
    
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 191, 97, 97),
      body: Stack(
        children: [
          //background image
          Positioned(
            left: 0,
            right: 0,
            child:Container(
              width: double.maxFinite,
              height: 350,
              decoration: const BoxDecoration(
                image: DecorationImage(
                 fit: BoxFit.cover,
                  image:AssetImage("assets/images/food1.jpeg"),
                   ),
              ),
            ),
             ),
             
             //icon widgets
             Positioned(
              top: Dimensions.height45,
              left:Dimensions.width20,
              right: Dimensions.width20,

              child:  Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.to(()=>const MainFoodPage());
                    },
                    child:
                      const AppIcon(icon: Icons.arrow_back_ios_new_sharp)),
                ]
              )
             )  ,     
                          const Stack(
                          children: [
                       AppIcon(icon: Icons.shopping_cart_outlined),
                       
                      Positioned(
                        right: 0, top: 0,
                        child:  AppIcon(icon: Icons.circle,size: 20,iconColor: Colors.transparent,backgroundColor: AppColors.mainColor,))
                       
                       
                     
                        
                     
                          ],
                        ),
                      
              //introduction
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                top: Dimensions.PopularFoodImgSize-20,
                child:Container(
                  padding: EdgeInsets.only(left: Dimensions.width20 , right: Dimensions.width20 , top: Dimensions.height20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(Dimensions.radius20),
                      topLeft: Radius.circular(Dimensions.radius20),

                      ),
                    color: Colors.white
                    
                  ),
                 
            child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const AppColumn(text:"zambia side"),
                SizedBox(height: Dimensions.height20,),
                BigText(text: "Introduce",),
                SizedBox(height: Dimensions.height20,),
                const Expanded(child: SingleChildScrollView(child: ExandableText(text: "Zambian cuisine, though varied, is mostly centered around nshima, a thick porridge made from mealie meal which is the country’s staple food. Nshima is rather bland on its own so the variety of Zambian food lies in the high number of dishes which are traditionally served alongside nshima.Zambian cuisine, though varied, is mostly centered around nshima, a thick porridge made from mealie meal which is the country’s staple food. Nshima is rather bland on its own so the variety of Zambian food lies in the high number of dishes which are traditionally served alongside nshima.Zambian cuisine, though varied, is mostly centered around nshima, a thick porridge made from mealie meal which is the country’s staple food. Nshima is rather bland on its own so the variety of Zambian food lies in the high number of dishes which are traditionally served alongside nshima.Zambian cuisine, though varied, is mostly centered around nshima, a thick porridge made from mealie meal which is the country’s staple food. Nshima is rather bland on its own so the variety of Zambian food lies in the high number of dishes which are traditionally served alongside nshima.")))
              ],
            )
    
          ),
        ),
        

        
      
      
           Container(
            height: Dimensions.bottomHeightbar,
            padding: EdgeInsets.only(top: Dimensions.height30 , bottom: Dimensions.height30, left: Dimensions.width20, right: Dimensions.width20 ),
            decoration: BoxDecoration(
              color:AppColors.buttonBackgroundcolor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(Dimensions.radius20*2),
                topRight: Radius.circular(Dimensions.radius20*2),

              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.only(top:Dimensions.height15, bottom: Dimensions.height15, left: Dimensions.width20,right: Dimensions.width20, ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.radius20),
                    color: Colors.white,

                   ),
                   child: Row(
                    children: [
                       GestureDetector(
                        onTap: (){
                  //        popularproduct.setQuantity(false);
                          
                        },
                        child: const Icon(Icons.remove,color: AppColors.signcolor,)),
                      SizedBox(width: Dimensions.width10/2,),
                 BigText(text: "habil"),
                      SizedBox(width: Dimensions.width10/2,),
                      GestureDetector(
                        onTap: (){
                //          popularproduct.setQuantity(true);
                          
                        },
                        child: const Icon(Icons.add,color: AppColors.signcolor,)),
                    ],
                   ),

                ),
                Container(
                  padding: EdgeInsets.only(top:Dimensions.height15, bottom: Dimensions.height15, left: Dimensions.width20,right: Dimensions.width20, ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.radius20),
                    color: AppColors.mainColor
                  ),
                  child: GestureDetector(
                    onTap: () {
                     // popularproduct.addItem(product);  
                      
                    },
                    child: BigText(text: "\$ 10 |Add to cart", color: Colors.white,)),
                )
              ],

            ),


          ),
          ]
          ),
    );
        }
        
      
    
  }


