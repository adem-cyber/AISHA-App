class SignInWithEmailAndPasswordFailure {
  final String message;

  const SignInWithEmailAndPasswordFailure([this.message = "An Unknown error occurred"]);

  factory SignInWithEmailAndPasswordFailure.code(String code) {
    switch (code) {
      case 'invalid-email':
        return const SignInWithEmailAndPasswordFailure('Invalid email format');
      case 'user-not-found':
        return const SignInWithEmailAndPasswordFailure('User not found');
      case 'wrong-password':
        return const SignInWithEmailAndPasswordFailure('Wrong password');
      case 'user-disabled':
        return const SignInWithEmailAndPasswordFailure('This user has been disabled');
      default:
        return const SignInWithEmailAndPasswordFailure();
    }
  }
}
