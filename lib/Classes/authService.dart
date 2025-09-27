import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:my_app/Classes/apiService.dart';


class AuthService {
  // User registration
  static Future<Map<String, dynamic>> register(
      String name, String email, String password, String passwordConfirmation) async {
    final response = await http.post(
      Uri.parse('${ApiService.baseUrl}/register'),
      headers: await ApiService.getHeaders(),
      body: json.encode({
        'name': name,
        'email': email,
        'password': password,
        'password_confirmation': passwordConfirmation,
      }),
    );

    final data = ApiService.handleResponse(response);
    
    // Save token after registration
    if (data['token'] != null) {
      await ApiService.saveToken(data['token']);
    }
    
    return data;
  }

  // User login
  static Future<Map<String, dynamic>> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('${ApiService.baseUrl}/login'),
      headers: await ApiService.getHeaders(),
      body: json.encode({
        'email': email,
        'password': password,
      }),
    );

    final data = ApiService.handleResponse(response);
    
    // Save token after login
    if (data['token'] != null) {
      await ApiService.saveToken(data['token']);

      print(  'Token saved: ${data['token']}');
    }
    
    return data;
  }

  // User logout
  static Future<void> logout() async {
    final response = await http.post(
      Uri.parse('${ApiService.baseUrl}/logout'),
      headers: await ApiService.getHeaders(),
    );

    ApiService.handleResponse(response);
    await ApiService.removeToken();
  }

  // Get current user
  static Future<Map<String, dynamic>> getCurrentUser() async {
    final response = await http.get(
      Uri.parse('${ApiService.baseUrl}/user'),
      headers: await ApiService.getHeaders(),
    );

    return ApiService.handleResponse(response);
  }
}