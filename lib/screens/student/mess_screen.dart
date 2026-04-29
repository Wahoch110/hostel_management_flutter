import 'package:flutter/material.dart';
import '../../models/mess_model.dart';

class MessScreen extends StatelessWidget {
  const MessScreen({super.key});

  static const List<MessMenuModel> _menu = [
    MessMenuModel(
      day: 'Monday', breakfast: 'Paratha, Fried Egg, Chai',
      lunch: 'Daal Chawal, Salad', dinner: 'Biryani, Raita, Salad',
      breakfastImage: 'https://images.unsplash.com/photo-1533089860892-a7c6f0a88666?w=300&q=70',
      lunchImage:     'https://images.unsplash.com/photo-1512058564366-18510be2db19?w=300&q=70',
      dinnerImage:    'https://images.unsplash.com/photo-1574484284002-952d92456975?w=300&q=70',
    ),
    MessMenuModel(
      day: 'Tuesday', breakfast: 'Bread, Butter, Jam, Chai',
      lunch: 'Chicken Karahi, Naan', dinner: 'Daal, Rice, Roti',
      breakfastImage: 'https://images.unsplash.com/photo-1533089860892-a7c6f0a88666?w=300&q=70',
      lunchImage:     'https://images.unsplash.com/photo-1512058564366-18510be2db19?w=300&q=70',
      dinnerImage:    'https://images.unsplash.com/photo-1574484284002-952d92456975?w=300&q=70',
    ),
    MessMenuModel(
      day: 'Wednesday', breakfast: 'Puri, Chana Masala, Chai',
      lunch: 'Qeema Matar, Roti, Raita', dinner: 'Palak Gosht, Rice',
      breakfastImage: 'https://images.unsplash.com/photo-1533089860892-a7c6f0a88666?w=300&q=70',
      lunchImage:     'https://images.unsplash.com/photo-1512058564366-18510be2db19?w=300&q=70',
      dinnerImage:    'https://images.unsplash.com/photo-1574484284002-952d92456975?w=300&q=70',
    ),
    MessMenuModel(
      day: 'Thursday', breakfast: 'Omelette, Paratha, Chai',
      lunch: 'Daal Mash, Roti, Salad', dinner: 'Chicken Handi, Naan',
      breakfastImage: 'https://images.unsplash.com/photo-1533089860892-a7c6f0a88666?w=300&q=70',
      lunchImage:     'https://images.unsplash.com/photo-1512058564366-18510be2db19?w=300&q=70',
      dinnerImage:    'https://images.unsplash.com/photo-1574484284002-952d92456975?w=300&q=70',
    ),
    MessMenuModel(
      day: 'Friday', breakfast: 'Halwa Puri, Chai',
      lunch: 'Pulao, Raita, Salad', dinner: 'BBQ Mix, Naan, Chutney',
      breakfastImage: 'https://images.unsplash.com/photo-1533089860892-a7c6f0a88666?w=300&q=70',
      lunchImage:     'https://images.unsplash.com/photo-1512058564366-18510be2db19?w=300&q=70',
      dinnerImage:    'https://images.unsplash.com/photo-1574484284002-952d92456975?w=300&q=70',
    ),
    MessMenuModel(
      day: 'Saturday', breakfast: 'Puri, Aloo Paratha, Tea',
      lunch: 'Mix Sabzi, Roti', dinner: 'Mutton Karahi, Rice',
      breakfastImage: 'https://images.unsplash.com/photo-1533089860892-a7c6f0a88666?w=300&q=70',
      lunchImage:     'https://images.unsplash.com/photo-1512058564366-18510be2db19?w=300&q=70',
      dinnerImage:    'https://images.unsplash.com/photo-1574484284002-952d92456975?w=300&q=70',
    ),
    MessMenuModel(
      day: 'Sunday', breakfast: 'Nihari, Naan',
      lunch: 'Special Pasta, Salad', dinner: 'Chicken Biryani, Raita',
      breakfastImage: 'https://images.unsplash.com/photo-1533089860892-a7c6f0a88666?w=300&q=70',
      lunchImage:     'https://images.unsplash.com/photo-1512058564366-18510be2db19?w=300&q=70',
      dinnerImage:    'https://images.unsplash.com/photo-1574484284002-952d92456975?w=300&q=70',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F4FF),
      appBar: AppBar(title: const Text('Mess Menu'), automaticallyImplyLeading: false),
      body: ListView(
        padding: const EdgeInsets.all(16),
        physics: const BouncingScrollPhysics(),
        children: [
      
          ClipRRect(
            borderRadius: BorderRadius.circular(14),
            child: Image.network(
              'https://images.unsplash.com/photo-1567521464027-f127ff144326?w=700&q=70',
              height: 150, width: double.infinity, fit: BoxFit.cover,
              loadingBuilder: (_, child, prog) {
                if (prog == null) return child;
                return Container(height: 150, color: const Color(0xFFE0E7FF),
                    child: const Center(
                        child: CircularProgressIndicator(color: Color(0xFF4F46E5))));
              },
              errorBuilder: (_, __, ___) => Container(
                height: 150, color: const Color(0xFFE0E7FF),
                child: const Icon(Icons.restaurant_rounded, size: 50, color: Color(0xFF4F46E5)),
              ),
            ),
          ),

          const SizedBox(height: 12),

          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color:        const Color(0xFFFEF3C7),
              borderRadius: BorderRadius.circular(10),
              border:       Border.all(color: const Color(0xFFF59E0B)),
            ),
            child: const Row(
              children: [
                Icon(Icons.info_outline, color: Color(0xFFF59E0B), size: 16),
                SizedBox(width: 8),
                Expanded(
                  child: Text('Menu may vary on public holidays and special events.',
                      style: TextStyle(fontSize: 12, color: Color(0xFF92400E))),
                ),
              ],
            ),
          ),

          const SizedBox(height: 14),

  
          ..._menu.map((m) => _DayCard(menu: m)),
        ],
      ),
    );
  }
}

