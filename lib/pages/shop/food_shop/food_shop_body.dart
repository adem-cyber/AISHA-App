
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/product_controller.dart';
import 'package:flutter_application_1/routes/route_helper.dart';
import 'package:flutter_application_1/utils/colors.dart';
import 'package:flutter_application_1/utils/dimensions.dart';
import 'package:flutter_application_1/widgets/app_column.dart';
import 'package:flutter_application_1/widgets/big_text.dart';
import 'package:flutter_application_1/widgets/icon_and_text.dart';
import 'package:flutter_application_1/widgets/small_text.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

import '../../../widgets/app_icon.dart';
import '../../home/main_food_page.dart';

class FoodShopBody extends StatefulWidget {
  const FoodShopBody({super.key});

  @override
  State<FoodShopBody> createState() => _FoodShopBodyState();
}

class _FoodShopBodyState extends State<FoodShopBody> {

 
  @override
  Widget build(BuildContext context) {
    return Column(
      
      children: [
        
      //FOOD STORE text
      SizedBox(height: Dimensions.height30,),
      Container(
        margin: EdgeInsets.only(left: Dimensions.width30),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            BigText(text: "FOOD STORES"),
            SizedBox(width: Dimensions.width10,),
            Container(
              margin: const EdgeInsets.only(bottom: 3),
              child: BigText(text: ".",color: Colors.black26,),

            ),
            SizedBox(width: Dimensions.width10,),
            Container(
              margin: const EdgeInsets.only(bottom: 2),
              child: SamllText(text: "Popular Shops"),

            ),

          ],
        ),
      ),



      //list of food and images
     ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
    itemCount: 10,
    itemBuilder: (context, index) {
      return Container(
        margin: EdgeInsets.only(left: Dimensions.width20, right: Dimensions.width20, bottom:  Dimensions.height10),
        child: Row(
          children: [
            GestureDetector(
              onTap: () {
                Get.toNamed(RouteHelper.getfoodstore());
              },
              child: Container(
                width: Dimensions.ListViewImgSize,
                height: Dimensions.ListViewImgSize,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.width20),
                  color: Colors.amber[300],
                  image: const DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage('assets/images/store1.jpeg'),
                  ),
                ),
                
                    ),
            ),
                  //text container
                  Expanded(
                    child: Container(
                    height: Dimensions.ListViewTextsize,
                    
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topRight :Radius.circular( Dimensions.radius30),
                        bottomRight: Radius.circular( Dimensions.radius30),
                      ),
                      color: Color.fromARGB(255, 220, 240, 240),
                    ),
                    child: Padding(
                      padding:EdgeInsets.only(left: Dimensions.width10,right: Dimensions.width10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          BigText(text: "Stores",size:15,),
                          SizedBox(height: Dimensions.height10,),
                          SamllText(text: "it is good order today!!"),
                          SizedBox(height: Dimensions.height10,),

                           Row(
                  children: [
                    Wrap(
                      children: List.generate(5, (index) => const Icon(Icons.star,color: AppColors.mainColor,size: 10,)),
                    ),
                     SizedBox(width: Dimensions.height10,),
                    SamllText(text: "4.5"),
                    SizedBox(width: Dimensions.height10,),
                    SamllText(text: '1287'),
                    SizedBox(width: Dimensions.height10,),
                    SamllText(text: "comments"),
                  ],
                ),
                SizedBox(height: Dimensions.height10,),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                
                children: [
                IconAndTextWidget(icon: Icons.circle_sharp, text: "Normal",  iconColor:AppColors.iconcolor1),
                IconAndTextWidget(icon: Icons.location_on, text: "1.5km",  iconColor:AppColors.mainColor),
                IconAndTextWidget(icon: Icons.access_time_rounded, text: "Normal",  iconColor:AppColors.iconcolor2),

                ],
              )
                        ],

                      ),
                       ),
                  ),
      
                  ),
                ],
              ),
            );
           },
           ),
         

      ],
      
    );

  }
 
}
