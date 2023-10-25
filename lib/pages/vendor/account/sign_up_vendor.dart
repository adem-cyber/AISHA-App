import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/vendor/account/app_text_field.dart';
import 'package:flutter_application_1/pages/vendor/account/sign_in_vendor.dart';
import 'package:flutter_application_1/pages/vendor/user_model_vendor.dart';

import 'package:flutter_application_1/utils/dimensions.dart';
import 'package:flutter_application_1/widgets/big_text.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

import '../sign_up_controller_vendor.dart';

class SignUpPageVendor extends StatelessWidget {
  SignUpPageVendor({Key? key}) : super(key: key);

  final SignUpControllerVendor controller = Get.put(SignUpControllerVendor());
  final formKey = GlobalKey<FormState>();
  var vendorid = const Uuid().v4();
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/register.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                SizedBox(
                  height: Dimensions.screenHeight * 0.09,
                ),
                const Center(
                  child: CircleAvatar(
                    radius: 60,
                    backgroundImage: AssetImage("assets/images/logo.png"),
                  ),
                ),
                SizedBox(
                  height: Dimensions.screenHeight * 0.01,
                ),
                Center(
                  child: Column(
                    children: [
                      Text(
                        "Welcome",
                        style: TextStyle(
                          fontSize: Dimensions.font16 + Dimensions.font20 / 2,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: Dimensions.screenHeight * 0.04,
                ),
                Center(
                  child: BigText(
                    text: "Create your account",
                    size: Dimensions.font20,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  height: Dimensions.screenHeight * 0.02,
                ),
                AppTextField(
                  formKey,
                  textController: controller.name,
                  hintText: "Name",
                  icon: Icons.person,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter your name";
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: Dimensions.height20,
                ),
                AppTextField(
                  formKey,
                  textController: controller.phone,
                  hintText: "(+260)Phone",
                  icon: Icons.phone,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Phone is required";
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: Dimensions.height20,
                ),
                AppTextField(
                  formKey,
                  textController: controller.email,
                  hintText: "Email",
                  icon: Icons.email,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Email is required";
                    }
                    if (!GetUtils.isEmail(value)) {
                      return "Enter a valid email address";
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: Dimensions.height20,
                ),
                AppTextField(
                  formKey,
                  textController: controller.password,
                  hintText: "Password",
                  obscureText: true,
                  icon: Icons.lock,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Password is required";
                    }
                    if (value.length < 6) {
                      return "Password must be at least 6 characters";
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: Dimensions.height20,
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      final email = controller.email.text.trim();
                      final phone = controller.phone.text.trim();
                      
                      Get.dialog(
                              const Center(child: CircularProgressIndicator()),
                              barrierDismissible: false,
                            );

                      // Check if a user with the given email or phone already exists
                      final userExists = await SignUpControllerVendor.instance
                          .userExistsByEmailOrPhone(email, phone);

                      if (userExists) {
                        const snackBar = SnackBar(
                          content: Text(
                              'User with this email or phone already exists try logging in.'),
                          backgroundColor:
                              Colors.red, // Customize the background color
                          duration: Duration(
                              seconds:
                                  3), // Set the duration to display the SnackBar
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        print("User with this email or phone already exists.");
                      } else {
                        // User doesn't exist, proceed to create the new user
                        final user = UserModelVendor(
                          email: email,
                          password: controller.password.text.trim(),
                          name: controller.name.text.trim(),
                          phone: phone,
                          vendorid: vendorid,
                        );
                        SignUpControllerVendor.instance.createUser(user);
                      }
                      Get.back();
                          
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
                    text: "Sign up",
                    size: Dimensions.font20 + Dimensions.font20 / 8,
                    color: Colors.black,
                  ),
                ),
                SizedBox(
                  height: Dimensions.height10,
                ),
                RichText(
                  text: TextSpan(
                    text: "Already have an account?",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: Dimensions.font16,
                    ),
                    children: [
                      TextSpan(
                        recognizer: TapGestureRecognizer()
                          ..onTap = () => Get.to(() => SignInPageVendor(),
                              transition: Transition.fade),
                        text: " Login",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: const Color.fromARGB(255, 218, 194, 14),
                          fontSize: Dimensions.font20,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: Dimensions.screenHeight * 0.05,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
