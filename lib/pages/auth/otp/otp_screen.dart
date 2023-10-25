import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/otp_controller.dart';
import 'package:flutter_application_1/data/repository/auth_repo.dart';
import 'package:flutter_application_1/pages/account/sign_in.dart';
import 'package:flutter_application_1/widgets/small_text.dart';
import 'package:get/get.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Import Firebase Authentication

class OTPScreen extends StatefulWidget {
  const OTPScreen({super.key});

  @override
  _OTPScreenState createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  late String otp;
  late int _remainingTime;
  late String verificationId;

  late Timer _timer; // Define the timer variable

  @override
  void initState() {
    super.initState();
    _remainingTime = 60;
    startTimer();
  }

  void startTimer() {
    const oneSecond = Duration(seconds: 1);
    _timer = Timer.periodic(oneSecond, (timer) {
      if (_remainingTime == 0) {
        timer.cancel();
      } else {
        setState(() {
          _remainingTime--;
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel(); // Cancel the timer in the dispose method to avoid the error
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "CODE",
              style: TextStyle(
                fontSize: 50,
                fontWeight: FontWeight.w900,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 5,
            ),
            SamllText(
              text: "Verification",
              size: 20,
            ),
            const SizedBox(
              height: 5,
            ),
            const Text(
              "Enter the verification code sent via SMS",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w200,
                color: Color.fromARGB(95, 53, 52, 52),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 20,
            ),
            OTPTextField(
              length: 6,
              width: MediaQuery.of(context).size.width,
              textFieldAlignment: MainAxisAlignment.spaceAround,
              fieldWidth: 45,
              fieldStyle: FieldStyle.box,
              outlineBorderRadius: 15,
              style: const TextStyle(fontSize: 17),
              onChanged: (code) {
                otp = code;
              },
              onCompleted: (code) {
                otp = code;
              
                OTPController.instance.verifyOTP(otp);
              },
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              "Time remaining: $_remainingTime seconds",
              style: TextStyle(
                fontSize: 16,
                color: Colors.black54,
              ),
            ),
            
              
            ElevatedButton(
  onPressed: () {
    
   Get.to(()=>SignInPage());
  },
  child: Text(
    "Back",
    style: TextStyle(fontSize: 16),
  ),
),

          ],
        ),
      ),
    );
  }
}
