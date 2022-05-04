import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefHelper {
  final SharedPreferences preferences;

  SharedPrefHelper({required this.preferences});

  static const _DATA = "data";
  static const _THEME = "theme";

  Future saveValueDarkTheme(bool value) async {
    preferences.setBool(_THEME, value);
  }

  Future<bool> getValueDarkTheme() async {
    return preferences.getBool(_THEME) ?? false;
  }
}
