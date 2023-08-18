import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/cart_controller.dart';

import 'package:flutter_application_1/utils/colors.dart';
import 'package:flutter_application_1/utils/dimensions.dart';
import 'package:flutter_application_1/widgets/app_icon.dart';
import 'package:flutter_application_1/widgets/big_text.dart';
import 'package:flutter_application_1/widgets/small_text.dart';
import 'package:get/get.dart';

import '../home/home_page.dart';

class CartPage extends StatelessWidget {
   final CartController cartController = Get.put(CartController()); 


  final CartRepo  = Get.find();

  CartPage({super.key});
  
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Stack(
        children: [

          Positioned(
            left: Dimensions.width20,
            right: Dimensions.width20,
            top: Dimensions.height20*2,

            child:Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppIcon(icon: Icons.arrow_back_ios,iconColor: Colors.white,iconsize: Dimensions.iconSize24,backgroundColor: AppColors.mainColor, ),
                SizedBox(width:Dimensions.width20*5 ,),
                GestureDetector(
                  onTap: () {
                    Get.to (() => const HomePage());
                  },
                  child: AppIcon(icon: Icons.home_outlined,iconColor: Colors.white,iconsize: Dimensions.iconSize24,backgroundColor: AppColors.mainColor, )),
                AppIcon(icon: Icons.shopping_cart_outlined,iconColor: Colors.white,iconsize: Dimensions.iconSize24,backgroundColor: AppColors.mainColor, ),

              ],


            )
             ),
             
               Positioned(
              top: Dimensions.height20*5,
              left: Dimensions.width20,
              right: Dimensions.width20,
              bottom: 0,
          
              child: Container(
                margin: EdgeInsets.only(top: Dimensions.height15),
               // color: Colors.amber,
                child: MediaQuery.removePadding (
                  context: context,
                  removeTop: true,
                 
                   child: ListView.builder(
            itemCount: cartController.products.length,
            itemBuilder: (context, index) {
              final productEntry = cartController.products.entries.elementAt(index);
              final product = productEntry.key;
              final quantity = productEntry.value;
                        return CartRepo(
                            height: 100,
                            width: double.maxFinite,
                            child: Row(
                              children: [
                                Container(
                                  width: Dimensions.height20*5,
                                  height: Dimensions.height20*5,
                                  margin: EdgeInsets.only(bottom: Dimensions.height10),
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage( product.image),
                                      ),
                                    borderRadius: BorderRadius.circular(Dimensions.radius20),
                                    color: Colors.blue
                                  ),
                                  
                                ),
                                SizedBox(width: Dimensions.width10,),
                                Expanded(
                                  child: SizedBox(
                                  height: Dimensions.height20*5,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      BigText(text: product.name, color: Colors.black54, ),
                                      SamllText(text: product.description),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                        BigText(text:" ZMK ${product.price} ", color: Colors.redAccent, ),
                                        Container(
                        padding: EdgeInsets.only(top:Dimensions.height10, bottom: Dimensions.height10, left: Dimensions.width10,right: Dimensions.width10, ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(Dimensions.radius20),
                          color: Colors.white,
                    
                         ),
                         child: Row(
                          children: [
                             GestureDetector(
                              onTap: (){
                                //cartController.addItem(_cartList[index].product!,-1)
                                
                              },
                              child: const Icon(Icons.remove,color: AppColors.signcolor,)),
                            SizedBox(width: Dimensions.width10/2,),
                            BigText(text:"0" ),//_cartList[index].quantity.toString()),
                            SizedBox(width: Dimensions.width10/2,),
                            GestureDetector(
                              onTap: (){
                                //cartController.addItem(_cartList[index].product!,1)
                                
                                
                              },
                              child: const Icon(Icons.add,color: AppColors.signcolor,)),
                          ],
                         ),
                    
                      ),
                                      
                                        ],
                                      )
                    
                                    ],
                    
                    
                                  ),
                    
                    
                    
                    
                                ),
                                
                                ),
                    
                    
                              ],
                              ),
                    
                                  
                                  
                        );
                                  
                        }
                         ),
                  
             
                ),
              ),
               
               ),

            
            
      
    
            
     /*  bottomNavigationBar: GetBuilder<CartController>(
        builder: (cartController) {
          return Container(
            height: Dimensions.bottomHeightbar,
            padding: EdgeInsets.only(top: Dimensions.height20 , bottom: Dimensions.height20, left: Dimensions.width20, right: Dimensions.width20 ),
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
                   
                      SizedBox(width: Dimensions.width10/2,),
                      BigText(text: "\$" ),
                      SizedBox(width: Dimensions.width10/2,),
                     
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
                    child: BigText(text:  " Check Out", color: Colors.white,)),
                )
              ],

            ),


          );
        }
      ),*/
        ]
      )
    );
  }
}