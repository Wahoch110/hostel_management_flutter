import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/student_provider.dart';
import '../../providers/notice_provider.dart';
import '../../routes/app_routes.dart';
import '../../widgets/action_card.dart';
import '../../widgets/section_header.dart';
import '../../widgets/profile_avatar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // KEY CONCEPT: context.watch — rebuilds when student data changes
    final student = context.watch<StudentProvider>().student;
    final notices = context.watch<NoticeProvider>().recentNotices;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F4FF),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color:        Color(0xFF4F46E5),
                borderRadius: BorderRadius.only(
                  bottomLeft:  Radius.circular(28),
                  bottomRight: Radius.circular(28),
                ),
              ),
              child: SafeArea(
                bottom: false,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
                  child: Column(
                    children: [

                      Row(
                        children: [
                          ProfileAvatar(
                            radius:       26,
                            showEditBadge: false,
                            onTap: () =>
                                Navigator.pushNamed(context, AppRoutes.editProfile),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('Welcome back,',
                                    style: TextStyle(color: Colors.white70, fontSize: 12)),
                                // KEY CONCEPT: String interpolation
                                Text(student.name,
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                    overflow: TextOverflow.ellipsis),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.15),
                                shape: BoxShape.circle),
                            child: const Icon(Icons.notifications_outlined,
                                color: Colors.white, size: 22),
                          ),
                        ],
                      ),

                      const SizedBox(height: 20),

                      Row(
                        children: [
                          Expanded(
                            child: _SummaryCard(
                                icon: Icons.bed_rounded,
                                label: 'My Room',
                                value: student.roomNumber),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: _SummaryCard(
                                icon: Icons.badge_outlined,
                                label: 'Reg ID',
                                value: student.rollNumber),
                          ),
                          const SizedBox(width: 10),

                          // KEY CONCEPT: Consumer — only this widget rebuilds
                          Expanded(
                            child: Consumer<NoticeProvider>(
                              builder: (_, np, __) => _SummaryCard(
                                  icon: Icons.notifications_rounded,
                                  label: 'Notices',
                                  value: '${np.notices.length}'),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(16, 20, 16, 0),
              child: Column(
                children: [
                  const SectionHeader(title: 'Quick Actions'),
                  const SizedBox(height: 14),

                  GridView.count(
                    crossAxisCount:   3,
                    shrinkWrap:       true,
                    physics:          const NeverScrollableScrollPhysics(),
                    crossAxisSpacing: 10,
                    mainAxisSpacing:  10,
                    childAspectRatio: 1.0,
                    children: [
                      ActionCard(
                        icon: Icons.bed_outlined, label: 'Book Room',
                        color: const Color(0xFF4F46E5),
                        onTap: () => Navigator.pushNamed(context, AppRoutes.bookRoom),
                      ),
                      ActionCard(
                        icon: Icons.report_problem_outlined, label: 'Complaint',
                        color: const Color(0xFFEF4444),
                        onTap: () => Navigator.pushNamed(context, AppRoutes.complaint),
                      ),
                      ActionCard(
                        icon: Icons.exit_to_app_outlined, label: 'Leave',
                        color: const Color(0xFFF59E0B),
                        onTap: () => Navigator.pushNamed(context, AppRoutes.leaveRequest),
                      ),
                      ActionCard(
                        icon: Icons.people_outline_rounded, label: 'Visitor',
                        color: const Color(0xFF10B981),
                        onTap: () => Navigator.pushNamed(context, AppRoutes.visitorReq),
                      ),
                      ActionCard(
                        icon: Icons.swap_horiz_rounded, label: 'Rm Change',
                        color: const Color(0xFF8B5CF6),
                        onTap: () => Navigator.pushNamed(context, AppRoutes.roomChange),
                      ),
                      ActionCard(
                        icon: Icons.payments_outlined, label: 'Fee',
                        color: const Color(0xFF0EA5E9),
                        onTap: () => Navigator.pushNamed(context, AppRoutes.feePayment),
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  // ── RECENT NOTICES ────────────────────────────────
                  SectionHeader(
                    title:       'Recent Notices',
                    actionLabel: 'See All',
                    onAction: () =>
                        Navigator.pushNamed(context, AppRoutes.notices),
                  ),
                  const SizedBox(height: 12),

                  // Map recent notices to preview cards
                  ...notices.map((n) => _NoticePreviewCard(
                      title:    n.title,
                      date:     n.date,
                      category: n.category,
                      onTap: () =>
                          Navigator.pushNamed(context, AppRoutes.notices))),

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



class _SummaryCard extends StatelessWidget {
  final IconData icon;
  final String   label;
  final String   value;
  const _SummaryCard({required this.icon, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.18),
          borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Colors.white, size: 18),
          const SizedBox(height: 6),
          Text(value,
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
              overflow: TextOverflow.ellipsis),
          Text(label,
              style: const TextStyle(color: Colors.white70, fontSize: 9)),
        ],
      ),
    );
  }
}

class _NoticePreviewCard extends StatelessWidget {
  final String       title;
  final String       date;
  final String       category;
  final VoidCallback onTap;
  const _NoticePreviewCard(
      {required this.title, required this.date, required this.category, required this.onTap});

  Color get _catColor {
    switch (category) {
      case 'Urgent': return const Color(0xFFEF4444);
      case 'Event':  return const Color(0xFF10B981);
      default:       return const Color(0xFF4F46E5);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin:   const EdgeInsets.only(bottom: 10),
        padding:  const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color:        Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 6)],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                  color: _catColor.withOpacity(0.10), shape: BoxShape.circle),
              child: Icon(Icons.campaign_rounded, color: _catColor, size: 18),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
                      overflow: TextOverflow.ellipsis),
                  const SizedBox(height: 2),
                  Text(date,
                      style: const TextStyle(fontSize: 11, color: Color(0xFF9CA3AF))),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios, size: 13, color: Color(0xFF9CA3AF)),
          ],
        ),
      ),
    );
  }
}