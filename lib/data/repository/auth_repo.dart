

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_1/pages/home/home_page.dart';
import 'package:get/get.dart';
import '../../pages/account/sign_in.dart';

class AuthenticationRepo extends GetxController{
  static AuthenticationRepo get instance => Get.find();

   final _auth = FirebaseAuth.instance;
   late final Rx<User?> firebaseUser;
   var verificationId= "".obs;

   @override
   void onReady(){
    Future.delayed(const Duration(seconds: 6));
    firebaseUser = Rx<User?> (_auth.currentUser) ;
    firebaseUser.bindStream(_auth.userChanges());
    ever(firebaseUser, _setInitialScreen);

      }
      
_setInitialScreen(User? user){
  user == null ? Get.offAll(()=> const SignInPage() ) : Get.offAll(()=> const HomePage());
}
 
void phoneAuthentication(String phone)async{
  await _auth.verifyPhoneNumber(
    phoneNumber: phone,
    verificationCompleted: (credential)async{
      await _auth.signInWithCredential(credential);
    }, 
     
    codeSent: (verificationId,resendToken){
      this.verificationId.value = verificationId;
    }, 
    codeAutoRetrievalTimeout: (verificationId){
      this.verificationId.value = verificationId;
    },
      
    verificationFailed: (e){
      if(e.code == "invalid-phone-number"){
        Get.snackbar("Error", 'The provided phone number is not valid.');
      }else{
        Get.snackbar("Error", 'something went wrong. Try again');

      }
    },
    );
}
  
Future <bool> verifyOTP(String otp) async{
  var credentials =await _auth
   .signInWithCredential(PhoneAuthProvider.credential(verificationId: verificationId.value,smsCode:otp ));
  return credentials.user !=null ? true : false;
}

/*
 Future<void> createUserWithEmailAndPassword(String email, String password) async{
  try{

  await _auth.createUserWithEmailAndPassword(email: email, password: password);
  firebaseUser.value !=null ? Get.offAll(()=> const HomePage()): Get.to(()=>const SignInPage());
  } on FirebaseAuthException catch(e){
    final ex = SignUpWithEmailAndPasswordFailure.code(e.code);
    print('FIREBASE AUTH EXCEPTION -${ex.message}');
    throw ex;
  }catch(_){  
    const ex = SignUpWithEmailAndPasswordFailure();
    print('EXCEPTION -${ex.message}');
    throw ex;
  }
}*/
Future<void> loginUserWithPhoneAndPassword(String phone, String password) async{
  try{
  await _auth.signInWithPhoneNumber(phone);
 
  }catch(_){}
}
Future<void> logout()async => await  _auth.signOut();

   }