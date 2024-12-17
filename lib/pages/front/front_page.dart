import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/account/sign_up_all.dart';
import 'package:flutter_application_1/pages/account/sign_in_all.dart';

import 'package:flutter_application_1/utils/colors.dart';
import 'package:get/get.dart';

import '../../utils/dimensions.dart';
import '../../widgets/big_text.dart';
import '../account/sign_in.dart';

class FrontPage extends StatelessWidget {
  const FrontPage({super.key});

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
          body: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  SizedBox(
                    height: Dimensions.screenHeight * 0.35,
                  ),
                  Container(
                    height: 100,
                    child: Image.asset(
                      "assets/images/zzz.png",
                      fit: BoxFit.fitWidth,
                    ),
                    /* child: const Center(
                          child: CircleAvatar(
                              backgroundColor: Color.fromARGB(0, 126, 17, 17),
                              radius: 100,
                              backgroundImage:
                                  AssetImage("assets/images/zzz.png")))*/
                  ),
                  Container(
                    child: Column(children: [
                      Text("Welcome To IIYISHHA",
                          style: TextStyle(
                            fontSize: 30,
                            color: Colors.black,
                          )),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 45.0,
                          right: 45.0,
                          top: 10,
                        ),
                        child: Text(
                            "This is an application where we pride our self to be the best of both world, where you can be a user and a vendor on the one app",
                            softWrap: true,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                            )),
                      )
                    ]),
                  ),
                  SizedBox(
                    height: Dimensions.screenHeight * 0.18,
                  ),
                  Column(children: [
                    SizedBox(
                      width: Dimensions.screenHeight * 0.01,
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.to(() => SignInPage());
                      },
                      child: Container(
                        width: Dimensions.screenWidth / 1.1,
                        height: Dimensions.screenHeight / 20,
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(Dimensions.radius30),
                          color: AppColors.button2,
                        ),
                        child: Center(
                          child: BigText(
                            text: "Sign In",
                            size: Dimensions.font20 + Dimensions.font20 / 4,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: Dimensions.screenHeight * 0.006,
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.to(() => SignUpPageAll());
                      },
                      child: Container(
                        width: Dimensions.screenWidth / 1.1,
                        height: Dimensions.screenHeight / 20,
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(Dimensions.radius30),
                          color: AppColors.button3,
                        ),
                        child: Center(
                          child: BigText(
                            text: "Sign Up",
                            size: Dimensions.font20 + Dimensions.font20 / 4,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    )
                  ]),
                ],
              ))),
    );
  }
}
