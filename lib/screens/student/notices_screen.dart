import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/notice_provider.dart';

class NoticesScreen extends StatelessWidget {
  const NoticesScreen({super.key});

  Color _categoryColor(String cat) {
    switch (cat) {
      case 'Urgent': return const Color(0xFFEF4444);
      case 'Event':  return const Color(0xFF10B981);
      default:       return const Color(0xFF4F46E5);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F4FF),
      appBar: AppBar(
        title:                    const Text('Notice Board'),
        automaticallyImplyLeading: false,
      ),
      body: Consumer<NoticeProvider>(
        builder: (context, np, _) {
          final notices = np.notices;

          return ListView(
            padding: const EdgeInsets.all(16),
            physics: const BouncingScrollPhysics(),
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(14),
                child: Image.network(
                  'https://images.unsplash.com/photo-1606326608606-aa0b62935f2b?w=700&q=70',
                  height: 130, width: double.infinity, fit: BoxFit.cover,
                  loadingBuilder: (_, child, prog) {
                    if (prog == null) return child;
                    return Container(
                      height: 130, color: const Color(0xFFE0E7FF),
                      child: const Center(
                          child: CircularProgressIndicator(color: Color(0xFF4F46E5))),
                    );
                  },
                  errorBuilder: (_, __, ___) => Container(
                    height: 130,
                    decoration: BoxDecoration(
                        color: const Color(0xFFEEF2FF),
                        borderRadius: BorderRadius.circular(14)),
                    child: const Center(
                        child: Icon(Icons.campaign_rounded, size: 60, color: Color(0xFF4F46E5))),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Notice cards
              ...notices.map((n) {
                final color = _categoryColor(n.category);
                return Container(
                  margin:  const EdgeInsets.only(bottom: 14),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color:        Colors.white,
                    borderRadius: BorderRadius.circular(14),
                    boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 6)],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title row with icon + category badge
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(7),
                            decoration: BoxDecoration(
                                color: color.withOpacity(0.10), shape: BoxShape.circle),
                            child: Icon(Icons.campaign_rounded, color: color, size: 18),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(n.title,
                                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                            decoration: BoxDecoration(
                                color:        color.withOpacity(0.10),
                                borderRadius: BorderRadius.circular(20)),
                            child: Text(n.category,
                                style: TextStyle(
                                    color: color, fontSize: 10, fontWeight: FontWeight.bold)),
                          ),
                        ],
                      ),

                      const SizedBox(height: 10),
                      const Divider(height: 1, color: Color(0xFFE5E7EB)),
                      const SizedBox(height: 10),

                      // Body text
                      Text(n.body,
                          style: const TextStyle(
                              fontSize: 13, color: Color(0xFF4B5563), height: 1.6)),

                      const SizedBox(height: 10),

                      // Footer: postedBy + date
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(children: [
                            const Icon(Icons.person_outline, size: 13, color: Color(0xFF9CA3AF)),
                            const SizedBox(width: 4),
                            Text(n.postedBy,
                                style: const TextStyle(fontSize: 11, color: Color(0xFF9CA3AF))),
                          ]),
                          Row(children: [
                            const Icon(Icons.calendar_today_outlined,
                                size: 11, color: Color(0xFF9CA3AF)),
                            const SizedBox(width: 4),
                            Text(n.date,
                                style: const TextStyle(fontSize: 11, color: Color(0xFF9CA3AF))),
                          ]),
                        ],
                      ),
                    ],
                  ),
                );
              }),
            ],
          );
        },
      ),
    );
  }
}