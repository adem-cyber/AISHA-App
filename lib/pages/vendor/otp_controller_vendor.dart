


import 'package:flutter_application_1/data/repository/authentication_repo_vendor.dart';
import 'package:flutter_application_1/pages/vendor/home/home_page_vendor.dart';
import 'package:get/get.dart';
class OTPControllerVendor extends GetxController {
  static OTPControllerVendor get instance => Get.find();

  void verifyOTP(String otp) async {
    var isVerified = await AuthenticationRepoVendor.instance.verifyOTP(otp);
    isVerified ? Get.to(() =>const HomePagevendor()) : Get.back();
  }
}
