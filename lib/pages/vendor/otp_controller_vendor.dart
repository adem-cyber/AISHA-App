import 'package:flutter_application_1/base/save.dart';
import 'package:flutter_application_1/data/repository/authentication_repo_vendor.dart';
import 'package:flutter_application_1/data/repository/user_repo_vendor.dart';
import 'package:flutter_application_1/pages/vendor/home/home_page_vendor.dart';
import 'package:flutter_application_1/pages/vendor/user_model_vendor.dart';
import 'package:get/get.dart';

class OTPControllerVendor extends GetxController {
  static OTPControllerVendor get instance => Get.find();

  void verifyOTP(String otp) async {
    var isVerified = await AuthenticationRepoVendor.instance.verifyOTP(otp);
    //  isVerified ? Get.to(() => const HomePagevendor()) : Get.back();
  }

  void verifyOTPlogin(String otp) async {
    var isVerified = await AuthenticationRepoVendor.instance.verifyOTP(otp);
    isVerified ? Get.to(() => const HomePagevendor()) : Get.back();
  }

  void verify(String otp, String phone, name, email, vendorid) async {
    var isVerified = await AuthenticationRepoVendor.instance.verifyOTP(otp);
    if (isVerified) {
      UserModelVendor user =
          UserModelVendor(name: name, phone: phone, vendorid: vendorid);
      print("User data: ${user.toJson()}");
      await UserRepoVendor.instance.createUser(user);
      Get.offAll(() => const HomePagevendor());
      SaveData.clearUserData();
    } else {
      Get.back();
    }
  }
}
