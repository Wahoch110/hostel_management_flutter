import 'package:flutter/material.dart';

class HelpFaqScreen extends StatelessWidget {
  const HelpFaqScreen({super.key});

  static const List<_FaqSection> _sections = [
    _FaqSection(
      title: 'Complaints',
      icon: Icons.report_problem_outlined,
      color: Color(0xFFEF4444),
      faqs: [
        _Faq(
          q: 'How do I submit a complaint?',
          a: 'Go to Home → Quick Actions → Complaint. Select a category, describe the issue in detail (at least 10 characters), and tap Submit.',
        ),
        _Faq(
          q: 'Which complaint categories are available?',
          a: 'You can raise complaints about Electricity, Water, Cleanliness, Internet, Noise, or select "Other" for anything not listed.',
        ),
        _Faq(
          q: 'How long does it take to resolve a complaint?',
          a: 'Admin typically reviews complaints within 24–48 hours. Urgent issues like electricity or water problems are prioritized.',
        ),
      ],
    ),
    _FaqSection(
      title: 'Leave Requests',
      icon: Icons.exit_to_app_outlined,
      color: Color(0xFFF59E0B),
      faqs: [
        _Faq(
          q: 'How far in advance must I submit a leave request?',
          a: 'Submit your leave request at least 24 hours before your planned departure date to allow time for admin approval.',
        ),
        _Faq(
          q: 'What reasons are accepted for leave?',
          a: 'Accepted reasons include Medical Issue, Family Emergency, Family Event, Academic Purpose, Personal Work, and Other.',
        ),
        _Faq(
          q: 'Can I edit a leave request after submitting?',
          a: 'Yes. Open My History from the Profile menu, find your leave request, and tap the edit icon to modify the details.',
        ),
      ],
    ),
    _FaqSection(
      title: 'Visitor Requests',
      icon: Icons.people_outline_rounded,
      color: Color(0xFF10B981),
      faqs: [
        _Faq(
          q: 'What are the allowed visiting hours?',
          a: 'Visitors are allowed between 9 AM and 8 PM only. Requests outside this window will not be approved.',
        ),
        _Faq(
          q: 'What information is required for a visitor request?',
          a: 'You need to provide the visitor\'s full name, phone number, purpose of visit, relationship, visit date, and time.',
        ),
        _Faq(
          q: 'How many visitors can I register at once?',
          a: 'Each request covers one visitor. Submit separate requests if you expect multiple visitors on the same day.',
        ),
      ],
    ),
    _FaqSection(
      title: 'Room Change Requests',
      icon: Icons.swap_horiz_rounded,
      color: Color(0xFF8B5CF6),
      faqs: [
        _Faq(
          q: 'Can I request any available room?',
          a: 'You can specify a preferred room number. The admin will approve the change subject to availability and hostel policy.',
        ),
        _Faq(
          q: 'What does the Priority field mean?',
          a: '"Normal" means a routine request. "Urgent" flags the request for faster review — use it only for genuine urgent situations.',
        ),
        _Faq(
          q: 'How long does a room change approval take?',
          a: 'Normal requests are processed within 3–5 working days. Urgent requests are reviewed within 24 hours.',
        ),
      ],
    ),
    _FaqSection(
      title: 'Contacting Admin',
      icon: Icons.support_agent_outlined,
      color: Color(0xFF4F46E5),
      faqs: [
        _Faq(
          q: 'How do I contact admin directly?',
          a: 'Go to Profile → Contact Us for the support email and available contact channels.',
        ),
        _Faq(
          q: 'Where can I view my submitted requests?',
          a: 'All submissions are saved in My History. Open it from Profile → History.',
        ),
        _Faq(
          q: 'What if my request stays pending for a long time?',
          a: 'Contact admin via the Contact Us screen with your request details. Provide your roll number and room number for faster resolution.',
        ),
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F4FF),
      appBar: AppBar(title: const Text('Help & FAQs')),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
        physics: const BouncingScrollPhysics(),
        children: [
          // Header info card
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: const Color(0xFFEEF2FF),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Row(children: [
              Icon(Icons.help_outline_rounded, color: Color(0xFF4F46E5)),
              SizedBox(width: 10),
              Expanded(
                child: Text(
                  'Tap any question to expand the answer.',
                  style: TextStyle(fontSize: 13, color: Color(0xFF4F46E5)),
                ),
              ),
            ]),
          ),

          const SizedBox(height: 16),

          ..._sections.map((section) => _SectionWidget(section: section)),
        ],
      ),
    );
  }
}

// ── Data classes (const so they can be compile-time constants) ────────────────
class _Faq {
  final String q;
  final String a;
  const _Faq({required this.q, required this.a});
}

class _FaqSection {
  final String title;
  final IconData icon;
  final Color color;
  final List<_Faq> faqs;
  const _FaqSection(
      {required this.title,
      required this.icon,
      required this.color,
      required this.faqs});
}

// ── Section widget ────────────────────────────────────────────────────────────
class _SectionWidget extends StatelessWidget {
  final _FaqSection section;
  const _SectionWidget({super.key, required this.section});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withValues(alpha: 0.04), blurRadius: 6)
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Section header
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 14, 16, 8),
              child: Row(children: [
                Container(
                  padding: const EdgeInsets.all(7),
                  decoration: BoxDecoration(
                      color: section.color.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(8)),
                  child: Icon(section.icon, color: section.color, size: 16),
                ),
                const SizedBox(width: 10),
                Text(section.title,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: section.color)),
              ]),
            ),

            const Divider(height: 1, color: Color(0xFFE5E7EB)),

            // FAQs
            ...section.faqs.map((faq) => Theme(
                  data: Theme.of(context)
                      .copyWith(dividerColor: Colors.transparent),
                  child: ExpansionTile(
                    tilePadding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
                    childrenPadding:
                        const EdgeInsets.fromLTRB(16, 0, 16, 14),
                    iconColor: const Color(0xFF4F46E5),
                    collapsedIconColor: const Color(0xFF9CA3AF),
                    title: Text(faq.q,
                        style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF1F1F2E))),
                    children: [
                      Text(faq.a,
                          style: const TextStyle(
                              fontSize: 13,
                              color: Color(0xFF374151),
                              height: 1.5)),
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
