import 'package:flutter/material.dart';
import '../../models/room_model.dart';

class RoomDetailScreen extends StatelessWidget {
  const RoomDetailScreen({super.key});

  static const Map<String, String> _roomImages = {
    'Single': 'https://images.unsplash.com/photo-1555854877-bab0e564b8d5?w=600&q=70',
    'Double': 'https://images.unsplash.com/photo-1631049307264-da0ec9d70304?w=600&q=70',
    'Triple': 'https://images.unsplash.com/photo-1540518614846-7eded433c457?w=600&q=70',
    'Quad':   'https://images.unsplash.com/photo-1522771739844-6a9f6d5f14af?w=600&q=70',
  };

  @override
  Widget build(BuildContext context) {
    final room    = ModalRoute.of(context)!.settings.arguments as RoomModel;
    final isAvail = room.status == 'Available';
    final imgUrl  = _roomImages[room.type] ?? _roomImages['Double']!;

    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [

          SliverAppBar(
            expandedHeight:  240,
            pinned:          true,
            backgroundColor: const Color(0xFF4F46E5),
            foregroundColor: Colors.white,
            flexibleSpace:   FlexibleSpaceBar(
              title: Text('Room ${room.roomNumber}',
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(imgUrl, fit: BoxFit.cover,
                    loadingBuilder: (_, child, prog) {
                      if (prog == null) return child;
                      return Container(color: const Color(0xFF4F46E5),
                          child: const Center(child: CircularProgressIndicator(color: Colors.white)));
                    },
                    errorBuilder: (_, __, ___) => Container(
                        color: const Color(0xFF4F46E5),
                        child: const Icon(Icons.bed_rounded, size: 80, color: Colors.white38)),
                  ),

                  const DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter, end: Alignment.bottomCenter,
                        colors: [Colors.transparent, Colors.black54],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Row(
                    children: [
                      _Chip(label: room.status, color: isAvail ? Colors.green : Colors.red),
                      const SizedBox(width: 8),
                      _Chip(label: room.type, color: const Color(0xFF4F46E5)),
                      const Spacer(),
                      Text('Rs. ${room.monthlyFee.toStringAsFixed(0)}/mo',
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16, color: Color(0xFF4F46E5))),
                    ],
                  ),

                  const SizedBox(height: 20),

                  _DetailCard(title: 'Room Details', children: [
                    _DetailRow(icon: Icons.tag_outlined,      label: 'Room Number', value: room.roomNumber),
                    _DetailRow(icon: Icons.category_outlined, label: 'Type',        value: room.type),
                    _DetailRow(icon: Icons.people_outline,    label: 'Capacity',    value: '${room.capacity} Students'),
                    _DetailRow(icon: Icons.location_on_outlined, label: 'Block',    value: 'Block ${room.block}'),
                    _DetailRow(icon: Icons.layers_outlined,   label: 'Floor',       value: room.floor),
                  ]),

                  const SizedBox(height: 14),

                  // Facilities card
                  _DetailCard(title: 'Facilities Included', children: [
                    Wrap(
                      spacing: 8, runSpacing: 8,
                      children: room.facilities.map((f) => Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color:        const Color(0xFF4F46E5).withOpacity(0.08),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: const Color(0xFF4F46E5).withOpacity(0.3)),
                        ),
                        child: Row(mainAxisSize: MainAxisSize.min, children: [
                          const Icon(Icons.check_circle_outline, size: 13, color: Color(0xFF4F46E5)),
                          const SizedBox(width: 4),
                          Text(f, style: const TextStyle(
                              fontSize: 12, color: Color(0xFF4F46E5), fontWeight: FontWeight.w500)),
                        ]),
                      )).toList(),
                    ),
                  ]),

                  const SizedBox(height: 24),

                  SizedBox(
                    width: double.infinity, height: 52,
                    child: isAvail
                        ? ElevatedButton.icon(
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('✅ Room ${room.roomNumber} booking request submitted!'),
                                  backgroundColor: Colors.green,
                                ),
                              );
                              Navigator.pop(context);
                            },
                            icon:  const Icon(Icons.bed_rounded),
                            label: const Text('Request This Room'),
                          )
                        : OutlinedButton.icon(
                            onPressed: null,
                            icon:  const Icon(Icons.block, color: Colors.red),
                            label: const Text('Room is Full',
                                style: TextStyle(color: Colors.red)),
                            style: OutlinedButton.styleFrom(
                              side:  const BorderSide(color: Colors.red),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            ),
                          ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Chip extends StatelessWidget {
  final String label; final Color color;
  const _Chip({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      decoration: BoxDecoration(
        color:        color.withOpacity(0.10),
        borderRadius: BorderRadius.circular(20),
        border:       Border.all(color: color.withOpacity(0.4)),
      ),
      child: Text(label,
          style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 12)),
    );
  }
}

class _DetailCard extends StatelessWidget {
  final String title; final List<Widget> children;
  const _DetailCard({required this.title, required this.children});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity, padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white, borderRadius: BorderRadius.circular(14),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 6)],
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Color(0xFF4F46E5))),
        const SizedBox(height: 12),
        const Divider(height: 1, color: Color(0xFFE5E7EB)),
        const SizedBox(height: 12),
        ...children,
      ]),
    );
  }
}

class _DetailRow extends StatelessWidget {
  final IconData icon; final String label, value;
  const _DetailRow({required this.icon, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(children: [
        Icon(icon, size: 18, color: const Color(0xFF9CA3AF)),
        const SizedBox(width: 10),
        Text('$label:  ', style: const TextStyle(fontSize: 13, color: Color(0xFF6B7280))),
        Expanded(
          child: Text(value,
              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Color(0xFF1F1F2E))),
        ),
      ]),
    );
  }
}