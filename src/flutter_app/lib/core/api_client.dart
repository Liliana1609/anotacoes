import 'dart:convert';
import 'package:http/http.dart' as http;
import 'env.dart';

class ApiClient {
  ApiClient({required this.token});

  final String token;

  Uri _uri(String path) => Uri.parse('${AppEnv.apiBaseUrl}$path');

  Future<http.Response> get(String path) {
    return http.get(_uri(path), headers: _headers());
  }

  Future<http.Response> post(String path, Map<String, dynamic> body) {
    return http.post(_uri(path), headers: _headers(), body: jsonEncode(body));
  }

  Map<String, String> _headers() => {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      };
}
