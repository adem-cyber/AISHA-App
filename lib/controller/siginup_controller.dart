import 'package:flutter/cupertino.dart';
import 'package:flutter_application_1/data/repository/auth_repo.dart';
import 'package:flutter_application_1/model/user_model.dart';
import 'package:flutter_application_1/pages/auth/otp/otp_screen.dart';
import 'package:get/get.dart';

import '../data/repository/user_repo.dart';

class SignUpController extends GetxController{
  static SignUpController get instance =>Get.find(); 
  final email =TextEditingController();
   final password =TextEditingController();
  final name =TextEditingController();
  final phone =TextEditingController();
 
  final userRepo = Get.put(UserRepo());

 // void registerUser(String email,String password){
 //    AuthenticationRepo.instance.createUserWithEmailAndPassword(email, password);
 // }

  Future <void> createUser(UserModel user)async{ 
     phoneAuthentication(user.phone);
    Get.to(()=> const OTPScreen());

    await userRepo.createUser(user);
  
  }

  void phoneAuthentication(String phone){
    AuthenticationRepo.instance.phoneAuthentication(phone);

  }


}