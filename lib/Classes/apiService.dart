import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
class ApiService{
  static const String baseUrl = '';

  static String? _token;


  // getting the headers

  static Future<Map<String, String>> getHeaders() async {
    if (_token == null) {
      await getToken();
    }
    return {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $_token',
    };
  }


// Save token to shared preferences
  static Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('auth_token', token);
    _token = token;
  }

  // Get token from shared preferences
  static Future<String?> getToken() async {
    if (_token != null) return _token;
    
    final prefs = await SharedPreferences.getInstance();
    _token = prefs.getString('auth_token');
    return _token;
  }

  // Remove token (logout)
  static Future<void> removeToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('auth_token');
    _token = null;
  }

  // Handle API responses
  static dynamic handleResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
      case 201:
        return json.decode(response.body);
      case 401:
        throw Exception('Unauthorized - Please login again');
      case 403:
        throw Exception('Forbidden - Access denied');
      case 404:
        throw Exception('Resource not found');
      case 422:
        final errors = json.decode(response.body)['errors'];
        throw Exception(errors?.values.first[0] ?? 'Validation error');
      case 500:
        throw Exception('Server error');
      default:
        throw Exception('Something went wrong: ${response.statusCode}');
    }
  }


}