import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/room_provider.dart';
import '../../routes/app_routes.dart';

class BookRoomScreen extends StatefulWidget {
  const BookRoomScreen({super.key});

  @override
  State<BookRoomScreen> createState() => _BookRoomScreenState();
}

class _BookRoomScreenState extends State<BookRoomScreen> {
  
  // KEY CONCEPT: Switch state — shows available rooms only when true
  bool _availableOnly = true;

  @override
  Widget build(BuildContext context) {
    final allRooms = context.watch<RoomProvider>().rooms;
    final rooms    = _availableOnly
        ? allRooms.where((r) => r.status == 'Available').toList()
        : allRooms;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F4FF),
      appBar: AppBar(title: const Text('Book a Room')),
      body: Column(
        children: [
       
       //filter switch
          Container(
            color:   Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Show available rooms only',
                    style: TextStyle(
                        fontSize: 14, fontWeight: FontWeight.w500, color: Color(0xFF374151))),
                Switch(
                  value:       _availableOnly,
                  activeColor: const Color(0xFF4F46E5),
                  onChanged:   (v) => setState(() => _availableOnly = v),
                ),
              ],
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
                        Text('No available rooms right now.',
                            style: TextStyle(color: Color(0xFF9CA3AF))),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: rooms.length,
                    physics:   const BouncingScrollPhysics(),
                    itemBuilder: (context, i) {
                      final room    = rooms[i];
                      final isAvail = room.status == 'Available';
                      return GestureDetector(
                        onTap: () => Navigator.pushNamed(
                            context, AppRoutes.roomDetail, arguments: room),
                        child: Container(
                          margin:   const EdgeInsets.only(bottom: 12),
                          padding:  const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white, borderRadius: BorderRadius.circular(14),
                            boxShadow: [BoxShadow(
                                color: Colors.black.withOpacity(0.04), blurRadius: 6)],
                          ),
                          child: Row(children: [
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: isAvail
                                    ? const Color(0xFF4F46E5).withOpacity(0.10)
                                    : Colors.grey.withOpacity(0.10),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Icon(Icons.bed_rounded,
                                  color: isAvail ? const Color(0xFF4F46E5) : Colors.grey, size: 26),
                            ),
                            const SizedBox(width: 14),
                            Expanded(
                              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                Text('Room ${room.roomNumber}',
                                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                                Text(
                                  '${room.type} • ${room.capacity} persons • Rs.${room.monthlyFee.toStringAsFixed(0)}/mo',
                                  style: const TextStyle(fontSize: 12, color: Color(0xFF6B7280)),
                                ),
                              ]),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                color: isAvail
                                    ? Colors.green.withOpacity(0.10)
                                    : Colors.red.withOpacity(0.10),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(room.status,
                                  style: TextStyle(
                                      fontSize: 11, fontWeight: FontWeight.bold,
                                      color: isAvail ? Colors.green : Colors.red)),
                            ),
                          ]),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}