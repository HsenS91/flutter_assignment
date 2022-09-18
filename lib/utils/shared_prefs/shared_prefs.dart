import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static final SharedPrefs _SharedPrefs = SharedPrefs._internal();

  static bool? REMEMBER_ME;

  factory SharedPrefs() {
    return _SharedPrefs;
  }

  SharedPrefs._internal();

  Future<void> setRememberMe(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('rememberMe', value);

    REMEMBER_ME = value;
  }


  Future<void> saveData(String data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('data', data);
  }

  Future<String> getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('data')??'';
  }


  Future<void> clearAll() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}