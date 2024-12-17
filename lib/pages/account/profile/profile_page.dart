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
import 'package:get/get.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  AccountPageState createState() => AccountPageState();
}

class AccountPageState extends State<AccountPage> {
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
        actions: [
          IconButton(
            icon: Icon(Icons.logout), // Add logout icon here
            onPressed: () {
              AuthenticationRepo.instance.logout();
            },
          ),
        ],
      ),
      body: Container(
        width: double.maxFinite,
        margin: EdgeInsets.only(top: Dimensions.height20),
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
                      icon: Icons.person_4_outlined,
                      backgroundColor: Colors.orange,
                      iconColor: Colors.white,
                      iconsize: Dimensions.height20 + Dimensions.height30,
                      size: Dimensions.height15 * 6,
                    ),
                    SizedBox(
                      height: Dimensions.height10 * 1.5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            BigText(
                              text: userData.name.toUpperCase(),
                              size: Dimensions.font16 + Dimensions.font16 / 8,
                              color: Colors.black,
                            ),
                            SizedBox(
                              height: Dimensions.height10,
                            ),
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Get.to(() => EditProfilePage(
                                          currentUser: userData,
                                        ));
                                  },
                                  child: Row(
                                    children: [
                                      Text(
                                        'Edit',
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.blueGrey),
                                      ),
                                      // Optional spacing between text and icon
                                      Icon(
                                        Icons
                                            .edit_outlined, // Use a different edit icon
                                        color: Colors.black26,
                                        size: 14,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: Dimensions.height30 * 2,
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Form(
                          child: Column(
                            children: [
                              //name

                              //phone
                              AccountWidget(
                                  initialValue: userData.phone,
                                  appIcon: AppIcon(
                                      icon: Icons.phone,
                                      backgroundColor: Colors.green,
                                      iconColor: Colors.white,
                                      iconsize: Dimensions.height10 * 1.5,
                                      size: Dimensions.height10 * 2),
                                  bigText: BigText(
                                    text: userData.phone,
                                    size: 16,
                                  )),
                              SizedBox(
                                height: Dimensions.height20,
                              ),
                              //email

                              //address
                              AccountWidget(
                                initialValue: userData.address != null
                                    ? userData.address.toString()
                                    : "Fill address in Edit profile",
                                appIcon: AppIcon(
                                  icon: Icons.location_on_outlined,
                                  backgroundColor: Colors.black,
                                  iconColor: Colors.white,
                                  iconsize: Dimensions.height10 * 1.5,
                                  size: Dimensions.height10 * 2,
                                ),
                                bigText: BigText(
                                  text: userData.address != null
                                      ? userData.address.toString()
                                      : "Fill address in Edit profile",
                                  size: 16,
                                ),
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
                                  backgroundColor: Colors.orange,
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
                                  color: Colors.white,
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
