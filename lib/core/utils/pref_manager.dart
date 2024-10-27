import 'package:shared_preferences/shared_preferences.dart';

class PrefManager {
  String kToken = "token";

  SharedPreferences preferences;

  PrefManager(this.preferences);

  set token(String? value) => preferences.setString(kToken, value ?? "");

  String? get token => preferences.getString(kToken);

  void logout() => preferences.clear();
}
