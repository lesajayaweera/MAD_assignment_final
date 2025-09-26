import 'package:http/http.dart' as http;
import 'package:my_app/Classes/apiService.dart';


class VehicleService {
  // Get all available vehicles
  static Future<List<dynamic>> getVehicles() async {
    final response = await http.get(
      Uri.parse('${ApiService.baseUrl}/vehicles'),
      headers: await ApiService.getHeaders(),
    );

    final data = ApiService.handleResponse(response);
    return data['data'];
  }

  // Get single vehicle details
  static Future<Map<String, dynamic>> getVehicle(String uuid) async {
    final response = await http.get(
      Uri.parse('${ApiService.baseUrl}/vehicles/$uuid'),
      headers: await ApiService.getHeaders(),
    );

    final data = ApiService.handleResponse(response);
    return data;
  }

  // Search vehicles
  static Future<List<dynamic>> searchVehicles(String query) async {
    final response = await http.get(
      Uri.parse('${ApiService.baseUrl}/vehicles?search=$query'),
      headers: await ApiService.getHeaders(),
    );

    final data = ApiService.handleResponse(response);
    return data['data'];
  }
}