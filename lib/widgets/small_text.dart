import 'package:flutter/material.dart';

// ignore: must_be_immutable
class SamllText extends StatelessWidget {
   Color? color;
  final String text;
  double size;
  double height;

SamllText({Key? key ,this.color = const Color(0xFFccc7c5) , 
 required this.text ,this.height=1.2, this.size=10,}) : super(key:key);

 @override
  Widget build(BuildContext context) {
    return Text(
      text,

      
      style: TextStyle(
        color: color,
        fontFamily: 'Roboto',
        fontSize: size,
        height: height,
       ),

    );
  }
}
