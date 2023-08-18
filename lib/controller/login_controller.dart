
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../data/repository/auth_repo.dart';
import '../data/repository/user_repo.dart';

class LoginController extends GetxController{
  static LoginController get instance =>Get.find(); 
 
   final password =TextEditingController();
  
  final phone =TextEditingController();
 
  final userRepo = Get.put(UserRepo());

  void phoneAuthentication(String phone){
    AuthenticationRepo.instance.phoneAuthentication(phone);

    

  }
}