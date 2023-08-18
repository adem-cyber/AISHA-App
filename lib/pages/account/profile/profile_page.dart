import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/profile_controller.dart';
import 'package:flutter_application_1/data/repository/auth_repo.dart';
import 'package:flutter_application_1/model/user_model.dart';
import 'package:flutter_application_1/utils/colors.dart';
import 'package:flutter_application_1/utils/dimensions.dart';
import 'package:flutter_application_1/widgets/account_widget.dart';
import 'package:flutter_application_1/widgets/app_icon.dart';
import 'package:flutter_application_1/widgets/big_text.dart';
import 'package:get/get.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProfileController());
    return Scaffold(
      appBar: AppBar(
        backgroundColor:AppColors.mainColor,
        title: BigText(text: "Profile",size:24,color: Colors.white,), 
      ),
      body: Container(
        width: double.maxFinite,
        margin: EdgeInsets.only(top: Dimensions.height20),
      
      
      child:FutureBuilder(
        future: controller.getUserData(),
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.done){
            if(snapshot.hasData){
              UserModel userData = snapshot.data as UserModel;
              return  Column(
      
          children: [
            //profile icon
            AppIcon(icon: Icons.person,
            backgroundColor: AppColors.mainColor,
            iconColor: Colors.white,
            iconsize: Dimensions.height30+Dimensions.height45,
            size: Dimensions.height15*10,
            ),
            SizedBox(height: Dimensions.height30,),
      
            Expanded(
              child: SingleChildScrollView(
                child:Form(
                  child: Column(
                    children: [ 
                     //name
                  AccountWidget(
                    initialValue:userData.name,
                  appIcon:  AppIcon(icon: Icons.person,
                              backgroundColor: AppColors.mainColor,
                              iconColor: Colors.white,
                              iconsize: Dimensions.height10*5/2,
                              size: Dimensions.height10*5),
                  bigText: BigText(text: userData.name ,)
                  ),
                              SizedBox(height: Dimensions.height20,),
                              //phone
                               AccountWidget(
                    initialValue:userData.phone,

                  appIcon:  AppIcon(icon: Icons.phone,
                              backgroundColor: AppColors.yellowcolor,
                              iconColor: Colors.white,
                              iconsize: Dimensions.height10*5/2,
                              size: Dimensions.height10*5),
                  bigText: BigText(text: userData.phone,)
                  ),
                              SizedBox(height: Dimensions.height20,),
                              //email
                              AccountWidget(
                    initialValue:userData.email,

                  appIcon:  AppIcon(icon: Icons.email,
                              backgroundColor: Colors.black12,
                              iconColor: Colors.white,
                              iconsize: Dimensions.height10*5/2,
                              size: Dimensions.height10*5),
                  bigText: BigText(text: userData.email,)
                  ),
                              SizedBox(height: Dimensions.height20,),
                       
                              //address
                            /*  AccountWidget(
                    initialValue:"",

                  appIcon:  AppIcon(icon: Icons.location_on_outlined,
                              backgroundColor: Colors.green,
                              iconColor: Colors.white,
                              iconsize: Dimensions.height10*5/2,
                              size: Dimensions.height10*5),
                  bigText: BigText(text: "Fill in your address",)
                  ),*/
                              SizedBox(height: Dimensions.height20,),
                              //message
                              AccountWidget(
                    initialValue:userData.password,

                  appIcon:  AppIcon(icon: Icons.password_rounded,
                              backgroundColor: Colors.redAccent,
                              iconColor: Colors.white,
                              iconsize: Dimensions.height10*5/2,
                              size: Dimensions.height10*5),
                  bigText: BigText(text: userData.password,)
                  ),
                              SizedBox(height: Dimensions.height20,),
                      
                  GestureDetector(
                    onTap: () {
                     AuthenticationRepo.instance.logout();
                    },
                    child: AccountWidget(
                    initialValue:"",
                              appIcon:  AppIcon(icon: Icons.logout_rounded,
                            backgroundColor: AppColors.mainColor,
                            iconColor: Colors.white,
                            iconsize: Dimensions.height10*5/2,
                            size: Dimensions.height10*5),
                              bigText: BigText(text: "Logout",)
                              ),
                  ),
                            SizedBox(height: Dimensions.height20,)
                      
                              ],
                              ),
                )
              ),
            )
      
          /*,*/
      
          ],
          
      
        );
       }else if (snapshot.hasError){
            return Center(child: Text( snapshot.error.toString()));

       }else {
            return const Center(child: Text( "Something went wrong"));

        
       }

          }else{
            return const Center(child: CircularProgressIndicator(),);
             
          }
        },
      
      ),

    ),

    );
  }
}