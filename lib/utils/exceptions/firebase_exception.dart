class EFirebaseException implements Exception {
  final String code;

  EFirebaseException(this.code);

  String get message {
    switch (code) {
      case 'permission-denied':
        return 'You do not have permission to perform this action.';
      case 'unavailable':
        return 'The server is currently unavailable. Please try again later.';
      case 'weak-password':
        return 'The password provided is too weak. Please choose a stronger password.';
      case 'email-already-in-use':
        return 'The account already exists for that email. Please use a different email.';
      case 'invalid-email':
        return 'The email address is malformed. Please enter a valid email address.';
      case 'user-not-found':
        return 'No user found with this email address.';
      case 'user-disabled':
        return 'This user account has been disabled. Please contact support.';
      case 'wrong-password':
        return 'The password entered is incorrect. Please try again.';
      case 'operation-not-allowed':
        return 'This operation is not allowed. Please contact support.';
      case 'too-many-requests':
        return 'Too many requests. Please try again later.';
      case 'network-request-failed':
        return 'Network error. Please check your internet connection and try again.';
      case 'invalid-credential':
        return 'The provided credential is invalid. Please check and try again.';
      case 'email-already-exists':
        return 'An account already exists with this email. Please use a different email.';
      case 'missing-android-pkg-name':
        return 'Android package name is missing. Please check your configuration.';
      case 'missing-continue-uri':
        return 'The continue URL is missing. Please check your configuration.';
      case 'invalid-continue-uri':
        return 'The continue URL is invalid. Please check your configuration.';
      case 'unauthorized-continue-uri':
        return 'The continue URL is unauthorized. Please check your configuration.';
      case 'account-exists-with-different-credential':
        return 'An account already exists with the same email address but different sign-in credentials.';
      case 'invalid-verification-code':
        return 'The verification code is invalid or expired.';
      case 'invalid-verification-id':
        return 'The verification ID is invalid.';
      case 'missing-phone-number':
        return 'Phone number is missing. Please provide a valid phone number.';
      case 'quota-exceeded':
        return 'Quota exceeded. Please try again later.';
      default:
        return 'A Firebase error occurred. Please try again.';
    }
  }
}
