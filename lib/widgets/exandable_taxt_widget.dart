import 'package:flutter/material.dart';
import 'package:flutter_application_1/utils/colors.dart';
import 'package:flutter_application_1/widgets/small_text.dart';

import '../utils/dimensions.dart';

class ExandableText extends StatefulWidget {
  final String text;
  const ExandableText({super.key, required this.text});

  @override
  State<ExandableText> createState() => _ExandableTextState();
}

class _ExandableTextState extends State<ExandableText> {
  late String firstHalf;
  late String secondHalf;

  bool hiddenText=true;

  double textHeight = Dimensions.screenHeight/5.63;

  @override
  void initState(){
    super.initState();
    if(widget.text.length>textHeight){
      firstHalf = widget.text.substring(0,textHeight.toInt());
      secondHalf = widget.text.substring(textHeight.toInt()+1,widget.text.length);

    }else{
      firstHalf=widget.text;
      secondHalf=" ";
    }
  }  
  @override
  Widget build(BuildContext context) {
    return Container(
      child: secondHalf.isEmpty?SamllText(size: Dimensions.font16,color: AppColors.paracolor,text: firstHalf): Column(
        children: [
          SamllText(height:1.8,color: AppColors.paracolor,size: Dimensions.font16, text: hiddenText?(firstHalf + "..."):(firstHalf+secondHalf)),

        InkWell(
          onTap: () {
            setState(() {
              hiddenText=!hiddenText;
            });
            
          },
          child: Row(
            children: [
              SamllText(text: "show more",color: AppColors.mainColor,),
              Icon(hiddenText?Icons.arrow_drop_down:Icons.arrow_drop_up,color: AppColors.mainColor,),
            ],
          ),
        )

        ],
      ),
    );
  }
}