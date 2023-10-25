import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_1/data/repository/auth_repo.dart';
import 'package:flutter_application_1/model/user_model.dart';
import 'package:flutter_application_1/data/repository/user_repo.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  static ProfileController get instance => Get.find();

  final _authRepo = Get.put(AuthenticationRepo());
  final _userRepo = Get.put(UserRepo());

  final Rx<UserModel?> userData = Rx<UserModel?>(null);

  @override
  void onReady() {
    super.onReady();
    // Listen to changes in the authentication state and fetch user data if logged in
    ever(_authRepo.firebaseUser, _fetchUserData);
  }

  Future<void> _fetchUserData(User? user) async {
    if (user != null) {
      try {
        final phone = user.phoneNumber;
        if (phone != null) {
          final fetchedUserData = await _userRepo.getUserDetails(phone);
          if (fetchedUserData != null) {
            userData.value = fetchedUserData;
          } else {
            // Handle the case where user data is not found
            // You can set userData to null or take other actions as needed
            userData.value = null;
          }
        }
      } catch (error) {
        // Handle any errors that occur while fetching user data
        print('Error fetching user data: $error');
        // Set userData to null or take other error-handling actions as needed
        userData.value = null;
      }
    }
  }

  Future<UserModel?> getUserData() async {
    // Fetch user data logic here
    try {
      final user = _authRepo.firebaseUser.value;
      if (user != null) {
        final phone = user.phoneNumber;
        if (phone != null) {
          final fetchedUserData = await _userRepo.getUserDetails(phone);
          return fetchedUserData;
        }
      }
    } catch (error) {
      print('Error fetching user data: $error');
    }
    return null; // Return null if data fetch fails
  }

  Future<bool> updateUserData(UserModel updatedUser) async {
    try {
      // Call the update method from your UserRepo
      await _userRepo.updateUserDetails(updatedUser);

      // Refresh the user data in the controller
      await _fetchUserData(_authRepo.firebaseUser.value);

      return true; // Update was successful
    } catch (error) {
      print('Error updating user data: $error');
      return false; // Update failed
    }
  }
}
