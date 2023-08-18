import 'package:flutter/material.dart';
import 'package:flutter_application_1/utils/dimensions.dart';
import 'package:flutter_application_1/widgets/big_text.dart';
import 'package:flutter_application_1/widgets/small_text.dart';
import '../../utils/colors.dart';
import 'food_page_body.dart';

class  MainFoodPage extends StatefulWidget {
  const  MainFoodPage({super.key});

  @override
  State< MainFoodPage> createState() => _MainFoodPageState();
}

 
class _MainFoodPageState extends State< MainFoodPage> {
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      backgroundColor:const Color.fromARGB(255, 255, 255, 255),
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
                  BigText(text: "Zambia",color:AppColors.mainColor , ),
                  Row(
                    children: [
                
                      SamllText(text:"Monze", color: Colors.black54, ),
                      const Icon(Icons.arrow_drop_down_rounded)

                    ],
                  )
      
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
           child:FoodPageBody()
         ,)
         )
        ],
      ),
    

     );
  }
}



