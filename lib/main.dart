import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/otp_controller.dart';
import 'package:flutter_application_1/controller/profile_controller.dart';
import 'package:flutter_application_1/data/repository/auth_repo.dart';
import 'package:flutter_application_1/data/repository/store_repo_vendor.dart';
import 'package:flutter_application_1/pages/front/front_page.dart';
import 'package:flutter_application_1/pages/home/home_page.dart';
import 'package:flutter_application_1/pages/splash/splash_screen.dart';
import 'package:flutter_application_1/data/repository/authentication_repo_vendor.dart';
import 'package:flutter_application_1/pages/vendor/home/home_page_vendor.dart';
import 'package:flutter_application_1/pages/vendor/otp_controller_vendor.dart';

import 'package:flutter_application_1/pages/vendor/profile_controller_vendor.dart';
import 'package:flutter_application_1/widgets/loading_screen.dart';
import 'package:get/get.dart';

import 'controller/cart_controller.dart';
import 'controller/order_controller.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
   //FirebaseAuth.instance.setPersistence(Persistence.LOCAL);
 
  Get.put(AuthenticationRepo());
  Get.put(CartController());
  Get.put(OrderController());
  Get.put(ProfileController());
  Get.put(AuthenticationRepoVendor());
  Get.put(StoreRepoVendor());
   Get.put(ProfileControllervendor());
   Get.put(OTPController());
  Get.put(OTPControllerVendor());
  runApp( const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'IIYISHHA',
      initialRoute: '/splash', // Set the initial route to the splash screen
      getPages: [
        GetPage(name: '/splash', page: () => const SplashScreen()),
        //GetPage(name: '/loading', page: () => const LoadingScreen()),
        //GetPage(name: '/frontPage', page: () => const FrontPage()),
        GetPage(name: '/HomePage', page: () => const HomePage()), 
         //GetPage(name: '/vendorHomePage', page: () => const HomePagevendor()),
      ],
    );
  }
}




