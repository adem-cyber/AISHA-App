import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/signup_controller.dart';
import 'package:flutter_application_1/data/repository/auth_repo.dart';
import 'package:flutter_application_1/data/repository/authentication_repo_vendor.dart';
import 'package:flutter_application_1/data/repository/user_repo.dart';
import 'package:flutter_application_1/pages/account/profile/register.dart';
import 'package:flutter_application_1/pages/account/sign_up_all.dart';
import 'package:flutter_application_1/pages/front/front_page.dart';
import 'package:flutter_application_1/utils/colors.dart';
import 'package:get/get.dart';

import '../../controller/login_controller.dart';
import '../../utils/dimensions.dart';
import '../../widgets/big_text.dart';
import '../home/home_page.dart';
import 'app_text_field.dart';

class SignInPageAll extends StatelessWidget {
  SignInPageAll({Key? key}) : super(key: key);
  bool _isloading = false;
//  final SignInController loginController = Get.put(SignInController());
  final formKey = GlobalKey<FormState>();
  late final TextEditingController phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/login.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  SizedBox(
                    height: Dimensions.screenHeight * 0.35,
                  ),
                  Column(
                    children: [
                      Text(
                        "Welcome Back",
                        style: TextStyle(
                          fontSize: Dimensions.font16 + Dimensions.font20 / 2,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Text(
                        "Sign Into Your Account",
                        style: TextStyle(
                          fontSize: Dimensions.font16,
                          color: Colors.black,
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 20),
                  Form(
                    key: formKey,
                    child: Column(
                      children: [
                        Center(
                          child: SizedBox(
                            width: 350,
                            child: TextFormField(
                              controller: phoneController,
                              style: const TextStyle(
                                  fontSize: 16.0, color: Colors.black),
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                labelText: 'Phone',
                                labelStyle: const TextStyle(
                                    fontSize: 16, color: Colors.black),
                                hintText: '912345678',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                  borderSide:
                                      const BorderSide(color: Colors.black),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                  borderSide: const BorderSide(
                                      color: Colors.black, width: 1.0),
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 16.0, horizontal: 16.0),
                                prefixIcon: const Icon(Icons.phone,
                                    color: AppColors.mainColor),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please Enter your phone number';
                                }
                                return null;
                              },
                            ),
                          ),
                        ),
                        SizedBox(height: Dimensions.height20),
                        ElevatedButton(
                          onPressed: () async {
                            String phone;
                            if (phoneController.text.trim()[0] == '0') {
                              phone = '+251' +
                                  phoneController.text.trim().substring(1, 10);
                              print(phone);
                            } else {
                              phone = '+251' + phoneController.text.trim();
                            }
                            //  print(phone);
                            if (formKey.currentState!.validate()) {
                              try {
                                // Show a loading indicator while signing in
                                Get.dialog(
                                  const Center(
                                      child: CircularProgressIndicator()),
                                  barrierDismissible: false,
                                );
                                print(phone);
                                final UserExists = await UserRepo.instance
                                    .UserExistsByPhone(phone);
                                final VendorExists = await UserRepo.instance
                                    .vendorExistsByPhone(phone);
                                if (VendorExists) {
                                  await AuthenticationRepoVendor.instance
                                      .signInWithPhoneNumber(phone);
                                } else if (UserExists) {
                                  await AuthenticationRepo.instance
                                      .signInWithPhoneNumber(phone);

                                  // Get.back();
                                } else {
                                  const snackBar = SnackBar(
                                    content: Text(
                                        'User with this phone does not exists try signup!'),
                                    backgroundColor: Colors
                                        .orangeAccent, // Customize the background color
                                    duration: Duration(
                                        seconds:
                                            3), // Set the duration to display the SnackBar
                                  );
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                  print("User with this phone already exists.");
                                }
                              } catch (e) {
                                // Handle login failures, display an error message
                                Get.snackbar(
                                    "Error", "Sign-in failed: ${e.toString()}");
                              } finally {
                                // Hide the loading indicator when done
                                Get.back();
                              }
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(Dimensions.radius30),
                            ),
                            minimumSize: Size(
                              Dimensions.screenWidth / 3,
                              Dimensions.screenHeight / 15,
                            ),
                          ),
                          child: BigText(
                            text: "Sign In",
                            size: Dimensions.font20 + Dimensions.font20 / 8,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: Dimensions.screenHeight * 0.05),
                        RichText(
                          text: TextSpan(
                            text: "Don't have an account?",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: Dimensions.font16,
                            ),
                            children: [
                              TextSpan(
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    phoneController
                                        .clear(); // Clear the phone controller
                                    Get.to(() => SignUpPageAll(),
                                        transition: Transition.fade);
                                  },
                                text: " Create",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue,
                                  fontSize: Dimensions.font20,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // Positioned widget for the back button
            Positioned(
              top: 40,
              child: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  Get.to(() => const FrontPage());
                  phoneController.clear();
                },
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
