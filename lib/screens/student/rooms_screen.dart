import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/room_provider.dart';
import '../../models/room_model.dart';
import '../../routes/app_routes.dart';

class RoomsScreen extends StatefulWidget {
  const RoomsScreen({super.key});

  @override
  State<RoomsScreen> createState() => _RoomsScreenState();
}

class _RoomsScreenState extends State<RoomsScreen> {
  // Filter state — 'All', 'Available', 'Full'
  String _filter = 'All';

  // Online images per room type — Unsplash free images
  static const Map<String, String> _roomImages = {
    'Single': 'https://images.unsplash.com/photo-1555854877-bab0e564b8d5?w=500&q=70',
    'Double': 'https://images.unsplash.com/photo-1631049307264-da0ec9d70304?w=500&q=70',
    'Triple': 'https://images.unsplash.com/photo-1540518614846-7eded433c457?w=500&q=70',
    'Quad':   'https://images.unsplash.com/photo-1522771739844-6a9f6d5f14af?w=500&q=70',
  };

  @override
  Widget build(BuildContext context) {
    final allRooms = context.watch<RoomProvider>().rooms;

    final rooms = _filter == 'All'
        ? allRooms
        : allRooms.where((r) => r.status == _filter).toList();

    return Scaffold(
      backgroundColor: const Color(0xFFF5F4FF),
      appBar: AppBar(
        title:                    const Text('Hostel Rooms'),
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          Container(
            color:   Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Row(
              children: ['All', 'Available', 'Full'].map((f) {
                final bool sel = _filter == f;
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: GestureDetector(
                    onTap: () => setState(() => _filter = f),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
                      decoration: BoxDecoration(
                        color:        sel ? const Color(0xFF4F46E5) : const Color(0xFFF3F4F6),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(f,
                          style: TextStyle(
                              fontSize:   13,
                              fontWeight: FontWeight.w600,
                              color:      sel ? Colors.white : const Color(0xFF6B7280))),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),


          Expanded(
            child: rooms.isEmpty
                ? const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.bed_outlined, size: 60, color: Color(0xFFD1D5DB)),
                        SizedBox(height: 10),
                        Text('No rooms found.', style: TextStyle(color: Color(0xFF9CA3AF))),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding:    const EdgeInsets.all(16),
                    itemCount:  rooms.length,
                    physics:    const BouncingScrollPhysics(),
                    itemBuilder: (context, i) {
                      final room   = rooms[i];
                      final imgUrl = _roomImages[room.type] ?? _roomImages['Double']!;
                      return _RoomCard(room: room, imageUrl: imgUrl);
                    },
                  ),
          ),
        ],
      ),
    );
  }
}


class _RoomCard extends StatelessWidget {
  final RoomModel room;
  final String    imageUrl;
  const _RoomCard({required this.room, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    final bool isAvailable = room.status == 'Available';

    return GestureDetector(
      onTap: () => Navigator.pushNamed(
        context, AppRoutes.roomDetail,
        arguments: room, 
      ),
      child: Container(
        margin:      const EdgeInsets.only(bottom: 16),
        decoration:  BoxDecoration(
          color:        Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 8, offset: const Offset(0, 2))],
        ),
        child: Column(
          children: [
            // Room image with status badge overlay
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(16), topRight: Radius.circular(16)),
//image loading with spinner and error handling
                  child: Image.network(
                    imageUrl,
                    height: 150, width: double.infinity, fit: BoxFit.cover,
                    // Shows spinner while loading
                    loadingBuilder: (_, child, progress) {
                      if (progress == null) return child;
                      return Container(
                        height: 150, color: const Color(0xFFE0E7FF),
                        child: const Center(
                            child: CircularProgressIndicator(
                                color: Color(0xFF4F46E5), strokeWidth: 2)),
                      );
                    },
                    // Shows icon if image fails to load
                    errorBuilder: (_, __, ___) => Container(
                      height: 150, color: const Color(0xFFE0E7FF),
                      child: const Icon(Icons.bed_rounded, size: 50, color: Color(0xFF4F46E5)),
                    ),
                  ),
                ),
                // Status badge positioned on image
                Positioned(
                  top: 10, right: 10,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color:        isAvailable ? Colors.green : Colors.red,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(room.status,
                        style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            ),

            Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Room ${room.roomNumber}',
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                      Text(
                        'Rs. ${room.monthlyFee.toStringAsFixed(0)}/mo',
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Color(0xFF4F46E5)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text('${room.type}  •  Block ${room.block}  •  ${room.floor}',
                      style: const TextStyle(fontSize: 12, color: Color(0xFF6B7280))),
                  const SizedBox(height: 8),

                  Wrap(
                    spacing: 5, runSpacing: 4,
                    children: room.facilities.map((f) => Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                          color: const Color(0xFFF3F4F6), borderRadius: BorderRadius.circular(20)),
                      child: Text(f, style: const TextStyle(fontSize: 10, color: Color(0xFF6B7280))),
                    )).toList(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}