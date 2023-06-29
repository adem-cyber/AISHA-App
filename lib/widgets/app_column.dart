import 'package:flutter/material.dart';
import 'package:flutter_application_1/widgets/small_text.dart';

import '../utils/colors.dart';
import '../utils/dimensions.dart';
import 'big_text.dart';
import 'icon_and_text.dart';

class AppColumn extends StatelessWidget {
  final String text;
  const AppColumn({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BigText(text: text,size: Dimensions.font26,),
                SizedBox(height: Dimensions.height10,),
                Row(
                  children: [
                    Wrap(
                      children: List.generate(5, (index) => const Icon(Icons.star,color: AppColors.mainColor,size: 15,)),
                    ),
                    SizedBox(width: Dimensions.width10,),
                    SamllText(text: "4.5"),
                     SizedBox(width: Dimensions.width10,),
                    SamllText(text: '1287'),
                     SizedBox(width: Dimensions.width10,),
                    SamllText(text: "comments"),
                  ],
                ),
    
               SizedBox(height: Dimensions.height10,),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                
                children: [
                IconAndTextWidget(icon: Icons.circle_sharp, text: "Normal",  iconColor:AppColors.iconcolor1),
                IconAndTextWidget(icon: Icons.location_on, text: "1.5km",  iconColor:AppColors.mainColor),
                IconAndTextWidget(icon: Icons.access_time_rounded, text: "Normal",  iconColor:AppColors.iconcolor2),

                ],
              ),
            ],
            );
  }


}