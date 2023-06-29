import 'package:flutter/material.dart';
import 'package:flutter_application_1/utils/colors.dart';
import 'package:flutter_application_1/widgets/app_icon.dart';

import '../../../utils/dimensions.dart';
import '../../../widgets/big_text.dart';
import '../../../widgets/exandable_taxt_widget.dart';

class RecommenededFoodDetail extends StatelessWidget {
  const RecommenededFoodDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            toolbarHeight: 70,
            title: const Row(
              mainAxisAlignment:MainAxisAlignment.spaceBetween,
              children: [
                AppIcon(icon: Icons.clear),
                
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
              background:Image.asset("assets/images/food3.jpg",width: double.maxFinite,fit: BoxFit.cover,),
              

             ),
          ),
           SliverToBoxAdapter(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(left: Dimensions.radius20,right: Dimensions.radius20),
                  child: const ExandableText(text: " This is truly the ONLY rib recipe you will ever need. Ribs simply don't get any better than this! You'll need a fork and knife to eat these, as they will FALL OFF THE BONE. . .tastier than you can imagine. And they couldn't be easier, just throw them in the oven and you are good to go. . .just make sure you have some of your favorite BBQ sauce on hand! This is truly the ONLY rib recipe you will ever need. Ribs simply don't get any better than this! You'll need a fork and knife to eat these, as they will FALL OFF THE BONE. . .tastier than you can imagine. And they couldn't be easier, just throw them in the oven and you are good to go. . .just make sure you have some of your favorite BBQ sauce on hand! This is truly the ONLY rib recipe you will ever need. Ribs simply don't get any better than this! You'll need a fork and knife to eat these, as they will FALL OFF THE BONE. . .tastier than you can imagine. And they couldn't be easier, just throw them in the oven and you are good to go. . .just make sure you have some of your favorite BBQ sauce on hand! This is truly the ONLY rib recipe you will ever need. Ribs simply don't get any better than this! You'll need a fork and knife to eat these, as they will FALL OFF THE BONE. . .tastier than you can imagine. And they couldn't be easier, just throw them in the oven and you are good to go. . .just make sure you have some of your favorite BBQ sauce on hand! This is truly the ONLY rib recipe you will ever need. Ribs simply don't get any better than this! You'll need a fork and knife to eat these, as they will FALL OFF THE BONE. . .tastier than you can imagine. And they couldn't be easier, just throw them in the oven and you are good to go. . .just make sure you have some of your favorite BBQ sauce on hand! This is truly the ONLY rib recipe you will ever need. Ribs simply don't get any better than this! You'll need a fork and knife to eat these, as they will FALL OFF THE BONE. . .tastier than you can imagine. And they couldn't be easier, just throw them in the oven and you are good to go. . .just make sure you have some of your favorite BBQ sauce on hand!"
 ,),
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