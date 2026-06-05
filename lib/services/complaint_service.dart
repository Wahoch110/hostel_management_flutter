import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/history_model.dart';
import 'api_service.dart';

class ComplaintService {
  static String get _endpoint => '${ApiService.baseUrl}/complaints';

  // Fetch all complaints from the backend and convert to ComplaintRecord list
  static Future<List<ComplaintRecord>> fetchAll() async {
    final response = await http
        .get(Uri.parse(_endpoint))
        .timeout(const Duration(seconds: 10));

    if (response.statusCode != 200) {
      throw Exception('Failed to fetch complaints (${response.statusCode})');
    }

    final List<dynamic> data = jsonDecode(response.body);
    return data
        .map((item) => ComplaintRecord(
              id:          'c_${item['id']}',
              category:    item['category'] as String,
              description: item['description'] as String,
            ))
        .toList();
  }

  // Create a new complaint and return the saved record with API-assigned id
  static Future<ComplaintRecord> create(
      String category, String description) async {
    final response = await http
        .post(
          Uri.parse(_endpoint),
          headers: ApiService.headers,
          body: jsonEncode({'category': category, 'description': description}),
        )
        .timeout(const Duration(seconds: 10));

    final body = jsonDecode(response.body);
    if (response.statusCode != 201) {
      throw Exception(body['error'] ?? 'Failed to submit complaint');
    }

    return ComplaintRecord(
      id:          'c_${body['id']}',
      category:    body['category'] as String,
      description: body['description'] as String,
    );
  }

  // Update an existing complaint using its API id (extracted from historyId)
  static Future<void> update(
      String historyId, String category, String description) async {
    final apiId = ApiService.parseApiId(historyId);
    if (apiId == null) throw Exception('Invalid complaint ID');

    final response = await http
        .put(
          Uri.parse('$_endpoint/$apiId'),
          headers: ApiService.headers,
          body: jsonEncode({'category': category, 'description': description}),
        )
        .timeout(const Duration(seconds: 10));

    if (response.statusCode != 200) {
      final body = jsonDecode(response.body);
      throw Exception(body['error'] ?? 'Failed to update complaint');
    }
  }

  // Delete a complaint by its API id
  static Future<void> delete(String historyId) async {
    final apiId = ApiService.parseApiId(historyId);
    if (apiId == null) throw Exception('Invalid complaint ID');

    final response = await http
        .delete(Uri.parse('$_endpoint/$apiId'))
        .timeout(const Duration(seconds: 10));

    if (response.statusCode != 200) {
      throw Exception('Failed to delete complaint');
    }
  }
}
