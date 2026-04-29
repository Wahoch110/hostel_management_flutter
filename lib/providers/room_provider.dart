import 'package:flutter/material.dart';
import '../models/room_model.dart';

class RoomProvider extends ChangeNotifier {
  final List<RoomModel> _rooms = const [
    RoomModel(
      roomNumber: 'A-101', capacity: 2, type: 'Double',
      status: 'Available', block: 'A', floor: '1st Floor',
      facilities: ['WiFi', 'AC', 'Attached Bath'], monthlyFee: 8500,
    ),
    RoomModel(
      roomNumber: 'A-102', capacity: 3, type: 'Triple',
      status: 'Full', block: 'A', floor: '1st Floor',
      facilities: ['WiFi', 'Fan', 'Common Bath'], monthlyFee: 6500,
    ),
    RoomModel(
      roomNumber: 'B-201', capacity: 2, type: 'Double',
      status: 'Available', block: 'B', floor: '2nd Floor',
      facilities: ['WiFi', 'AC', 'Study Table', 'Wardrobe'], monthlyFee: 9000,
    ),
    RoomModel(
      roomNumber: 'B-204', capacity: 2, type: 'Double',
      status: 'Full', block: 'B', floor: '2nd Floor',
      facilities: ['WiFi', 'AC', 'Attached Bath', 'Balcony'], monthlyFee: 9500,
    ),
    RoomModel(
      roomNumber: 'C-301', capacity: 4, type: 'Quad',
      status: 'Available', block: 'C', floor: '3rd Floor',
      facilities: ['WiFi', 'Fan', 'Common Bath'], monthlyFee: 5000,
    ),
    RoomModel(
      roomNumber: 'C-302', capacity: 1, type: 'Single',
      status: 'Available', block: 'C', floor: '3rd Floor',
      facilities: ['WiFi', 'AC', 'Attached Bath', 'Refrigerator'], monthlyFee: 12000,
    ),
  ];

  List<RoomModel> get rooms => _rooms;
  List<RoomModel> get availableRooms =>
      _rooms.where((r) => r.status == 'Available').toList();
}