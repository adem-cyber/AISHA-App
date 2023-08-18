

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'data/repository/auth_repo.dart';
import 'firebase_options.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform) 
 .then((value)=>Get.put(AuthenticationRepo()));
  runApp(const MyApp());

}



class MyApp extends StatelessWidget {
  const MyApp({super.key});

  
  @override
  Widget build(BuildContext context) {
 
    return  const GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',

    home: CircularProgressIndicator()
   
    
    );
  //  });
    //});

  }

}
