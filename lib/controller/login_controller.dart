import 'package:flutter/material.dart';
import 'package:flutter_application_1/data/repository/auth_repo.dart';
import 'package:flutter_application_1/pages/home/home_page.dart';
import 'package:get/get.dart';

class SignInController extends GetxController {
  late TextEditingController phone;
  final RxBool isLoading = false.obs; // Observable to track loading state
  final RxString errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    phone = TextEditingController();
  }

  Future<void> signInWithPhoneNumber() async {
    try {
      isLoading.value = true; // Start loading

      // Clear previous error messages
      errorMessage.value = '';

      // Initiate phone number verification and await completion
      AuthenticationRepo.instance.phoneAuthentication(phone.text.trim());

      // Check the user state after phone authentication
      final user = AuthenticationRepo.instance.firebaseUser.value;

      if (user != null) {
        // Sign-in successful
        Get.snackbar(
          "Success",
          "You have successfully signed in.",
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.white12,
          colorText: Colors.green.withOpacity(0.1),
        );
        Get.to(() => const HomePage());
      } else {
        // Handle user not logged in appropriately
        errorMessage.value = 'User not logged in';
      }
    } catch (e) {
      print("Sign in error: $e");
      errorMessage.value =
          'An error occurred during sign-in. Please try again later.';
    } finally {
      isLoading.value = false; // Stop loading
    }
  }
}
