import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/data/repository/user_repo.dart';
import 'package:get/get.dart';
import 'package:flutter_application_1/data/repository/auth_repo.dart';
import 'package:flutter_application_1/model/user_model.dart';
import 'package:flutter_application_1/pages/auth/otp/otp_screen.dart';

class SignUpController extends GetxController {
  static SignUpController get instance => Get.find();

  final email = TextEditingController();
  final password = TextEditingController();
  final name = TextEditingController();
  final phone = TextEditingController();

  final userRepo = Get.put(UserRepo());

  //final authRepo = Get.put(authRepo());

/*
  Future<void> createUser(UserModel user) async {
  try {
    // Initiate phone number authentication and await OTP verification
    final isVerified = await phoneAuthentication(user.phone);

    if (isVerified) {
      // OTP verification succeeded, create the user in Firestore
      await userRepo.createUser(user);
      Get.to(() => const OTPScreen()); // Navigate to the OTPScreen or any other screen as needed
    } else {
      // OTP verification failed, handle accordingly (e.g., show an error message)
    }
  } catch (error) {
    print("Error while creating user: $error");
    // Handle the error, e.g., show an error message to the user.
  }
}
*/
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
      await AuthenticationRepo.instance.phoneAuthentication(phone);

      // Assuming OTP verification is successful
      return true;
    } catch (error) {
      // OTP verification failed
      print("Error during OTP verification: $error");
      return false;
    }
  }
}
