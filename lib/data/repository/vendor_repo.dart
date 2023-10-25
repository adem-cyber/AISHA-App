/*import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/pages/account/Vender/vendor_model.dart';
import 'package:get/get.dart';


class VendorRepo extends GetxController {
  static VendorRepo get instance => Get.find();

  final _db = FirebaseFirestore.instance;
  
  get updatedVendor => null;

  // Store vendor
  Future<void> createVendor(VendorModel vendor) async {
    try {
      print("Vendor data to be saved: ${vendor.toJson()}");
      await _db.collection("Vendors").add(vendor.toJson()); // Assuming Vendors is the Firestore collection for vendors
      Get.snackbar(
        "Success",
        "Your vendor account has been created.",
        snackPosition: SnackPosition.TOP,
        backgroundColor: const Color.fromARGB(153, 255, 255, 255),
        colorText: const Color.fromARGB(255, 7, 219, 14).withOpacity(0.1),
      );
    } catch (error) {
      print("Error while creating vendor: $error");
      Get.snackbar(
        "Error",
        "Something went wrong. Try again",
        snackPosition: SnackPosition.TOP,
        backgroundColor: const Color.fromARGB(140, 255, 255, 255),
        colorText: const Color.fromARGB(255, 216, 9, 9).withOpacity(0.1),
      );
    }
  }

  // Fetch a vendor's details by phone number
  Future<VendorModel?> getVendorDetails(String phone) async {
    try {
      final snapshot = await _db
          .collection("Vendors")
          .where("Phone", isEqualTo: phone)
          .get();
      if (snapshot.docs.isNotEmpty) {
        final vendorData = VendorModel.fromSnapshot(snapshot.docs.first);
        return vendorData;
      } else {
        return null;
      }
    } catch (error) {
      print("Error while fetching vendor details: $error");
      return null;
    }
  }

  Future<bool> vendorExistsByEmail(String email) async {
  try {
    final emailSnapshot = await _db
        .collection("Users")
        .where("Email", isEqualTo: email)
        .get();

    return emailSnapshot.docs.isNotEmpty;
  } catch (error) {
    print("Error while checking user existence by email: $error");
    return false;
  }
}

// Check if a user with the given phone exists
Future<bool> vendorExistsByPhone(String phone) async {
  try {
    final phoneSnapshot = await _db
        .collection("Users")
        .where("Phone", isEqualTo: phone)
        .get();

    return phoneSnapshot.docs.isNotEmpty;
  } catch (error) {
   
    print("Error while checking user existence by phone: $error");
    return false;
  }
  
}
  // Update user details
  
    
  }


*/


