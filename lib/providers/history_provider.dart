import 'package:flutter/material.dart';
import '../models/history_model.dart';

class HistoryProvider extends ChangeNotifier {
  final List<HistoryRecord> _records = [];

  List<HistoryRecord> get records => List.unmodifiable(_records);

  void addRecord(HistoryRecord record) {
    _records.insert(0, record);
    notifyListeners();
  }

  void updateRecord(HistoryRecord updated) {
    final index = _records.indexWhere((r) => r.id == updated.id);
    if (index != -1) {
      _records[index] = updated;
      notifyListeners();
    }
  }

  void deleteRecord(String id) {
    _records.removeWhere((r) => r.id == id);
    notifyListeners();
  }

  // Replace all API-sourced records (prefixed "c_" or "l_") with a fresh list
  // fetched from the backend. Local-only records (other types) are preserved.
  void replaceApiRecords(List<HistoryRecord> apiRecords) {
    _records.removeWhere(
      (r) => r.id.startsWith('c_') || r.id.startsWith('l_'),
    );
    _records.insertAll(0, apiRecords);
    notifyListeners();
  }

  List<HistoryRecord> search(String query) {
    if (query.trim().isEmpty) return records;
    final q = query.toLowerCase();
    return _records.where((r) {
      if (r is ComplaintRecord) {
        return r.category.toLowerCase().contains(q) ||
            r.description.toLowerCase().contains(q);
      } else if (r is LeaveRecord) {
        return r.reason.toLowerCase().contains(q) ||
            r.additionalDetails.toLowerCase().contains(q);
      } else if (r is VisitorRecord) {
        return r.visitorName.toLowerCase().contains(q) ||
            r.purpose.toLowerCase().contains(q) ||
            r.relationship.toLowerCase().contains(q) ||
            r.visitorPhone.toLowerCase().contains(q);
      } else if (r is RoomChangeRecord) {
        return r.requestedRoom.toLowerCase().contains(q) ||
            r.reason.toLowerCase().contains(q) ||
            r.priority.toLowerCase().contains(q);
      }
      return false;
    }).toList();
  }

  static String generateId() =>
      DateTime.now().microsecondsSinceEpoch.toString();
}
