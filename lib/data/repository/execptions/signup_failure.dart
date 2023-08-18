class SignUpWithEmailAndPasswordFailure{
  final String message;
 const SignUpWithEmailAndPasswordFailure([this.message="An Unkown error occurred"]);

 factory SignUpWithEmailAndPasswordFailure.code(String code){
  switch (code){
     case 'enter-name': 

    return const SignUpWithEmailAndPasswordFailure('Please enter your name');

    case 'weak-password': 

    return const SignUpWithEmailAndPasswordFailure('Please enter a stronger password');

    case 'invalid-email':

     return const SignUpWithEmailAndPasswordFailure('Please enter a valid email');

    case 'email-already-in-use': 

     return const SignUpWithEmailAndPasswordFailure('An account already exists');

    case 'operation_not_allowed':

     return const SignUpWithEmailAndPasswordFailure('Operation is not allowed. Please contact support');

    case 'user-disabled': 

    return const SignUpWithEmailAndPasswordFailure('This user has been disabled');

     case 'invalid-phonenumber': 

    return const SignUpWithEmailAndPasswordFailure('Please enter a valid phone number');

     case 'phonenumber-already-in-use': 
     
    return const SignUpWithEmailAndPasswordFailure('Phone number already in use');

    default: 
    return const SignUpWithEmailAndPasswordFailure();
  }
 }

}