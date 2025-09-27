import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:my_app/Classes/apiService.dart';

class OrderService {
  // Get user's orders
  static Future<Map<String, dynamic>> getOrders() async {
    final response = await http.get(
      Uri.parse('${ApiService.baseUrl}/orders'),
      headers: await ApiService.getHeaders(),
    );

    return ApiService.handleResponse(response);
  }

  // Create new order
  static Future<Map<String, dynamic>> createOrder(String vehicleUuid) async {
    final response = await http.post(
      Uri.parse('${ApiService.baseUrl}/orders'),
      headers: await ApiService.getHeaders(),
      body: json.encode({
        'vehicle_uuid': vehicleUuid,
      }),
    );

    return ApiService.handleResponse(response);
  }

  // Cancel order
  static Future<void> cancelOrder(String orderId) async {
    final response = await http.delete(
      Uri.parse('${ApiService.baseUrl}/orders/$orderId'),
      headers: await ApiService.getHeaders(),
    );

    ApiService.handleResponse(response);
  }

  // Checkout
  static Future<Map<String, dynamic>> checkout(Map<String, dynamic> billingInfo) async {
    final response = await http.post(
      Uri.parse('${ApiService.baseUrl}/checkout'),
      headers: await ApiService.getHeaders(),
      body: json.encode(billingInfo),
    );

    return ApiService.handleResponse(response);
  }
}