import 'package:flutter/material.dart';
import 'package:flutter_application_1/utils/dimensions.dart';



// ignore: must_be_immutable
class  BigText extends StatelessWidget {
   Color? color;
  final String text;
  double size;
  TextOverflow overflow;

 BigText({Key? key ,this.color =  const Color.fromARGB(255, 3, 3, 3) ,  required this.text , this.size=0,
 this.overflow=TextOverflow.ellipsis, }) : super(key:key);

 @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: 1,
      overflow: overflow,
      style: TextStyle(
        color: color,
        fontWeight: FontWeight.w400,
        fontFamily: 'Roboto',
        fontSize:size==0? Dimensions.font20:size,
       ),

    );
  }
}