class _DayCard extends StatefulWidget {
  final MessMenuModel menu;
  const _DayCard({required this.menu});

  @override
  State<_DayCard> createState() => _DayCardState();
}

class _DayCardState extends State<_DayCard> {
  // setState for expand/collapse toggle
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin:      const EdgeInsets.only(bottom: 12),
      decoration:  BoxDecoration(
        color:        Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 6)],
      ),
      child: Column(
        children: [
          GestureDetector(
            onTap: () => setState(() => _expanded = !_expanded),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
              decoration: BoxDecoration(
                color:        const Color(0xFF4F46E5),
                borderRadius: _expanded
                    ? const BorderRadius.only(
                        topLeft: Radius.circular(14), topRight: Radius.circular(14))
                    : BorderRadius.circular(14),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(widget.menu.day,
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14)),
                  Icon(
                    _expanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          ),

          // Meal rows (only shown when expanded)
          if (_expanded) ...[
            _MealTile(
              icon: Icons.wb_sunny_outlined, label: 'Breakfast',
              items: widget.menu.breakfast, imageUrl: widget.menu.breakfastImage,
              color: const Color(0xFFF59E0B),
            ),
            const Divider(height: 1, indent: 14, endIndent: 14),
            _MealTile(
              icon: Icons.restaurant_outlined, label: 'Lunch',
              items: widget.menu.lunch, imageUrl: widget.menu.lunchImage,
              color: const Color(0xFF10B981),
            ),
            const Divider(height: 1, indent: 14, endIndent: 14),
            _MealTile(
              icon: Icons.nightlight_outlined, label: 'Dinner',
              items: widget.menu.dinner, imageUrl: widget.menu.dinnerImage,
              color: const Color(0xFF4F46E5),
            ),
            const SizedBox(height: 4),
          ],
        ],
      ),
    );
  }
}

class _MealTile extends StatelessWidget {
  final IconData icon; final String label, items, imageUrl; final Color color;
  const _MealTile(
      {required this.icon, required this.label, required this.items,
       required this.imageUrl, required this.color});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(14),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              imageUrl, width: 56, height: 56, fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                width: 56, height: 56,
                color: color.withOpacity(0.10),
                child: Icon(icon, color: color, size: 24),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(children: [
                  Icon(icon, size: 13, color: color),
                  const SizedBox(width: 4),
                  Text(label,
                      style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12, color: color)),
                ]),
                const SizedBox(height: 4),
                Text(items, style: const TextStyle(fontSize: 12, color: Color(0xFF6B7280))),
              ],
            ),
          ),
        ],
      ),
    );
  }
}