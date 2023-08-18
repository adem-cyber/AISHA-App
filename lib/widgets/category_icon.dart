import 'package:flutter/material.dart';
import 'package:flutter_application_1/widgets/small_text.dart';

import '../utils/colors.dart';
import '../utils/dimensions.dart';


class CategoryIcon extends StatelessWidget {
  final IconData icon;
  final String text;

  const CategoryIcon({required this.icon, required this.text, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.mainColor,
          ),
          child: Icon(icon, color: Colors.white, size: 40),
        ),
        SizedBox(height: Dimensions.height20),
        SamllText(text: text),
      ],
    );
  }
}