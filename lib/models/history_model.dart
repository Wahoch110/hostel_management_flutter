import 'package:flutter/material.dart';

enum RecordType { complaint, leaveRequest, visitorRequest, roomChange }

abstract class HistoryRecord {
  final String id;
  final RecordType type;

  const HistoryRecord({required this.id, required this.type});
}

// Fields mirror complaint_screen.dart: category (radio) + description (text)
class ComplaintRecord extends HistoryRecord {
  final String category;
  final String description;

  const ComplaintRecord({
    required super.id,
    required this.category,
    required this.description,
  }) : super(type: RecordType.complaint);

  ComplaintRecord copyWith({String? category, String? description}) =>
      ComplaintRecord(
        id: id,
        category: category ?? this.category,
        description: description ?? this.description,
      );
}

// Fields mirror leave_request_screen.dart: leaveDate, returnDate, reason, additionalDetails
class LeaveRecord extends HistoryRecord {
  final DateTime leaveDate;
  final DateTime returnDate;
  final String reason;
  final String additionalDetails;

  LeaveRecord({
    required super.id,
    required this.leaveDate,
    required this.returnDate,
    required this.reason,
    required this.additionalDetails,
  }) : super(type: RecordType.leaveRequest);

  LeaveRecord copyWith({
    DateTime? leaveDate,
    DateTime? returnDate,
    String? reason,
    String? additionalDetails,
  }) =>
      LeaveRecord(
        id: id,
        leaveDate: leaveDate ?? this.leaveDate,
        returnDate: returnDate ?? this.returnDate,
        reason: reason ?? this.reason,
        additionalDetails: additionalDetails ?? this.additionalDetails,
      );
}

// Fields mirror visitor_request_screen.dart: visitorName, visitorPhone, purpose,
// relationship, visitDate, visitTime
class VisitorRecord extends HistoryRecord {
  final String visitorName;
  final String visitorPhone;
  final String purpose;
  final String relationship;
  final DateTime visitDate;
  final TimeOfDay visitTime;

  VisitorRecord({
    required super.id,
    required this.visitorName,
    required this.visitorPhone,
    required this.purpose,
    required this.relationship,
    required this.visitDate,
    required this.visitTime,
  }) : super(type: RecordType.visitorRequest);

  VisitorRecord copyWith({
    String? visitorName,
    String? visitorPhone,
    String? purpose,
    String? relationship,
    DateTime? visitDate,
    TimeOfDay? visitTime,
  }) =>
      VisitorRecord(
        id: id,
        visitorName: visitorName ?? this.visitorName,
        visitorPhone: visitorPhone ?? this.visitorPhone,
        purpose: purpose ?? this.purpose,
        relationship: relationship ?? this.relationship,
        visitDate: visitDate ?? this.visitDate,
        visitTime: visitTime ?? this.visitTime,
      );
}

// Fields mirror room_change_screen.dart: currentRoom, requestedRoom, reason, priority
class RoomChangeRecord extends HistoryRecord {
  final String currentRoom;
  final String requestedRoom;
  final String reason;
  final String priority;

  const RoomChangeRecord({
    required super.id,
    required this.currentRoom,
    required this.requestedRoom,
    required this.reason,
    required this.priority,
  }) : super(type: RecordType.roomChange);

  RoomChangeRecord copyWith({
    String? currentRoom,
    String? requestedRoom,
    String? reason,
    String? priority,
  }) =>
      RoomChangeRecord(
        id: id,
        currentRoom: currentRoom ?? this.currentRoom,
        requestedRoom: requestedRoom ?? this.requestedRoom,
        reason: reason ?? this.reason,
        priority: priority ?? this.priority,
      );
}
