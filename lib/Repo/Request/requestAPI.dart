class requestAPI {

  static const String ipaddress = "http://192.168.0.106:8000/";

  // Authentication
  static String get loginURL => "${ipaddress}loginLearner";
  static String get refreshURL => "${ipaddress}refreshToken";


}