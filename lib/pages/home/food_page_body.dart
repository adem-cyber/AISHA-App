
import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/shop/Grocery_shop/grocery_shop_page.dart';
import 'package:flutter_application_1/pages/shop/food_shop/food_shop_page.dart';
//import 'package:flutter_application_1/controller/product_controller.dart';
import 'package:flutter_application_1/utils/colors.dart';
import 'package:flutter_application_1/utils/dimensions.dart';
import 'package:flutter_application_1/widgets/app_column.dart';
import 'package:flutter_application_1/widgets/big_text.dart';
import 'package:flutter_application_1/widgets/icon_and_text.dart';
import 'package:flutter_application_1/widgets/small_text.dart';
import 'package:get/get.dart';

import '../../widgets/category_icon.dart';

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
         SizedBox(
          height:Dimensions.height20,
          ),
          // Category Icons
          Positioned(
                top: Dimensions.screenHeight/4, // Adjust this value as needed
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                     GestureDetector(
                    onTap: () {
                      Get.to(()=>const FoodShopPage());
                     },
                    child:  const CategoryIcon(icon: Icons.restaurant, text: 'Restaurant')),
                    SizedBox(width: Dimensions.width30),
                    GestureDetector(
                    onTap: () {
                      Get.to(()=>const GroceryShopPage());
                     },
                    child: const CategoryIcon(icon: Icons.local_grocery_store, text: 'Grocery')),
                    SizedBox(width: Dimensions.width30),
                    const CategoryIcon(icon: Icons.important_devices_outlined, text: 'Tech'),
                    SizedBox(width: Dimensions.width30),
                    const CategoryIcon(icon: Icons.medical_services, text: 'Drug'),
                  ],
                ),
              ),
        

       SizedBox(
          height:Dimensions.height20,),
         
      
      //popular text
      SizedBox(height: Dimensions.height30,),
      Container(
        margin: EdgeInsets.only(left: Dimensions.width30),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            BigText(text: "Popular"),
            SizedBox(width: Dimensions.width10,),
            Container(
              margin: const EdgeInsets.only(bottom: 3),
              child: BigText(text: ".",color: Colors.black26,),

            ),
            SizedBox(width: Dimensions.width10,),
            Container(
              margin: const EdgeInsets.only(bottom: 2),
              child: SamllText(text: "Popular Item"),

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
                      color: const Color.fromARGB(255, 220, 240, 240),
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
            );
           },
           ),
         

      
      ]
    );

  }
  Widget _buildPageItem(int index){
   
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
       Container(
        height: Dimensions.PageViewContainer,
        margin:  EdgeInsets.only(left: Dimensions.width10, right:Dimensions.width10 ),
        decoration: BoxDecoration(
          borderRadius:BorderRadius.circular(Dimensions.radius30),
            color:index.isEven? const Color(0xFF69c5df) : const Color(0xFF9294cc),
            image: const DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage('assets/images/food.png')
    
            )
    
    
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
            
            child: const AppColumn(text: "zambia side"),
          ),
       ),
         
       ) , 
        
        
        ],
    
      ),
    );
  }
}


