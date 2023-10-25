import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/front/front_page.dart';
import 'package:flutter_application_1/widgets/loading_screen.dart';
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
  late Timer _timer; // Declare the timer variable

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..forward();

    animation = CurvedAnimation(
      parent: controller,
      curve: Curves.fastEaseInToSlowEaseOut,
    );

    _timer = Timer(
      const Duration(seconds: 3),
      () => Get.to(() =>  const LoadingScreen ()),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    _timer.cancel(); // Cancel the timer when the widget is disposed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/13.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ScaleTransition(scale: animation, 
        child:  Center(child: Image.asset("assets/images/logo10.png",width: Dimensions.splashImg,))),
          
          // Center(child: Image.asset("assets/images/logo3.png", width: Dimensions.splashImg,))
         
          

        ]),
    ),
    );
  }

}