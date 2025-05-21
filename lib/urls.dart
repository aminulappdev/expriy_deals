class Urls {
   static const String _baseUrl = 'http://115.127.156.131:7000/api/v1';
  // static const String _baseUrl = 'http://192.168.10.160:8000/api/v1';
  static const String createUserUrl = '$_baseUrl/users';
  static const String otpVerifyrUrl = '$_baseUrl/otp/verify-otp';
  static const String signInUrl = '$_baseUrl/auth/login';
  static const String forgotPasswordUrl = '$_baseUrl/auth/forgot-password';
  static const String resendOTPUrl = '$_baseUrl/otp/resend-otp';
  static const String resetPasswordUrl = '$_baseUrl/auth/reset-password';
  static const String googleAuthUrl = '$_baseUrl/auth/google-login';


  static String updateUserByUrl(
    String id,
  ) {
    return '$_baseUrl/users/update/$id';
  }
}
