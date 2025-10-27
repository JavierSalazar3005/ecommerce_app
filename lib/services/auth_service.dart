import 'dart:convert';
import 'api_service.dart';
import 'storage_service.dart';

class AuthService {
  final _api = ApiService();

  Future<bool> login(String email, String password) async {
    final res = await _api.post("/auth/login", {
      "email": email,
      "password": password,
    });

    if (res.statusCode == 200) {
      final data = jsonDecode(res.body);
      await StorageService.saveToken(data["token"]);
      return true;
    }
    return false;
  }

  Future<bool> register(String email, String password,
      {String role = "Customer"}) async {
    final res = await _api.post("/auth/register", {
      "email": email,
      "password": password,
      "role": role,
    });

    if (res.statusCode == 200) {
      final data = jsonDecode(res.body);
      await StorageService.saveToken(data["token"]);
      return true;
    }
    return false;
  }
}
