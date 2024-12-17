import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_1/pages/auth/otp/verify_vendor.dart';
import 'package:flutter_application_1/pages/front/front_page.dart';
import 'package:flutter_application_1/pages/home/home_page.dart';

import 'package:flutter_application_1/pages/vendor/execptions/signup_failure.dart';
import 'package:flutter_application_1/pages/vendor/home/home_page_vendor.dart';
import 'package:flutter_application_1/pages/vendor/otp_screen_vendor.dart';
import 'package:flutter_application_1/pages/vendor/profile_controller_vendor.dart';
import 'package:flutter_application_1/pages/vendor/user_model_vendor.dart';
import 'package:get/get.dart';

class AuthenticationRepoVendor extends GetxController {
  static AuthenticationRepoVendor get instance => Get.find();

  final _auth = FirebaseAuth.instance;
  late final Rx<User?> firebaseUser;
  var verificationId = "".obs;
  late UserModelVendor userData = UserModelVendor(
    // Initialize with specific data fields
    name: "",

    phone: "",
    vendorid: "",
  );
  @override
  void onReady() {
    Future.delayed(const Duration(seconds: 6));
    firebaseUser = Rx<User?>(_auth.currentUser);
    firebaseUser.bindStream(_auth.userChanges());
    ever(firebaseUser, _setInitialScreen);
  }

  _setInitialScreen(User? user) async {
    final controller = Get.find<ProfileControllervendor>();
    final vendor = await controller.getUserData();
    if (user == null) {
      Get.offAll(() => const FrontPage());
    } else {
      if (vendor == null) {
        //userData = userid;
        Get.offAll(() => const HomePage());
      } else {
        Get.offAll(() => const HomePagevendor());
      }
    }
  }

  Future<void> createUserWithEmailAndPassword(
      String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      firebaseUser.value != null
          ? Get.offNamed('/vendorHomePage')
          : Get.offAll(() => const FrontPage());
    } on FirebaseAuthException catch (e) {
      final ex = SignUpWithEmailAndPasswordFailure.code(e.code);
      print('FIREBASE AUTH EXCEPTION-${ex.message}');
      throw ex;
    } catch (_) {
      const ex = SignUpWithEmailAndPasswordFailure();
      print('EXCEPTION-${ex.message}');
      throw ex;
    }
  }

  Future<bool> phoneAuthentication(String phone) async {
    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: phone,
        verificationCompleted: (credential) async {
          await _auth.signInWithCredential(credential);
          print("Phone authenticated successfully. Creating user...");
        },
        codeSent: (verificationId, resendToken) {
          this.verificationId.value = verificationId;
          Get.to(() => VerifyVendor(phone: phone),
              transition: Transition.fadeIn);
        },
        codeAutoRetrievalTimeout: (verificationId) {
          this.verificationId.value = verificationId;
        },
        verificationFailed: (e) {
          if (e.code == "invalid-phone-number") {
            Get.snackbar("Error", 'The provided phone number is not valid.');
          } else {
            Get.snackbar("Error", 'Something went wrong. Try again');
          }
        },
      );
      return true;
    } catch (error) {
      // OTP verification failed
      print("Error during OTP verification: $error");
      return false;
    }
  }

  Future<bool> verifyOTP(String otp) async {
    var credentials = await _auth.signInWithCredential(
        PhoneAuthProvider.credential(
            verificationId: verificationId.value, smsCode: otp));
    return credentials.user != null ? true : false;
  }

  Future<void> signInWithPhoneNumber(String phoneNumber) async {
    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (credential) async {
          await _auth.signInWithCredential(credential);
          //Get.to(() => const HomePagevendor());
        },
        codeSent: (verificationId, resendToken) {
          this.verificationId.value = verificationId;
          Get.to(() => const OTPScreenVendor());
        },
        codeAutoRetrievalTimeout: (verificationId) {
          this.verificationId.value = verificationId;
        },
        verificationFailed: (e) {
          if (e.code == "invalid-phone-number") {
            Get.snackbar("Error", 'The provided phone number is not valid.');
          } else {
            Get.snackbar("Error", 'Something went wrong. Try again');
          }
        },
      );
    } catch (e) {
      // Handle any exceptions that may occur during phone number authentication.
      print('Phone number authentication error: $e');
      rethrow;
    }
  }

  Future<void> logout() async {
    await _auth.signOut();

    Get.offAll(() => const FrontPage());
  }
}
