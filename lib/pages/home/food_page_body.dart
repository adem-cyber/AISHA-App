
import 'dart:ffi';

import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/product_controller.dart';
import 'package:flutter_application_1/model/product_model.dart';
import 'package:flutter_application_1/pages/home/food/food_detail.dart';
import 'package:flutter_application_1/routes/route_helper.dart';
import 'package:flutter_application_1/utils/app_constants.dart';
import 'package:flutter_application_1/utils/colors.dart';
import 'package:flutter_application_1/utils/dimensions.dart';
import 'package:flutter_application_1/widgets/app_column.dart';
import 'package:flutter_application_1/widgets/big_text.dart';
import 'package:flutter_application_1/widgets/icon_and_text.dart';
import 'package:flutter_application_1/widgets/small_text.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

class FoodPageBody extends StatefulWidget {
  const FoodPageBody({super.key});

  @override
  State<FoodPageBody> createState() => _FoodPageBodyState();
}

class _FoodPageBodyState extends State<FoodPageBody> {
  PageController pageController = PageController(viewportFraction: 0.85);
  var currPageValue=0.0;
  double scaleFactor=0.8;
  double height= Dimensions.PageViewContainer;
  

  @override
  void initState(){
    super.initState();
    pageController.addListener(() {
      
      setState(() {
        currPageValue=pageController.page!;
        
      });
    });

  }
 @override
 void dispose(){
   super.dispose();
  pageController.dispose();

 } 
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //slider section
        GetBuilder<ProductController>
          (builder: (popularproduct) {
            return /*popularproduct.isLoaded? */SizedBox(
     // color: Colors.blueGrey,
      height:Dimensions.PageView,
      
        
        child: PageView.builder(
              controller: pageController,
              itemCount: popularproduct.productList.length,
              itemBuilder: (context , position){
        return _buildPageItem(position,popularproduct.productList[position]);
          }),
      
            );/*:const CircularProgressIndicator(color: AppColors.mainColor,);*/
            
          }
        ),
        GetBuilder<ProductController>
          (builder: (popularproduct) {
            return DotsIndicator(
     dotsCount: popularproduct.productList.isEmpty?1:popularproduct.productList.length,
  position: currPageValue,
  decorator: const DotsDecorator(
    color: Colors.black87, // Inactive color
    activeColor: AppColors.mainColor,
  ),
);
          }
        ),
      //popular text
     SizedBox(height: Dimensions.height30,),
Container(
  margin: EdgeInsets.only(left: Dimensions.width30),
  child: Row(
    crossAxisAlignment: CrossAxisAlignment.end,
    children: [
      BigText(text: "STORES"),
      SizedBox(width: Dimensions.width30,),
      
       GestureDetector(
        onTap:() {
          Get.toNamed(RouteHelper.foodShop);
        },
      child: const Icon(Icons.fastfood_sharp, color: AppColors.mainColor,)), // Add your first icon here
           SizedBox(width: Dimensions.width30,),
       Container(margin: const EdgeInsets.only(bottom: 3),
        child: BigText(text: ".", color: Colors.black26),),
      SizedBox(width: Dimensions.width30,),
        
      const Icon(Icons.local_grocery_store, color: AppColors.mainColor), // Add your second icon here
      SizedBox(width: Dimensions.width30,),
       Container(margin: const EdgeInsets.only(bottom: 3),
        child: BigText(text: ".", color: Colors.black26),),
      SizedBox(width: Dimensions.width30,),

      const Icon(Icons.important_devices_outlined, color: AppColors.mainColor), // Add your third icon here
      SizedBox(width: Dimensions.width30,),
     
    ],
  ),
),

      //list of food and images
     ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
    itemCount: 10,
    itemBuilder: (context, index) {
      return GestureDetector(
        onTap: () {

          Get.toNamed(RouteHelper.getfoodDetail(index));
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
              image: AssetImage('assets/images/food.png'),
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
                            BigText(text: "Vegetables",size:15,),
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
         

      ],
      
    );

  }
  Widget _buildPageItem(int index, ProductModel popularproduct){
   
   Matrix4 matrix = Matrix4.identity();
   if(index==currPageValue.floor()){
    var  currScale= 1-(currPageValue-index)*(1-scaleFactor);
    var  currTrans = height*(1-currScale)/2;
    matrix =Matrix4.diagonal3Values(1, currScale, 1)..setTranslationRaw(0, currTrans, 0);

   }else if (index == currPageValue.floor()+1){
    var currScale = scaleFactor+(currPageValue-index+1)*(1-scaleFactor); 
    var  currTrans = height*(1-currScale)/2;
    matrix =Matrix4.diagonal3Values(1, currScale, 1);
    matrix =Matrix4.diagonal3Values(1, currScale, 1)..setTranslationRaw(0, currTrans, 0);

   }else if (index == currPageValue.floor()-1){
    var  currScale= 1-(currPageValue-index)*(1-scaleFactor);
    var  currTrans = height*(1-currScale)/2;
    matrix =Matrix4.diagonal3Values(1, currScale, 1);
    matrix =Matrix4.diagonal3Values(1, currScale, 1)..setTranslationRaw(0, currTrans, 0);
   }else{
    var currScale=0.8;
    matrix =Matrix4.diagonal3Values(1, currScale, 1)..setTranslationRaw(0, height*(1-currScale)/2, 0);
   }
   
   
    return Transform(
      transform: matrix,
      child: Stack(
        children:[
       GestureDetector(
        onTap: () {

          Get.toNamed(RouteHelper.getfoodDetail(index));
        },
         child: Container(
          height: Dimensions.PageViewContainer,
          margin:  EdgeInsets.only(left: Dimensions.width10, right:Dimensions.width10 ),
          decoration: BoxDecoration(
            borderRadius:BorderRadius.circular(Dimensions.radius30),
              color:index.isEven? const Color(0xFF69c5df) : const Color(0xFF9294cc),
              image:  DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage( 
                AppConstants.BASE_URL+"/uplosds/"+ popularproduct.img!,
                )
           
              )
           
           
            ),
            
         ),
       ),
       Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          height: Dimensions.PageTextContainer,
        margin:  EdgeInsets.only(left: Dimensions.width30, right: Dimensions.width30 ,bottom: Dimensions.height30 ),
        decoration: BoxDecoration(
          borderRadius:BorderRadius.circular(Dimensions.radius20),
            color: Colors.white,
            boxShadow: const [
              BoxShadow(
                color: Color (0xFFe8e8e8),
                blurRadius: 3.0,
                offset: Offset(0,5)
              ),
              BoxShadow(
                color: Colors.white,
                offset: Offset(-5, 0)
              ),
              BoxShadow(
                color: Colors.white,
                offset: Offset(5, 0),
              )
            ]
    
          ),
          child: Container(
            padding:  EdgeInsets.only(top:Dimensions.height15, left:Dimensions.height15 , right: Dimensions.height15,),
            
            child:  AppColumn(text: popularproduct.name!),
          ),
       ),
         
       ) , 
        
        
        ],
    
      ),
    );
  }
}


