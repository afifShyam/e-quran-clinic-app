class requestAPI {

  static const String ipaddress = "http://192.168.0.106:8000/";

  // Authentication
  static String get loginURL => "${ipaddress}loginLearner";
  static String get RegisterURL => "${ipaddress}registerLearner";
  static String get RegisterTutorURL => "${ipaddress}registerTutor";
  static String get loginURLTutor => "${ipaddress}loginTutor";

  //Token
  static String get refreshURL => "${ipaddress}refreshToken";
  static String get refreshURLTutor => "${ipaddress}refreshTokenTutor";

  //Tutoring Session Management
  static String get availableSlot => "${ipaddress}available-slot";
  static String get createSlot => "${ipaddress}create-slot";
  static String get createMultipleSlots => "${ipaddress}create-multiple-slot";
}
