import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/account/sign_up.dart';
import 'package:get/get.dart';

import '../../utils/colors.dart';
import '../../utils/dimensions.dart';
import '../../widgets/big_text.dart';
import '../account/sign_in.dart';

class FrontPage extends StatelessWidget {
  const FrontPage({super.key});

  @override
  Widget build(BuildContext context) {
   
  
    return Scaffold(
        backgroundColor: AppColors.mainColor,
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
                        text: "Welcome To IIYISHA",
                        size: Dimensions.font20 + Dimensions.font20 / 4,
                        color: Colors.white,
                      ),
                    ),
              ),
              SizedBox(
                height: Dimensions.screenHeight * 0.35,
              ),
              
              Row(
                // mainAxisAlignment: MainAxisAlignment.
                
                children: [
                   SizedBox(
                width: Dimensions.screenHeight * 0.03,
              ),
                  GestureDetector(
                     onTap: () {
                      Get.to(()=>const SignInPage());
                    },
                    child: Container(
                      width: Dimensions.screenWidth / 3,
                      height: Dimensions.screenHeight / 15,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(Dimensions.radius30),
                        color: Colors.white,
                      ),
                      child: Center(
                        child: BigText(
                          text: "Sign In",
                          size: Dimensions.font20 + Dimensions.font20 / 4,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                width: Dimensions.screenHeight * 0.09,
              ),
                 
                  GestureDetector(
                    onTap: () {
                      Get.to(()=>const SignUpPage());
                    },
                    child: Container(
                      width: Dimensions.screenWidth / 3,
                      height: Dimensions.screenHeight / 15,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(Dimensions.radius30),
                        color: Colors.black,
                      ),
                      child: Center(
                        child: BigText(
                          
                             
                          text: "Sign Up",
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
            
            
            );
            
  }
}
