import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/data/repository/auth_repo.dart';
import 'package:flutter_application_1/pages/account/profile/register.dart';
import 'package:flutter_application_1/pages/account/sign_up.dart';
import 'package:flutter_application_1/pages/front/front_page.dart';
import 'package:flutter_application_1/utils/colors.dart';
import 'package:get/get.dart';

import '../../controller/login_controller.dart';
import '../../utils/dimensions.dart';
import '../../widgets/big_text.dart';
import '../home/home_page.dart';
import 'app_text_field.dart';

class SignInPage extends StatelessWidget {
  SignInPage({Key? key}) : super(key: key);

  final SignInController loginController = Get.put(SignInController());
  final formKey = GlobalKey<FormState>();

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
                  SizedBox(height: Dimensions.screenHeight * 0.15),
                  const Center(
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 60,
                      backgroundImage: AssetImage("assets/images/logo.png"),
                    ),
                  ),
                  SizedBox(height: Dimensions.screenHeight * 0.02),
                  Column(
                    children: [
                      Text(
                        "Sign Into Your Account",
                        style: TextStyle(
                          fontSize: Dimensions.font20,
                          color: AppColors.mainBlackcolor,
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: Dimensions.screenHeight * 0.02),
                  Form(
                    key: formKey,
                    child: Column(
                      children: [
                        AppTextField(
                          formKey,
                          textController: loginController.phone,
                          hintText: "(+260)Phone",
                          icon: Icons.phone,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Phone is required";
                            }
                            // Add additional validation as needed for phone numbers
                            return null;
                          },
                        ),
                        SizedBox(height: Dimensions.height20),
                        ElevatedButton(
                          onPressed: () async {
                            if (formKey.currentState!.validate()) {
                              try {
                                // Show a loading indicator while signing in
                                Get.dialog(
                                  const Center(child: CircularProgressIndicator()),
                                  barrierDismissible: false,
                                );

                                await AuthenticationRepo.instance
                                    .signInWithPhoneNumber(
                                  loginController.phone.text.trim(),
                                );

                                // Check the user state before navigation
                                final user =
                                    AuthenticationRepo.instance.firebaseUser.value;
                                if (user != null) {
                                  // Navigate to the home page on successful login
                                  Get.offAll(() => const HomePage());
                                } else {
                                  // Handle user not logged in appropriately
                                  Get.snackbar("Error", "User not logged in");
                                }
                              } catch (e) {
                                // Handle login failures, display an error message
                                Get.snackbar("Error", "Sign-in failed: ${e.toString()}");
                              } finally {
                                // Hide the loading indicator when done
                                Get.back();
                              }
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(Dimensions.radius30),
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
                                  ..onTap = () => Get.to(() => SignUpPage(),
                                      transition: Transition.fade),
                                text: " Create",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: const Color.fromARGB(255, 192, 194, 27),
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
            Align(
              alignment: Alignment.bottomCenter,
              heightFactor:2,
              child: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  Get.to(()=>const FrontPage());
                },
                color: AppColors.mainBlackcolor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
 