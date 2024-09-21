import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserTokenProvider with ChangeNotifier {
  String? _token;

  String? get token => _token;

  Future<void> loadToken() async {
    final prefs = await SharedPreferences.getInstance();
    _token = prefs.getString('token') ?? '';
    notifyListeners();
  }

  Future<void> setToken(String token) async {
    _token = token;
    final prefis = await SharedPreferences.getInstance();
    await prefis.setString('token', token);
    notifyListeners();

  }
  Future<void> clearToken() async {
    _token = '';
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    notifyListeners();
  }
}
