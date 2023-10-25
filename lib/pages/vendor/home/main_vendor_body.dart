import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/vendor/home/main_vendor_page.dart';

class MainVendorBody extends StatelessWidget {
  const MainVendorBody({super.key});

  @override
  Widget build(BuildContext context) {

    return const Scaffold(
      
     
      
      body: SingleChildScrollView(
        
        child: FoodShopBodyVendor(),
      ),
    );
  }
}
