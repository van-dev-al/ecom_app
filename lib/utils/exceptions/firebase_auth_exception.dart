class EFirebaseAuthException implements Exception {
  final String code;

  EFirebaseAuthException(this.code);

  String get message {
    switch (code) {
      case 'email-already-in-use':
        return 'The email is already registered. Please use a different email.';
      case 'invalid-email':
        return 'The email is invalid. Please enter a valid email.';
      case 'weak-password':
        return 'The password is too weak. Please choose a stronger password.';
      case 'user-disabled':
        return 'This user account has been disabled. Please contact the administrator.';
      case 'user-not-found':
        return 'User account has not been found. Please check the email.';
      case 'wrong-password':
        return 'The password is incorrect. Please try again.';
      case 'operation-not-allowed':
        return 'This operation is not allowed. Please contact support.';
      case 'too-many-requests':
        return 'Too many requests. Please try again later.';
      case 'network-request-failed':
        return 'Network error. Please check your internet connection and try again.';
      case 'invalid-credential':
        return 'The provided credential is invalid. Please check and try again.';
      case 'email-already-exists':
        return 'An account with this email already exists. Please use a different email.';
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
        return 'An error occurred while attempting to authenticate. Please try again.';
    }
  }
}
