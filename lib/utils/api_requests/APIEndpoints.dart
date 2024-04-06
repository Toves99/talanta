class APIEndpoints{
  static const String baseUrl = "http://209.38.174.113:5001/v1";
  static const String josdapURL = "http://209.38.174.113:8081";
  static const String loginEndpoint = "$baseUrl/auth/login";
  static const String signupEndpoint = "$baseUrl/auth/signup";
  static const String personalityQuestionsEndpoint = "$baseUrl/personality/test/take_test";
  static const String verifyEmail = "$baseUrl/auth/verify-email";
  static const String savePersonality = "$baseUrl/personality/test/save";
  static const String initiateSTK = "$baseUrl/payment/initiateStk";
  static const String verifyPayment = "$baseUrl/payment/verifyPayment";
  static const String retrievePersonality = "$baseUrl/personality/test/retrieve";
}