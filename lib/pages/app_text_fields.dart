import 'package:flutter/material.dart';
import 'package:flutter_application_1/utils/colors.dart';

import '../../utils/dimensions.dart';



class AppTextFieldd extends StatelessWidget {
  final TextEditingController textController;
  final String hintText;
  final IconData icon;
  final String? Function(String?)? validator;
  final bool obscureText;
  const AppTextFieldd(GlobalKey<FormState> formKey, {
    Key? key,
    required this.textController,
    required this.hintText,
    required this.icon,
    this.validator,
    this.obscureText = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: Dimensions.height20,
        vertical: Dimensions.height10,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(Dimensions.radius30),
        boxShadow: [
          BoxShadow(
            blurRadius: 10,
            spreadRadius: 7,
            offset: const Offset(1, 10),
            color: const Color.fromARGB(255, 12, 12, 12).withOpacity(0.2),
          ),
        ],
      ),
      child: TextFormField(
        controller: textController,
        obscureText: obscureText,
        decoration: InputDecoration(
          hintText: hintText,
          prefixIcon: Icon(icon, color: Colors.black),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(Dimensions.radius30),
            borderSide: const BorderSide(
              width: 1.3,
              color: AppColors.button1,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(Dimensions.radius30),
            borderSide: const BorderSide(
              width: 1.0,
              color: Color.fromARGB(255, 244, 245, 246),
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(Dimensions.radius30),
          ),
        ),
        validator: validator,
      ),
    );
  }
}