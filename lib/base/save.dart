import 'dart:ffi';

class SaveData {
  static Map<String, dynamic> _userData = {};

  static void storeUserData(Map<String, dynamic> userData) {
    _userData = userData;
  }

  static Map<String, dynamic> retrieveUserData() {
    return _userData;
  }

  static void clearUserData() {
    _userData.clear();
  }
}
