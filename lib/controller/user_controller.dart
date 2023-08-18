/*import 'package:flutter/cupertino.dart';
import 'package:flutter_application_1/data/repository/user_repo.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../data/repository/auth_repo.dart';
import '../model/user_model.dart';

class UserController extends GetxController{
  static UserController get instance =>Get.find(); 
  final email =TextEditingController();
  final password =TextEditingController();
  final name =TextEditingController();
  final phone =TextEditingController();
  final userRepo = Get.put(UserRepo());


void createUser(UserModel user)async{
    await userRepo.createUser(user);
    phoneAuthentication(user.phone);

  }
  void phoneAuthentication(String phone){
    AuthenticationRepo.instance.phoneAuthentication(phone);

  }


}*/