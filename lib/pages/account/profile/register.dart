import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/signup_controller.dart';
import 'package:flutter_application_1/data/repository/auth_repo.dart';
import 'package:flutter_application_1/pages/account/sign_up.dart';
import 'package:flutter_application_1/pages/app_text_fields.dart';
import 'package:flutter_application_1/pages/front/front_page.dart';
import 'package:flutter_application_1/pages/home/home_page.dart';
import 'package:flutter_application_1/utils/colors.dart';
import 'package:flutter_application_1/utils/dimensions.dart';
import 'package:flutter_application_1/widgets/big_text.dart';
import 'package:get/get.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({Key? key}) : super(key: key);

  final SignUpController controller = Get.put(SignUpController());
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
                        AppTextFieldd(
                          formKey,
                          textController: controller.phone,
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
                              Get.dialog(
                                const Center(
                                    child: CircularProgressIndicator()),
                                barrierDismissible: false,
                              );

                             SignUpController.instance
                                  .phoneAuthentication(controller.phone.text.trim());

                              Get.back(); // Close the loading dialog

                             
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
                            text: "Sign up",
                            size: Dimensions.font20 + Dimensions.font20 / 8,
                            color: Colors.black,
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
              heightFactor: 2,
              child: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  Get.to(() => const FrontPage());
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
