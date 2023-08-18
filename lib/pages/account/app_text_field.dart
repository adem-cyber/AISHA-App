import 'package:flutter/material.dart';

import '../../utils/dimensions.dart';



class AppTextField extends StatelessWidget {
  final TextEditingController textController;
  final String hintText;
  final IconData icon;
  const AppTextField({super.key,
  required this.textController,
  required this.hintText,
  required this.icon
  });

  @override
  Widget build(BuildContext context) {
    return Container(
            margin:EdgeInsets.only(left: Dimensions.height20, right: Dimensions.height20),
            decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(Dimensions.radius30),
            boxShadow: [
              BoxShadow(
                blurRadius:10,
                spreadRadius: 7,
                offset:const Offset(1, 10),
                color: const Color.fromARGB(255, 12, 12, 12).withOpacity(0.2) 
              )
            ]
            ),
            child: TextField(
              controller: textController,
              decoration: InputDecoration(
                hintText: hintText,
                prefixIcon: Icon(icon, color:Colors.black),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(Dimensions.radius30),
                  borderSide: const BorderSide(
                    width: 1.0,
                    color:Color.fromARGB(255, 11, 201, 30), 
                  )
                  ),
                   enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(Dimensions.radius30),
                  borderSide: const BorderSide(
                    width: 1.0,
                    color:Color.fromARGB(255, 244, 245, 246), 
                  )  
                  ),
                  border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(Dimensions.radius30), 
                  ),
              ),
            )
          );
  }
}