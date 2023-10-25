import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/vendor/user_model_vendor.dart';
import 'package:get/get.dart';

class UserRepoVendor extends GetxController {
  static UserRepoVendor get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  // Store user
  createUser(UserModelVendor user) async {
    try {
      print("User data to be saved: ${user.toJson()}");
      await _db.collection("Vendors").add(user.toJson());
      Get.snackbar(
        "Success",
        "Your account has been created.",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } catch (error) {
      print("Error while creating user: $error");
      Get.snackbar(
        "Error",
        "Something went wrong. Try again",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.white,
        colorText: Colors.redAccent.withOpacity(0.1),
      );
    }
  }

  // Fetch a user's details by phone number
  Future<UserModelVendor?> getUserDetails(String phone) async {
    try {
      final snapshot = await _db
          .collection("Vendors")
          .where("Phone", isEqualTo: phone)
          .get();
      if (snapshot.docs.isNotEmpty) {
        final userData = UserModelVendor.fromSnapshot(snapshot.docs.first);
        return userData;
      } else {
        return null;
      }
    } catch (error) {
      print("Error while fetching user details: $error");
      return null;
    }
  }

  // Fetch details of all users
  Future<List<UserModelVendor>> getAllUsers() async {
    try {
      final snapshot = await _db.collection("Vendors").get();
      final userData =
          snapshot.docs.map((e) => UserModelVendor.fromSnapshot(e)).toList();
      return userData;
    } catch (error) {
      print("Error while fetching all users: $error");
      return [];
    }
  }

  // Check if a user with the given email or phone exists
 Future<bool> userExistsByEmail(String email) async {
  try {
  /*  final vendorsSnapshot = await _db
        .collection("Vendors")
        .where("Email", isEqualTo: email)
        .get();
*/
    final usersSnapshot = await _db
        .collection("Users")
        .where("Email", isEqualTo: email)
        .get();

    // Check if email exists in either collection
    return /*vendorsSnapshot.docs.isNotEmpty ||*/ usersSnapshot.docs.isNotEmpty;
  } catch (error) {
    print("Error while checking user existence by email: $error");
    return false;
  }
}


// Check if a user with the given phone exists
 Future<bool> userExistsByPhone(String phone) async {
  try {
    final vendorsSnapshot = await _db
        .collection("Vendors")
        .where("Phone", isEqualTo: phone)
        .get();

    final usersSnapshot = await _db
        .collection("Users")
        .where("Phone", isEqualTo: phone)
        .get();

    // Check if email exists in either collection
    return vendorsSnapshot.docs.isNotEmpty ||usersSnapshot.docs.isNotEmpty;
  } catch (error) {
    print("Error while checking user existence by email: $error");
    return false;
  }
}

  // Update user details
  Future<void> updateUserDetails(UserModelVendor updatedUser) async {
    try {
      // Get the document reference using user's ID
      final userDocRef = _db.collection("Vendors").doc(updatedUser.id);

      // Update the document
      await userDocRef.update(updatedUser.toJson());

      print('User data updated successfully');
    } catch (error) {
      print('Error updating user data: $error');
      throw 'Error updating user data: $error';
    }
  }
}
