import 'dart:convert';
import 'package:http/http.dart' as http;

class EHttpHelper {
  static const String _baseUrl = 'http://192.168.1.41:5000';

  static Future<Map<String, dynamic>> get(String endpoint,
      {Map<String, dynamic>? queryParams}) async {
    Uri uri = Uri.parse('$_baseUrl/$endpoint');

    if (queryParams != null && queryParams.isNotEmpty) {
      uri = uri.replace(queryParameters: queryParams);
    }

    final response = await http.get(uri);
    return _handleResponse(response);
  }

  // Helper method to make a POST request
  static Future<Map<String, dynamic>> post(
      String endpoint, dynamic data) async {
    final response = await http.post(Uri.parse('$_baseUrl/$endpoint'),
        headers: {'Contene-Type': 'application/json'}, body: json.encode(data));
    return _handleResponse(response);
  }

  // Helper method to make a PUT request
  static Future<Map<String, dynamic>> put(String endpoint, dynamic data) async {
    final response = await http.put(Uri.parse('$_baseUrl/$endpoint'),
        headers: {'Content-Type': 'application/json'}, body: json.encode(data));
    return _handleResponse(response);
  }

  // Helper method to make a DELETE request
  static Future<Map<String, dynamic>> delete(String endpoint) async {
    final response = await http.delete(Uri.parse('$_baseUrl/$endpoint'));
    return _handleResponse(response);
  }

  static Map<String, dynamic> _handleResponse(http.Response response) {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return json.decode(response.body);
    } else {
      printHttpError(response);
      throw Exception('Failed to load data: ${response.statusCode}');
    }
  }

  static String printHttpError(http.Response response) {
    return 'HTTP Error: ${response.statusCode} - ${response.reasonPhrase}';
  }
}
