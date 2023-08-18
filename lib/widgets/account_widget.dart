import 'package:flutter/material.dart';
import 'package:flutter_application_1/utils/dimensions.dart';
import 'package:flutter_application_1/widgets/app_icon.dart';
import 'package:flutter_application_1/widgets/big_text.dart';

class AccountWidget extends StatelessWidget {
  AppIcon appIcon;
  BigText bigText;
   AccountWidget({super.key, required this.appIcon, required this.bigText, required String initialValue});

  @override
  Widget build(BuildContext context) {
    return Container(
      
      padding: EdgeInsets.only(
        left: Dimensions.width10,
        top: Dimensions.width10,
        bottom: Dimensions.width10,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow:[
        BoxShadow(
          blurRadius: 1,
          offset: const Offset(0, 5),
          color: Colors.grey.withOpacity(0.2),
          ),
        ]
           ),
      child: Row(
        children: [
          appIcon,
          SizedBox(width: Dimensions.width20,),
          bigText,
        ],
      ),
    );
  } 
}