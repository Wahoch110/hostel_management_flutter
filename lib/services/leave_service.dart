import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/history_model.dart';
import 'api_service.dart';

class LeaveService {
  static String get _endpoint => '${ApiService.baseUrl}/leaves';

  // Format DateTime to 'YYYY-MM-DD' for MySQL DATE columns
  static String _formatDate(DateTime d) =>
      '${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';

  // Fetch all leave requests and convert to LeaveRecord list
  static Future<List<LeaveRecord>> fetchAll() async {
    final response = await http
        .get(Uri.parse(_endpoint))
        .timeout(const Duration(seconds: 10));

    if (response.statusCode != 200) {
      throw Exception(
          'Failed to fetch leave requests (${response.statusCode})');
    }

    final List<dynamic> data = jsonDecode(response.body);
    return data
        .map((item) => LeaveRecord(
              id:                'l_${item['id']}',
              leaveDate:         DateTime.parse(item['leave_date'] as String),
              returnDate:        DateTime.parse(item['return_date'] as String),
              reason:            item['reason'] as String,
              additionalDetails: item['additional_details'] as String? ?? '',
            ))
        .toList();
  }

  // Create a new leave request and return the saved record with API-assigned id
  static Future<LeaveRecord> create(
    DateTime leaveDate,
    DateTime returnDate,
    String reason,
    String additionalDetails,
  ) async {
    final response = await http
        .post(
          Uri.parse(_endpoint),
          headers: ApiService.headers,
          body: jsonEncode({
            'leave_date':         _formatDate(leaveDate),
            'return_date':        _formatDate(returnDate),
            'reason':             reason,
            'additional_details': additionalDetails,
          }),
        )
        .timeout(const Duration(seconds: 10));

    final body = jsonDecode(response.body);
    if (response.statusCode != 201) {
      throw Exception(body['error'] ?? 'Failed to submit leave request');
    }

    return LeaveRecord(
      id:                'l_${body['id']}',
      leaveDate:         leaveDate,
      returnDate:        returnDate,
      reason:            reason,
      additionalDetails: additionalDetails,
    );
  }

  // Update an existing leave request
  static Future<void> update(
    String historyId,
    DateTime leaveDate,
    DateTime returnDate,
    String reason,
    String additionalDetails,
  ) async {
    final apiId = ApiService.parseApiId(historyId);
    if (apiId == null) throw Exception('Invalid leave ID');

    final response = await http
        .put(
          Uri.parse('$_endpoint/$apiId'),
          headers: ApiService.headers,
          body: jsonEncode({
            'leave_date':         _formatDate(leaveDate),
            'return_date':        _formatDate(returnDate),
            'reason':             reason,
            'additional_details': additionalDetails,
          }),
        )
        .timeout(const Duration(seconds: 10));

    if (response.statusCode != 200) {
      final body = jsonDecode(response.body);
      throw Exception(body['error'] ?? 'Failed to update leave request');
    }
  }

  // Delete a leave request by its API id
  static Future<void> delete(String historyId) async {
    final apiId = ApiService.parseApiId(historyId);
    if (apiId == null) throw Exception('Invalid leave ID');

    final response = await http
        .delete(Uri.parse('$_endpoint/$apiId'))
        .timeout(const Duration(seconds: 10));

    if (response.statusCode != 200) {
      throw Exception('Failed to delete leave request');
    }
  }
}
