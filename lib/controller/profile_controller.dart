import 'package:flutter_application_1/data/repository/auth_repo.dart';
import 'package:get/get.dart';

import '../data/repository/user_repo.dart';


class ProfileController extends GetxController{
  static ProfileController get instance => Get.find();
   
   final _authRepo = Get.put(AuthenticationRepo());
   final _userRepo = Get.put(UserRepo());


    
  getUserData() {
    final phone = _authRepo.firebaseUser.value?.phoneNumber;
    if(phone !=null){
     return _userRepo.getUserDetails(phone);
    }else{
      Get.snackbar('Error', 'login to continue');
    }


  }

}