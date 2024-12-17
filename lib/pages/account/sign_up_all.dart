import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/base/save.dart';
import 'package:flutter_application_1/data/repository/auth_repo.dart';
import 'package:flutter_application_1/data/repository/authentication_repo_vendor.dart';
import 'package:flutter_application_1/pages/account/sign_in_all.dart';
import 'package:flutter_application_1/pages/front/front_page.dart';
import 'package:flutter_application_1/utils/colors.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

import '../../controller/signup_controller.dart';
import '../../model/user_model.dart';
import '../../utils/dimensions.dart';
import '../../widgets/big_text.dart';

class SignUpPageAll extends StatefulWidget {
  const SignUpPageAll({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPageAll> {
  final SignUpController controller = Get.put(SignUpController());
  final formKey = GlobalKey<FormState>();

  late final TextEditingController nameController = TextEditingController();
  late final TextEditingController phoneController = TextEditingController();
  late final TextEditingController emailController = TextEditingController();
  late final TextEditingController passwordController = TextEditingController();
  String type = 'User';
  var vendorid = const Uuid().v4();

  void choosen(String type) {
    setState(() {
      this.type = type;
    });
  }

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
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    SizedBox(
                      height: Dimensions.screenHeight * 0.3,
                    ),
                    Center(
                      child: Column(
                        children: [
                          Text(
                            "Welcome",
                            style: TextStyle(
                              fontSize:
                                  Dimensions.font16 + Dimensions.font20 / 2,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          Text(
                            "Create your account",
                            style: TextStyle(
                              fontSize: Dimensions.font16,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[900],
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: Dimensions.screenHeight * 0.01,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    color: type == 'User'
                                        ? Colors.blue
                                        : Colors.grey,
                                    width: 2,
                                  ),
                                ),
                              ),
                              child: TextButton(
                                onPressed: () {
                                  choosen('User');
                                  print(type);
                                },
                                style: TextButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(9)),
                                  ),
                                  minimumSize: Size(
                                    Dimensions.screenWidth / 2.5,
                                    Dimensions.screenHeight / 15,
                                  ),
                                ),
                                child: BigText(
                                  text: "User",
                                  size: type == 'User' ? 20 : 16,
                                  color: type == 'User'
                                      ? Colors.blue
                                      : Colors.grey[700],
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    color: type == 'Vendor'
                                        ? Colors.blue
                                        : Colors.grey,
                                    width: 2,
                                  ),
                                ),
                              ),
                              child: TextButton(
                                onPressed: () {
                                  choosen('Vendor');
                                  print(type);
                                },
                                style: TextButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(9)),
                                  ),
                                  minimumSize: Size(
                                    Dimensions.screenWidth / 2.5,
                                    Dimensions.screenHeight / 15,
                                  ),
                                ),
                                child: BigText(
                                  text: "Vendor",
                                  size: type == 'Vendor' ? 20 : 16,
                                  color: type == 'Vendor'
                                      ? Colors.blue
                                      : Colors.grey[700],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: 350,
                      child: TextFormField(
                        controller: nameController,
                        style: const TextStyle(
                            fontSize: 16.0, color: Colors.black),
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
                        style: const TextStyle(
                            fontSize: 16.0, color: Colors.black),
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
                          if (value == null ||
                              value.isEmpty ||
                              value[0] == '0') {
                            return 'Please Enter your phone number';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(
                      height: Dimensions.height20,
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          Get.dialog(
                            const Center(child: CircularProgressIndicator()),
                            barrierDismissible: false,
                          );
                          String phone;
                          if (phoneController.text.trim()[0] == '0') {
                            phone = '+251' +
                                phoneController.text.trim().substring(1, 10);
                            print(phone);
                          } else {
                            phone = '+251' + phoneController.text.trim();
                          }
                          print(phone);
                          final userExists = await SignUpController.instance
                              .userExistsByEmailOrPhone(phone);
                          if (userExists) {
                            const snackBar = SnackBar(
                              content: Text(
                                  'User with this phone already exists try logging in.'),
                              backgroundColor: Colors.orangeAccent,
                              duration: Duration(seconds: 3),
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          } else if (type == 'Vendor') {
                            SaveData.storeUserData({
                              'Name': nameController.text.trim(),
                              'Phone': phone,
                              'VendorID': vendorid,
                            });
                            await AuthenticationRepoVendor.instance
                                .phoneAuthentication(phone);
                          } else if (type == "User") {
                            SaveData.storeUserData({
                              'Name': nameController.text.trim(),
                              'Phone': phone,
                            });
                            await AuthenticationRepo.instance
                                .phoneAuthentication(phone);
                          }
                        }
                        Get.back();
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
                              ..onTap = () {
                                phoneController.clear();
                                nameController.clear();
                                Get.to(() => SignInPageAll(),
                                    transition: Transition.fade);
                              },
                            text: " Login",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
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
            Positioned(
              top: 40,
              left: 20,
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
