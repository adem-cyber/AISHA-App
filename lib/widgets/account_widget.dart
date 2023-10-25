import 'package:flutter/material.dart';
import 'package:flutter_application_1/utils/dimensions.dart';
import 'package:flutter_application_1/widgets/app_icon.dart';
import 'package:flutter_application_1/widgets/big_text.dart';

class AccountWidget extends StatelessWidget {
  final AppIcon appIcon;
  final BigText bigText;
  final bool obscureText;
  final VoidCallback? onPressed;

  const AccountWidget({
    Key? key,
    required this.appIcon,
    this.onPressed,
    required this.bigText,
    required String initialValue,
    this.obscureText = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 10, // Adjust the horizontal padding
        vertical: 5.0,   // Adjust the vertical padding
      ),
      child: Container(
        //alignment: AlignmentDirectional,
        width: Dimensions.screenWidth / 1.16,
        height: Dimensions.screenHeight / 30,
        decoration: BoxDecoration(
          //color: const Color.fromARGB(255, 237, 237, 237),
          //borderRadius: BorderRadius.circular(60.0),
          //boxShadow: [
          //  BoxShadow(
           //   color: Colors.grey.withOpacity(0.9),
          //  ),
        //  ],
        ),
        child: Row(
          children: [
            appIcon,
            SizedBox(width: Dimensions.width10),
            Expanded(
              child: bigText,
            ),
            if (onPressed != null)
              IconButton(
                onPressed: onPressed,
                icon: const Icon(Icons.edit),
                color: Colors.blue,
              ),
          ],
        ),
      ),
    );
  }
}
