import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/data/repository/authentication_repo_vendor.dart';
import 'package:flutter_application_1/data/repository/user_repo_vendor.dart';
import 'package:flutter_application_1/pages/vendor/otp_screen_vendor.dart';
import 'package:flutter_application_1/pages/vendor/user_model_vendor.dart';

import 'package:get/get.dart';

class SignUpControllerVendor extends GetxController {
  static SignUpControllerVendor get instance => Get.find();

  final email = TextEditingController();
  final password = TextEditingController();
  final name = TextEditingController();
  final phone = TextEditingController();

  final userRepo = Get.put(UserRepoVendor());

  Future<void> registerUser(String email, String password) async {
    AuthenticationRepoVendor.instance
        .createUserWithEmailAndPassword(email, password);
  }

  Future<void> createUser(UserModelVendor user) async {
    try {
      // Initiate phone number authentication and await OTP verification
      final isVerified = await phoneAuthentication(user.phone);

      if (isVerified) {
        // OTP verification succeeded, create the user in Firestore
        await userRepo.createUser(user);
        Get.to(() =>
            const OTPScreenVendor()); // Navigate to the OTPScreen or any other screen as needed
      } else {
        // OTP verification failed, handle accordingly (e.g., show an error message)
      }
    } catch (error) {
      print("Error while creating user: $error");
      // Handle the error, e.g., show an error message to the user.
    }
  }

  Future<bool> userExistsByEmailOrPhone(String phone) async {
    try {
      // Check if a user with the given email exists

      final phoneExists = await userRepo.userExistsByPhone(phone);

      return phoneExists;
    } catch (error) {
      print("Error while checking user existence: $error");
      return false;
    }
  }

  Future<bool> phoneAuthentication(String phone) async {
    try {
      // Initiate phone number authentication
      await AuthenticationRepoVendor.instance.phoneAuthentication(phone);

      // Assuming OTP verification is successful
      return true;
    } catch (error) {
      // OTP verification failed
      print("Error during OTP verification: $error");
      return false;
    }
  }
}
