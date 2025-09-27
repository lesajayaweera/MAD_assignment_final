import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:my_app/Classes/apiService.dart';

class FavoriteService {
  // Get user's favorites
  static Future<List<dynamic>> getFavorites() async {
    final response = await http.get(
      Uri.parse('${ApiService.baseUrl}/favorites'),
      headers: await ApiService.getHeaders(),
    );

    final data = ApiService.handleResponse(response);
    return data['data'];
  }

  // Add to favorites
  static Future<Map<String, dynamic>> addFavorite(String vehicleUuid) async {
    final response = await http.post(
      Uri.parse('${ApiService.baseUrl}/favorites'),
      headers: await ApiService.getHeaders(),
      body: json.encode({
        'vehicle_uuid': vehicleUuid,
      }),
    );

    return ApiService.handleResponse(response);
  }

  // Remove from favorites
  static Future<void> removeFavorite(String vehicleUuid) async {
    final response = await http.delete(
      Uri.parse('${ApiService.baseUrl}/favorites/$vehicleUuid'),
      headers: await ApiService.getHeaders(),
    );

    ApiService.handleResponse(response);
  }
}