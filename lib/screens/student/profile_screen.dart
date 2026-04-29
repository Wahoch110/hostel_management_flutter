import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/student_provider.dart';
import '../../routes/app_routes.dart';
import '../../widgets/profile_avatar.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // context.watch — rebuilds when student data changes
    final student = context.watch<StudentProvider>().student;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F4FF),
      appBar: AppBar(
        title:                    const Text('My Profile'),
        automaticallyImplyLeading: false,
        actions: [
          TextButton.icon(
            onPressed: () => Navigator.pushNamed(context, AppRoutes.editProfile),
            icon:  const Icon(Icons.edit_outlined, color: Colors.white, size: 16),
            label: const Text('Edit', style: TextStyle(color: Colors.white, fontSize: 13)),
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            Container(
              width:   double.infinity,
              color:   const Color(0xFF4F46E5),
              padding: const EdgeInsets.only(top: 10, bottom: 28, left: 20, right: 20),
              child: Column(
                children: [
                  // ProfileAvatar widget — handles asset and file images
                  ProfileAvatar(
                    radius:        54,
                    showEditBadge: true,
                    onTap: () => Navigator.pushNamed(context, AppRoutes.editProfile),
                  ),

                  const SizedBox(height: 14),

                  Text(student.name,
                      style: const TextStyle(
                          color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  Text(student.rollNumber,
                      style: const TextStyle(color: Colors.white70, fontSize: 13)),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
                    decoration: BoxDecoration(
                        color:        Colors.white.withOpacity(0.20),
                        borderRadius: BorderRadius.circular(20)),
                    child: Text(student.department,
                        style: const TextStyle(color: Colors.white, fontSize: 12)),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  _InfoSection(title: 'Personal Information', children: [
                    _InfoRow(icon: Icons.person_outline,   label: 'Full Name',  value: student.name),
                    _InfoRow(icon: Icons.email_outlined,   label: 'Email',      value: student.email),
                    _InfoRow(icon: Icons.phone_outlined,   label: 'Phone',      value: student.phone),
                    _InfoRow(icon: Icons.badge_outlined,   label: 'CNIC',       value: student.cnic),
                  ]),

                  const SizedBox(height: 14),

                  _InfoSection(title: 'Academic & Hostel', children: [
                    _InfoRow(icon: Icons.school_outlined,              label: 'Department',  value: student.department),
                    _InfoRow(icon: Icons.confirmation_number_outlined, label: 'Roll Number', value: student.rollNumber),
                    _InfoRow(icon: Icons.bed_outlined,                 label: 'Room Number', value: student.roomNumber),
                  ]),

                  const SizedBox(height: 20),

                  // Logout button
                  SizedBox(
                    width: double.infinity, height: 50,
                    child: OutlinedButton.icon(
                      onPressed: () {
                        Navigator.pushNamedAndRemoveUntil(
                            context, AppRoutes.welcome, (route) => false);
                      },
                      icon:  const Icon(Icons.logout, color: Colors.red, size: 18),
                      label: const Text('Logout',
                          style: TextStyle(color: Colors.red, fontWeight: FontWeight.w600)),
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
          ],
        ),
      ),
    );
  }
}

class _InfoSection extends StatelessWidget {
  final String title; final List<Widget> children;
  const _InfoSection({required this.title, required this.children});

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
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Color(0xFF4F46E5))),
        const SizedBox(height: 10),
        const Divider(height: 1, color: Color(0xFFE5E7EB)),
        const SizedBox(height: 10),
        ...children,
      ]),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon; final String label, value;
  const _InfoRow({required this.icon, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Icon(icon, size: 18, color: const Color(0xFF9CA3AF)),
        const SizedBox(width: 12),
        Expanded(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(label, style: const TextStyle(fontSize: 11, color: Color(0xFF9CA3AF))),
            const SizedBox(height: 2),
            Text(value,
                style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Color(0xFF1F1F2E))),
          ]),
        ),
      ]),
    );
  }
}