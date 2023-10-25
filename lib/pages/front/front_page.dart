import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/account/sign_up.dart';
import 'package:flutter_application_1/pages/vendor/account/sign_in_vendor.dart';
import 'package:flutter_application_1/utils/colors.dart';
import 'package:get/get.dart';

import '../../utils/dimensions.dart';
import '../../widgets/big_text.dart';
import '../account/sign_in.dart';

class FrontPage extends StatelessWidget {
  const FrontPage({super.key});

  @override
  Widget build(BuildContext context) {
   
  
    return  Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
           image: AssetImage('assets/images/login.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(children: [
              SizedBox(
                height: Dimensions.screenHeight * 0.3,
              ),
              Container(
                  child: const Center(
                      child: CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 80,
                          backgroundImage:
                              AssetImage("assets/images/logo.png")))),
            SizedBox(
                height: Dimensions.screenHeight * 0.03,
              ),
              Container(
               child: Center(
                      child: BigText(
                        text: "Welcome To IIYISHHA",
                        size: Dimensions.font20 + Dimensions.font20 / 4,
                        color: AppColors.mainColor,
                      ),
                    ),
              ),
              SizedBox(
                height: Dimensions.screenHeight * 0.3,
              ),
              
              Row(
              
                
                children: [
                   SizedBox(
                width: Dimensions.screenHeight * 0.03,
              ),
                  GestureDetector(
                     onTap: () {
                      Get.to(()  => SignInPage());
                    },
                    child: Container(
                      width: Dimensions.screenWidth / 3,
                      height: Dimensions.screenHeight / 15,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(Dimensions.radius30),
                        color: AppColors.button2,
                      ),
                      child: Center(
                        child: BigText(
                          text: "Customer",
                          size: Dimensions.font20 + Dimensions.font20 / 4,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                width: Dimensions.screenHeight * 0.09,
              ),
                 
                  GestureDetector(
                    onTap: () {
                      Get.to(()  => SignInPageVendor());
                    },
                    child: Container(
                      width: Dimensions.screenWidth / 3,
                      height: Dimensions.screenHeight / 15,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(Dimensions.radius30),
                        color: AppColors.button3,
                      ),
                      child: Center(
                        child: BigText(
                          
                             
                          text: "Vendor",
                          size: Dimensions.font20 + Dimensions.font20 / 4,
                          color: Colors.white,
                        ), 
                       
                      ),
                                  
                    ),
                  )
                ]
                  ),
                
                ],
              )
           
            )
            
            
            ),
      );
  }
}
