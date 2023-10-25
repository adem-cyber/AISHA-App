import 'package:flutter_application_1/controller/signup_controller.dart';
import 'package:flutter_application_1/data/repository/auth_repo.dart';
import 'package:flutter_application_1/model/user_model.dart';
import 'package:flutter_application_1/pages/home/home_page.dart';
import 'package:get/get.dart';


  
  class OTPController extends GetxController {
  static OTPController get instance => Get.find();

  void verifyOTP(String otp) async {
 var isVerified = await AuthenticationRepo.instance.verifyOTP(otp);
 isVerified ? Get .offAll(const HomePage()): Get.back();
} 

 
}

  
