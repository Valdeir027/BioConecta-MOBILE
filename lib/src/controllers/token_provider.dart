import 'package:flutter/foundation.dart';

class UserTokenProvider with ChangeNotifier {
  String? _token;

  String? get token => _token;

  void setToken(String token) {
    _token = token;
    notifyListeners(); // Notifica os widgets dependentes quando o token for atualizado
  }

  void clearToken() {
    _token = null;
    notifyListeners(); // Notifica os widgets dependentes quando o token for removido
  }
}
