import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/profile_controller.dart';
import 'package:flutter_application_1/data/repository/auth_repo.dart';
import 'package:flutter_application_1/model/user_model.dart';
import 'package:flutter_application_1/pages/account/profile/edit_profile_page.dart';
import 'package:flutter_application_1/utils/colors.dart';
import 'package:flutter_application_1/utils/dimensions.dart';
import 'package:flutter_application_1/widgets/account_widget.dart';
import 'package:flutter_application_1/widgets/app_icon.dart';
import 'package:flutter_application_1/widgets/big_text.dart';
import 'package:flutter_application_1/widgets/user_account_widget.dart';
import 'package:get/get.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  late UserModel userData; // Store the user data in the state

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    final controller = Get.find<ProfileController>();
    final user = await controller.getUserData();
    if (user != null) {
      setState(() {
        userData = user;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ProfileController>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        title: BigText(
          text: "Profile",
          size: 24,
          color: Colors.white,
        ),
      ),
      body: Container(
        width: double.maxFinite,
        margin: EdgeInsets.only(top: Dimensions.height30),
        child: FutureBuilder(
          future: controller.getUserData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                userData = snapshot.data as UserModel;
                return Column(
                  children: [
                    //profile icon
                    AppIcon(
                      icon: Icons.person_4_sharp,
                      backgroundColor: AppColors.button3,
                      iconColor: Colors.white,
                      iconsize: Dimensions.height20 + Dimensions.height30,
                      size: Dimensions.height15 * 7,
                    ),
                    SizedBox(
                      height: Dimensions.height20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () async {
                            final updatedUser = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    EditProfilePage(currentUser: userData),
                              ),
                            );

                            if (updatedUser != null) {
                              // Update the UI with the updated user data
                              setState(() {
                                userData = updatedUser;
                              });
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(Dimensions.radius30),
                            ),
                            minimumSize: Size(Dimensions.screenWidth / 2,
                                Dimensions.screenHeight / 20),
                          ),
                          child: BigText(
                            text: "Edit Profile",
                            size: Dimensions.font16 + Dimensions.font16 / 8,
                            color: AppColors.button3,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: Dimensions.height30,
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Form(
                          child: Column(
                            children: [
                              //name
                              AccountWidgett(
                                  initialValue: userData.name,
                                  appIcon: AppIcon(
                                      icon: Icons.person_4_sharp,
                                      backgroundColor: Colors.blue,
                                      iconColor: Colors.white,
                                      iconsize: Dimensions.height10 * 2,
                                      size: Dimensions.height10 * 5),
                                  bigText: BigText(
                                    text: userData.name,
                                    size: 20,
                                  )),
                              SizedBox(
                                height: Dimensions.height20,
                              ),

                              //phone
                              AccountWidgett(
                                  initialValue: userData.phone,
                                  appIcon: AppIcon(
                                      icon: Icons.phone,
                                      backgroundColor: Colors.green,
                                      iconColor: Colors.white,
                                      iconsize: Dimensions.height10 * 2,
                                      size: Dimensions.height10 * 5),
                                  bigText: BigText(
                                    text: userData.phone,
                                    size: 20,
                                  )),
                              SizedBox(
                                height: Dimensions.height20,
                              ),
                              //email
                              AccountWidgett(
                                  initialValue: userData.email,
                                  appIcon: AppIcon(
                                      icon: Icons.email,
                                      backgroundColor: Colors.black12,
                                      iconColor: Colors.white,
                                      iconsize: Dimensions.height10 * 2,
                                      size: Dimensions.height10 * 5),
                                  bigText: BigText(
                                    text: userData.email,
                                    size: 20,
                                  )),
                              SizedBox(
                                height: Dimensions.height20,
                              ),
                              AccountWidgett(
                                initialValue: userData.address != null &&
                                        userData.address!.isNotEmpty
                                    ? userData.address.toString()
                                    : "Fill address in Edit profile",
                                appIcon: AppIcon(
                                  icon: Icons.location_on_outlined,
                                  backgroundColor: Colors.black,
                                  iconColor: Colors.white,
                                  iconsize: Dimensions.height10 * 2,
                                  size: Dimensions.height10 * 5,
                                ),
                                bigText: BigText(
                                  text: userData.address != null &&
                                          userData.address!.isNotEmpty
                                      ? userData.address.toString()
                                      : "Fill address in Edit profile",
                                  size: 20,
                                ),
                              ),

                              //address

                              SizedBox(
                                height: Dimensions.height20,
                              ),

                              SizedBox(
                                height: Dimensions.height20,
                              ),

                              SizedBox(
                                height: Dimensions.height10,
                              ),

                              ElevatedButton(
                                onPressed: () async {
                                  AuthenticationRepo.instance.logout();
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        Dimensions.radius30),
                                  ),
                                  minimumSize: Size(Dimensions.screenWidth / 4,
                                      Dimensions.screenHeight / 20),
                                ),
                                child: BigText(
                                  text: "Logout",
                                  size:
                                      Dimensions.font16 + Dimensions.font16 / 8,
                                  color: AppColors.button3,
                                ),
                              ),
                              SizedBox(
                                height: Dimensions.height20,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              } else if (snapshot.hasError) {
                return Center(child: Text(snapshot.error.toString()));
              } else {
                return const Center(child: Text("Something went wrong"));
              }
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}
