import 'dart:convert';
import 'package:http/http.dart' as http;
import '../config/api_config.dart';
import 'storage_service.dart';

class ApiService {
  Future<Map<String, String>> _headers() async {
    final token = await StorageService.getToken();
    return {
      "Content-Type": "application/json",
      if (token != null) "Authorization": "Bearer $token",
    };
  }

  Future<http.Response> get(String path) async {
    final uri = Uri.parse(ApiConfig.url(path));
    return http
        .get(uri, headers: await _headers())
        .timeout(const Duration(milliseconds: ApiConfig.defaultTimeoutMs));
  }

  Future<http.Response> post(String path, Map<String, dynamic> body) async {
    final uri = Uri.parse(ApiConfig.url(path));
    return http
        .post(uri, headers: await _headers(), body: jsonEncode(body))
        .timeout(const Duration(milliseconds: ApiConfig.defaultTimeoutMs));
  }

  Future<http.Response> put(String path, Map<String, dynamic> body) async {
    final uri = Uri.parse(ApiConfig.url(path));
    return http
        .put(uri, headers: await _headers(), body: jsonEncode(body))
        .timeout(const Duration(milliseconds: ApiConfig.defaultTimeoutMs));
  }

  Future<http.Response> delete(String path) async {
    final uri = Uri.parse(ApiConfig.url(path));
    return http
        .delete(uri, headers: await _headers())
        .timeout(const Duration(milliseconds: ApiConfig.defaultTimeoutMs));
  }
}
