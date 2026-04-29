import 'package:flutter/material.dart';
import '../../routes/app_routes.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  void _showAdminComingSoon(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        contentPadding: const EdgeInsets.all(28),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: const Color(0xFF0EA5E9).withOpacity(0.10),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.construction_rounded,
                size:  48,
                color: Color(0xFF0EA5E9),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Admin Panel',
              style: TextStyle(
                fontSize:   20,
                fontWeight: FontWeight.bold,
                color:      Color(0xFF1F1F2E),
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Coming Soon!',
              style: TextStyle(
                fontSize:   16,
                fontWeight: FontWeight.w600,
                color:      Color(0xFF0EA5E9),
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              'The Admin Panel is currently under development. '
              'It will be available in the next update. '
              'Thank you for your patience!',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 13,
                color:    Color(0xFF6B7280),
                height:   1.5,
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width:  double.infinity,
              height: 46,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(ctx),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0EA5E9),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text(
                  'Got it!',
                  style: TextStyle(
                    fontSize:   15,
                    fontWeight: FontWeight.bold,
                    color:      Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F4FF),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28),
          child: Column(
            children: [
              const SizedBox(height: 50),

              Container(
                padding: const EdgeInsets.all(22),
                decoration: BoxDecoration(
                  color: const Color(0xFF4F46E5).withOpacity(0.10),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.home_work_rounded,
                  size:  64,
                  color: Color(0xFF4F46E5),
                ),
              ),

              const SizedBox(height: 20),

              const Text(
                'HostelHub',
                style: TextStyle(
                  fontSize:      30,
                  fontWeight:    FontWeight.bold,
                  color:         Color(0xFF1F1F2E),
                  letterSpacing: 1,
                ),
              ),

              const SizedBox(height: 6),

              const Text(
                'Your hostel, managed smartly.',
                style: TextStyle(fontSize: 15, color: Color(0xFF6B7280)),
              ),

              const SizedBox(height: 50),

              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Continue as',
                  style: TextStyle(
                    fontSize:   16,
                    fontWeight: FontWeight.w600,
                    color:      Color(0xFF374151),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // STUDENT — goes to login
              _RoleCard(
                icon:     Icons.school_rounded,
                title:    'Student',
                subtitle: 'Access your hostel portal',
                color:    const Color(0xFF4F46E5),
                onTap:    () => Navigator.pushNamed(context, AppRoutes.login),
              ),

              const SizedBox(height: 14),

              _RoleCard(
                icon:     Icons.admin_panel_settings_rounded,
                title:    'Admin',
                subtitle: 'Manage hostel operations',
                color:    const Color(0xFF0EA5E9),
                onTap:    () => _showAdminComingSoon(context),
              ),

              const Spacer(),

              const Text(
                'University Hostel Management System build by Raza',
                style: TextStyle(fontSize: 12, color: Color(0xFF9CA3AF)),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

class _RoleCard extends StatelessWidget {
  final IconData     icon;
  final String       title;
  final String       subtitle;
  final Color        color;
  final VoidCallback onTap;

  const _RoleCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width:   double.infinity,
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color:        Colors.white,
          borderRadius: BorderRadius.circular(16),
          border:       Border.all(color: color.withOpacity(0.3)),
          boxShadow: [
            BoxShadow(
              color:      color.withOpacity(0.08),
              blurRadius: 12,
              offset:     const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color:        color.withOpacity(0.10),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: color, size: 28),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize:   17,
                      fontWeight: FontWeight.bold,
                      color:      color,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 13,
                      color:    Color(0xFF6B7280),
                    ),
                  ),
                ],
              ),
            ),
            Icon(Icons.arrow_forward_ios, size: 16, color: color),
          ],
        ),
      ),
    );
  }
}
