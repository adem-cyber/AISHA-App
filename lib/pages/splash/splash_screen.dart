import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/front/front_page.dart';
import 'package:get/get.dart';

import '../../utils/dimensions.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {

  late Animation<double> animation;
  late AnimationController controller;
 

  
  @override
  void initState(){
   // initState();

     controller= AnimationController(
      vsync: this,duration: 
      const Duration(seconds: 2))..forward();

     animation= CurvedAnimation(
      parent: controller, 
      curve: Curves.fastEaseInToSlowEaseOut);
      Timer(
        const Duration(seconds: 3),
        ()=>Get.to(()=>const FrontPage())
      );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 1, 124, 195),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ScaleTransition(scale: animation, 
        child:  Center(child: Image.asset("assets/images/logo 6.png",width: Dimensions.splashImg,))),
          
           Center(child: Image.asset("assets/images/logo3.png", width: Dimensions.splashImg,))
         
          

        ]),
    );
  }

}