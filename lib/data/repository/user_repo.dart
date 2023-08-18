import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/user_model.dart';
import 'package:get/get.dart';

class UserRepo extends GetxController{
  static UserRepo get instance=> Get.find();

  final _db = FirebaseFirestore.instance;
  //store user
  createUser(UserModel user)async{
    await _db.collection("Users").add(user.toJson())
    .whenComplete(() 
    => Get.snackbar("Success", "You account has been created.",
       snackPosition: SnackPosition.BOTTOM,
       backgroundColor: Colors.green.withOpacity(0.1),
       colorText: Colors.green),
    )
    .catchError((error, stackTrace) { 
     Get.snackbar("Error", "Something went wrong.Try again",
       snackPosition: SnackPosition.BOTTOM,
       backgroundColor: Colors.redAccent.withOpacity(0.1),
       colorText: Colors.red);
       print("ERROR - $error");
    });
     }
//fetch all users
  Future<UserModel> getUserDetails(String phone) async{
    final snapshot = await _db.collection("Users" ).where("Phone", isEqualTo: phone).get(); 
    final userData = snapshot.docs.map((e)=>UserModel.fromSnapshot(e)).single;
    return userData;
  }
   Future<List<UserModel>> allUser(String phone) async{
    final snapshot = await _db.collection("Users" ).get(); 
    final userData = snapshot.docs.map((e)=>UserModel.fromSnapshot(e)).toList();
    return userData;
  }

 
}