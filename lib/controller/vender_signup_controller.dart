/*import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/data/repository/vendor_repo.dart'; // Import the correct repository
import 'package:flutter_application_1/pages/account/Vender/vendor_model.dart';
import 'package:get/get.dart';
import 'package:flutter_application_1/data/repository/auth_repo.dart';

import 'package:flutter_application_1/pages/auth/otp/otp_screen.dart';

class VendorSignUpController extends GetxController {
  static VendorSignUpController get instance => Get.find();

  final email = TextEditingController();
  final password = TextEditingController();
  final vendorName = TextEditingController();
  final phone = TextEditingController();
  final vendorType = TextEditingController();
  

  final vendorRepo = Get.put(VendorRepo());

  Future<void> registerVendor(String email, String password) async {
    AuthenticationRepo.instance.createUserWithEmailAndPassword(email, password);
  }

  Future<void> createVendor(VendorModel vendor) async {
    try {
      await vendorRepo.createVendor(vendor);
      phoneAuthentication(vendor.phone);
      Get.to(() => const OTPScreen());
    } catch (error) {
      print("Error while creating vendor: $error");
    }
  }
   Future<bool> vendorExistsByEmailOrPhone(String email, String phone) async {
    try {
      // Check if a user with the given email exists
      final emailExists = await vendorRepo.vendorExistsByEmail(email);

      // Check if a user with the given phone exists
      final phoneExists = await vendorRepo.vendorExistsByPhone(phone);

      return emailExists || phoneExists;
    } catch (error) {
       
      print("Error while checking user existence: $error");
      return false;
    }
   
  } 
  
  void phoneAuthentication(phone) {}

 
}
*/