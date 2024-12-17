import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/base/save.dart';
import 'package:flutter_application_1/data/repository/auth_repo.dart';
import 'package:flutter_application_1/pages/account/sign_in.dart';
import 'package:flutter_application_1/utils/colors.dart';
import 'package:get/get.dart';

import '../../controller/signup_controller.dart';
import '../../model/user_model.dart';
import '../../utils/dimensions.dart';
import '../../widgets/big_text.dart';
import 'app_text_field.dart';

class SignUpPage extends StatelessWidget {
  SignUpPage({Key? key}) : super(key: key);

  final SignUpController controller = Get.put(SignUpController());
  final formKey = GlobalKey<FormState>();

  late final TextEditingController nameController = TextEditingController();
  late final TextEditingController phoneController = TextEditingController();
  late final TextEditingController emailController = TextEditingController();
  late final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var signupimages = ["google.png", "facebook.png", "twitter.png"];
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/login.png'),
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
                SizedBox(
                  width: 350,
                  child: TextFormField(
                    controller: nameController,
                    style: const TextStyle(fontSize: 16.0, color: Colors.black),
                    decoration: InputDecoration(
                      labelText: 'Name',
                      hintText: 'John',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide:
                            const BorderSide(color: AppColors.mainColor),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: const BorderSide(
                            color: AppColors.mainColor, width: 1.0),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 16.0, horizontal: 16.0),
                      prefixIcon: const Icon(Icons.person_2_outlined,
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
                SizedBox(
                  height: Dimensions.height20,
                ),
                SizedBox(
                  width: 350,
                  child: TextFormField(
                    controller: phoneController,
                    style: const TextStyle(fontSize: 16.0, color: Colors.black),
                    decoration: InputDecoration(
                      labelText: 'Phone',
                      hintText: '912345678',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide:
                            const BorderSide(color: AppColors.mainColor),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: const BorderSide(
                            color: AppColors.mainColor, width: 1.0),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 16.0, horizontal: 16.0),
                      prefixIcon: const Icon(Icons.phone_outlined,
                          color: AppColors.mainColor),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty || value[0] == 0) {
                        return 'Please Enter your phone number';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(
                  height: Dimensions.height20,
                ),
                SizedBox(
                  height: Dimensions.height20,
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      // final email = controller.phone.text.trim();
                      String phone = '+251' + phoneController.text.trim();
                      print(phone);
                      Get.dialog(
                        const Center(child: CircularProgressIndicator()),
                        barrierDismissible: false,
                      );

                      // Check if a user with the given email or phone already exists
                      final userExists = await SignUpController.instance
                          .userExistsByEmailOrPhone(phone);

                      if (userExists) {
                        const snackBar = SnackBar(
                          content: Text(
                              'User with this phone already exists try logging in.'),
                          backgroundColor:
                              Colors.red, // Customize the background color
                          duration: Duration(
                              seconds:
                                  3), // Set the duration to display the SnackBar
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        print("User with this email or phone already exists.");
                      } else if (phone[4] == '0') {
                        const snackBar = SnackBar(
                          content: Text('Please your number properly'),
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
                        SaveData.storeUserData({
                          'Name': nameController.text.trim(),
                          'Phone': phone,
                        });

                        await AuthenticationRepo.instance
                            .phoneAuthentication(phone);
                        //SignUpControllerVendor.instance.createUser(user);
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
                          ..onTap = () => Get.to(() => SignInPage(),
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
