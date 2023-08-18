
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/account/sign_in.dart';
import 'package:flutter_application_1/utils/colors.dart';
import 'package:get/get.dart';

import '../../controller/siginup_controller.dart';
import '../../model/user_model.dart';
import '../../utils/dimensions.dart';
import '../../widgets/big_text.dart';
import 'app_text_field.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
  final controller = Get.put(SignUpController());
  final formKey = GlobalKey<FormState>();
  var email =TextEditingController();
  var password =TextEditingController();
  var name =TextEditingController();
  var phone =TextEditingController();
  var signupimages = [
    "google.png",
    "facebook.png",
    "twitter.png"
  ];
    return Scaffold(
      backgroundColor:   AppColors.mainColor,
      body:SingleChildScrollView( 
        physics: const BouncingScrollPhysics(),
        child: Form(
          key: formKey ,
          child: Column(
          children:[
            SizedBox(height: Dimensions.screenHeight*0.09,), 
            const Center(
            child:CircleAvatar(
              backgroundColor: AppColors.mainColor,
              radius: 60,
              backgroundImage: AssetImage(
                "assets/images/logo.png"
              )
            )
            ),
             SizedBox(height: Dimensions.screenHeight*0.01,),
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
            SizedBox(height: Dimensions.screenHeight*0.04,),
            Center(
                     child: BigText(
                       text: "Create your account",
                       size: Dimensions.font20,
                       color: Colors.white,
                     ),
                   ),
             SizedBox(height: Dimensions.screenHeight*0.02,),
             
             AppTextField(textController:controller.name, 
             hintText: "Name",
             icon: Icons.person),
             SizedBox(height:Dimensions.height20,),
           
             AppTextField(textController:controller.phone, 
             hintText: "Phone",
             icon: Icons.phone),
             SizedBox(height:Dimensions.height20,),
               
            AppTextField(textController:controller.email,    
             hintText: "Email",
             icon: Icons.email),
             SizedBox(height:Dimensions.height20,),
            
             AppTextField(textController: controller.password,    
             hintText: "Password",
             icon: Icons.password_sharp),
             SizedBox(height:Dimensions.height20,),
             
           
             
          GestureDetector(
               onTap: () { 
        
               //  if (_formKey.currentState!.validate())
                 {
              //SignUpController.instance.registerUser(controller.emailController.text.trim(), controller.passwordController.text.trim());
             // SignUpController.instance.phoneAuthentication(controller.phone.text.trim());
              final user = UserModel(
                email:controller.email.text.trim(),
                password:controller.password.text.trim(), 
                name:controller.name.text.trim(), 
                phone:controller.phone.text.trim(), 
                );
                
                SignUpController.instance.createUser(user);
                 }
                },
               child: Container(
                 
                 width: Dimensions.screenWidth/3,
                 height: Dimensions.screenHeight/15,
                 decoration: BoxDecoration(
                   borderRadius: BorderRadius.circular(Dimensions.radius30),
                   color:  Colors.white,
                 ),
                  
                 child: Center(
                 child:BigText(
                   
                   text: "Sign Up",
                   size: Dimensions.font20+Dimensions.font20/8,
                   color: Colors.black,
                   ),
                ),
                ),
             ),
             SizedBox(height: Dimensions.height10,),
             RichText( 
              text: TextSpan(
                text:"Already have an account?",
                style: TextStyle(
                  color:Colors.white,
                  fontSize: Dimensions.font16,
                ),
                children: [
                  TextSpan(
                    recognizer: TapGestureRecognizer()..onTap=()=>Get.to(()=>const SignInPage(), transition: Transition.fade),
                text:" Login",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: const Color.fromARGB(255, 43, 22, 185),
                  fontSize: Dimensions.font20,
                )
                  )
                ]
              )
              ),
              SizedBox(height: Dimensions.screenHeight*0.05,),
             
             
          
          ] 
          ),
        )
      )
    );
  
  }
}