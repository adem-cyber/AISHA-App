import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/otp_controller.dart';
import 'package:flutter_application_1/widgets/small_text.dart';
import 'package:get/get.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';

class OTPScreen extends StatelessWidget {
  
  const OTPScreen({super.key});


  @override
  Widget build(BuildContext context) {
    var otpController = Get.put(OTPController());
      String otp;
    return Scaffold(
      
      body: Container(
        padding: const EdgeInsets.all(40),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            
            children: [
              const Text("CODE",
                  style: TextStyle(
                      fontSize: 50,
                      fontWeight: FontWeight.w900,
                      color: Colors.black),
                  textAlign: TextAlign.center),
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
              const Text("Enter the veritfication code send at SMS",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w200,
                      color: Color.fromARGB(95, 53, 52, 52)),
                  textAlign: TextAlign.center),
               const SizedBox(
                height: 20),

               
         OTPTextField(
            
            length: 6,
            width: MediaQuery.of(context).size.width,
            textFieldAlignment: MainAxisAlignment.spaceAround,
            fieldWidth: 45,
            fieldStyle: FieldStyle.box,
            outlineBorderRadius: 15,
            style: const TextStyle(fontSize: 17),
            
           onChanged: (code) {
            
            },
            onCompleted: (code) {
              otp=code;
              OTPController.instance.verifyOTP(otp);
              
            }      
        
        ),
        const SizedBox(
                height: 10),
       
                
            ]),
      ),
    );
  }
}
