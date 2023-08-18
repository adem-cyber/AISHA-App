import 'package:flutter/material.dart';
import 'package:flutter_application_1/utils/dimensions.dart';
import 'package:flutter_application_1/widgets/small_text.dart';

class IconAndTextWidget extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color iconColor;
   
  const IconAndTextWidget({super.key, required this.icon, required this.text,  required this.iconColor});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon,color: iconColor, size: Dimensions.iconSize24,),
        const SizedBox(width: 7,),
        SamllText(text: text,),
      ],
    );
  }
}