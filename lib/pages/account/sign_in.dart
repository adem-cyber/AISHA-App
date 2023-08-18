
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/account/sign_up.dart';
import 'package:flutter_application_1/pages/home/home_page.dart';
import 'package:flutter_application_1/utils/colors.dart';
import 'package:get/get.dart';

import '../../controller/siginup_controller.dart';
import '../../utils/dimensions.dart';
import '../../widgets/big_text.dart';
import 'app_text_field.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
  final controller = Get.put(SignUpController());
  final formKey = GlobalKey<FormState>();
  var password =TextEditingController();
  
  var phone =TextEditingController();
  
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      body:SingleChildScrollView( 
        physics: const BouncingScrollPhysics(),
        child: Column(
        children:[
          SizedBox(height: Dimensions.screenHeight*0.15,), 
          const Center(
          child:CircleAvatar(
            backgroundColor: Colors.white,
            radius: 60,
            backgroundImage: AssetImage(
              "assets/images/logo.png"
            )
          )
          ),
           SizedBox(height: Dimensions.screenHeight*0.02,), 
          Center(
          child: Column(
            children: [
              Text(
                "Welcome",
                style:
                TextStyle(
                  fontSize: Dimensions.font16+Dimensions.font20/2,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  ),
                  )
            ],
          )
          ),

          SizedBox(height: Dimensions.screenHeight*0.01,),
          Column(
            children: [
              Text(
                "Sign Into Your Account",
                style:
                TextStyle(
                  fontSize: Dimensions.font20,
                  color: Colors.white,
               //   fontWeight: FontWeight.bold,
                  ),
                  )
            ],
          ),
          SizedBox(height: Dimensions.screenHeight*0.02,),
          AppTextField(textController:controller. phone, 
          
           hintText: "Phone",
           icon: Icons.phone),
           SizedBox(height:Dimensions.height20,),
           AppTextField(textController:controller. password, 
          
           hintText: "Password",
           icon: Icons.password_sharp),
          
           
           SizedBox(height: Dimensions.height20,),
            Container(
              margin: EdgeInsets.only(right: Dimensions.width20),
            child: Row (
            children: [
              Expanded(child: Container()),
              RichText( 
            text: TextSpan(
            
              text:"Forgot Password?",
              style: TextStyle(
                color: Colors.white,
                fontSize: Dimensions.font16,
              )
            )
            ),
           
            ],
            )
           ),
            
         SizedBox(height: Dimensions.screenHeight*0.02,),
         GestureDetector( 
          onTap: () {
            Get.to(()=> const HomePage());
         },
           child: Container(
            width: Dimensions.screenWidth/3,
                height: Dimensions.screenHeight/15,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.radius30),
                color: Colors.white,
              ),
              child: Center(
              child:BigText(
                text: "Sign In",
                size: Dimensions.font20+Dimensions.font20/2,
                color: Colors.black,
                ),
             ),
             ),
         ),
            SizedBox(height: Dimensions.screenHeight*0.05,),
            RichText( 
            text: TextSpan(
              text:"Don't have an account?",
              style: TextStyle(
                color:Colors.white,
                fontSize: Dimensions.font16,
              ),
              children: [
                TextSpan(
                  recognizer: TapGestureRecognizer()..onTap=()=>Get.to(()=>const SignUpPage(), transition: Transition.fade),
              text:" Create",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: const Color.fromARGB(255, 43, 22, 185),
                fontSize: Dimensions.font20,
              )
                )
              ]
            )
            ),
           
        ] 
        )
      )
    );
  
  }
}