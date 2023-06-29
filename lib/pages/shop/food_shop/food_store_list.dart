import 'package:flutter/material.dart';
import 'package:flutter_application_1/routes/route_helper.dart';
import 'package:flutter_application_1/utils/colors.dart';
import 'package:flutter_application_1/widgets/app_icon.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../utils/dimensions.dart';
import '../../../widgets/big_text.dart';
import '../../../widgets/exandable_taxt_widget.dart';
import '../../../widgets/icon_and_text.dart';
import '../../../widgets/small_text.dart';
import '../../home/main_food_page.dart';

class FoodStoreList extends StatelessWidget {
  const FoodStoreList ({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            toolbarHeight: 70,
            title:  Row(
              mainAxisAlignment:MainAxisAlignment.spaceBetween,
              children: [
                 GestureDetector(
                    onTap: () {
                      Get.toNamed(RouteHelper.getfoodShop());
                    },
                    child:
                      const AppIcon(icon: Icons.arrow_back_ios_new_sharp)),
                
                
                AppIcon(icon: Icons.shopping_cart),

              ],
            ),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(40),
              child: Container(
                
                width: double.maxFinite,
                padding: const EdgeInsets.only(top: 5,bottom: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(Dimensions.radius20),
                    topRight: Radius.circular(Dimensions.radius20),

                  )
                ),
                child: Center(child: BigText(size:Dimensions.font26, text:"Sliver App Bar") ),
              ),
               ),
            pinned: true,
            backgroundColor: AppColors.yellowcolor,
            expandedHeight: 300,
            flexibleSpace: FlexibleSpaceBar(
              background:Image.asset("assets/images/store1.jpeg",width: double.maxFinite,fit: BoxFit.cover,),
              

             ),
          ),
           SliverToBoxAdapter(
            
            child: Column(
              children: [
                Container(
                   child: ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
    itemCount: 10,
    itemBuilder: (context, index) {
      return GestureDetector(
        onTap: () {
                Get.toNamed(RouteHelper.getfoodDetail(index),);
        },
        child: Container(
          margin: EdgeInsets.only(left: Dimensions.width20, right: Dimensions.width20, bottom:  Dimensions.height10),
          child: Row(
            children: [
              Container(
                width: Dimensions.ListViewImgSize,
                height: Dimensions.ListViewImgSize,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.width20),
                  color: Colors.amber[300],
                  image: const DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage('assets/images/food3.jpg'),
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
                        color: const Color.fromARGB(255, 220, 240, 240),
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
              ),
      );
           },
           ),
                  
                ),
              ],
            ) ,
            ),
          
        ],
      ),
    bottomNavigationBar: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
       Container(
        padding: EdgeInsets.only(
          left: Dimensions.width20*2.5,
          right: Dimensions.width20*2.5,
          top: Dimensions.height10,
          bottom: Dimensions.height10,

        ),
        
         child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppIcon(iconColor: Colors.white,  backgroundColor: AppColors.mainColor, icon: Icons.remove, size: Dimensions.iconSize25, ),
              SizedBox(width: Dimensions.width10,),
               BigText(text: "\$12.88 "+" X "+" 0 ",color: AppColors.mainBlackcolor,size: Dimensions.font16,),
               SizedBox(width: Dimensions.width10,),
              AppIcon(iconColor: Colors.white,  backgroundColor: AppColors.mainColor, size: Dimensions.iconSize25, icon: Icons.add,),
             
       
            ],
          ),
       ),

        Container(
        height: Dimensions.bottomHeightbar,
        padding: EdgeInsets.only(top: Dimensions.height30 , bottom: Dimensions.height30, left: Dimensions.width30, right: Dimensions.width30 ),
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
               child: const Icon(
                Icons.favorite,
                color: AppColors.mainColor,
               ),
            ),
            Container(
              padding: EdgeInsets.only(top:Dimensions.height15, bottom: Dimensions.height15, left: Dimensions.width20,right: Dimensions.width20, ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.radius20),
                color: AppColors.mainColor
              ),
              
              child:BigText(text: "\$10|Add to cart", color: Colors.white,),
            )
          ],

        ),


      ),

      ],
      ),
    
    );

  }
}