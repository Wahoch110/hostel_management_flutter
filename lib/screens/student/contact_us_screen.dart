import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUsScreen extends StatefulWidget {
  const ContactUsScreen({super.key});

  @override
  State<ContactUsScreen> createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  final _feedbackCtrl = TextEditingController();
  bool _isSubmitting = false;

  static const String _supportEmail = 'razawahocho110@gmail.com';
  static const String _appVersion = '1.0.0';
  static const String _appName = 'HostelHub';
  static const String _contactNumber = '+923486418918';
  static const String _whatsappNumber = '923486418918';

  Future<void> _submitFeedback() async {
    if (_feedbackCtrl.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('⚠️ Please enter your feedback first.'),
          backgroundColor: Colors.orange));
      return;
    }
    setState(() => _isSubmitting = true);
    await Future.delayed(const Duration(seconds: 2));
    setState(() => _isSubmitting = false);
    if (mounted) {
      _feedbackCtrl.clear();
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('✅ Feedback submitted! Thank you.'),
          backgroundColor: Colors.green));
    }
  }

  void _copyEmail(BuildContext ctx) {
    Clipboard.setData(const ClipboardData(text: _supportEmail));
    ScaffoldMessenger.of(ctx).showSnackBar(const SnackBar(
        content: Text('Email copied to clipboard.'),
        duration: Duration(seconds: 2)));
  }

  Future<void> _launchPhone() async {
    final uri = Uri(scheme: 'tel', path: _contactNumber);
    if (!await launchUrl(uri)) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Could not open phone dialer.'),
            backgroundColor: Colors.red));
      }
    }
  }

  Future<void> _launchWhatsApp() async {
    final uri = Uri.parse('https://wa.me/$_whatsappNumber');
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Could not open WhatsApp.'),
            backgroundColor: Colors.red));
      }
    }
  }

  @override
  void dispose() {
    _feedbackCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F4FF),
      appBar: AppBar(title: const Text('Contact Us')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 28),
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── App info card ────────────────────────────────────────────
            _SectionCard(
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: const Color(0xFF4F46E5),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: const Icon(Icons.apartment_rounded,
                        color: Colors.white, size: 28),
                  ),
                  const SizedBox(width: 16),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(_appName,
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF1F1F2E))),
                        SizedBox(height: 2),
                        Text('Hostel Management System',
                            style: TextStyle(
                                fontSize: 12, color: Color(0xFF9CA3AF))),
                        SizedBox(height: 4),
                        Text('Version $_appVersion',
                            style: TextStyle(
                                fontSize: 11,
                                color: Color(0xFF4F46E5),
                                fontWeight: FontWeight.w500)),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 14),

            // ── Support email ────────────────────────────────────────────
            _SectionCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const _SectionTitle(
                      icon: Icons.email_outlined, label: 'Email Support'),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Send us an email at:',
                                style: TextStyle(
                                    fontSize: 12,
                                    color: Color(0xFF9CA3AF))),
                            SizedBox(height: 4),
                            Text(_supportEmail,
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xFF4F46E5))),
                          ],
                        ),
                      ),
                      IconButton(
                        onPressed: () => _copyEmail(context),
                        icon: const Icon(Icons.copy_outlined,
                            size: 20, color: Color(0xFF4F46E5)),
                        tooltip: 'Copy email',
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'We typically respond within 24 hours on working days.',
                    style: TextStyle(
                        fontSize: 12, color: Color(0xFF9CA3AF)),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 14),

            // ── Phone & WhatsApp ─────────────────────────────────────────
            _SectionCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const _SectionTitle(
                      icon: Icons.support_agent_outlined,
                      label: 'Contact Us Directly'),
                  const SizedBox(height: 12),
                  _ChannelTile(
                    icon: Icons.phone_rounded,
                    color: const Color(0xFF10B981),
                    label: 'Phone Support',
                    value: _contactNumber,
                    onTap: _launchPhone,
                  ),
                  const Divider(height: 20, thickness: 0.6),
                  _ChannelTile(
                    icon: Icons.chat_rounded,
                    color: const Color(0xFF25D366),
                    label: 'WhatsApp Support',
                    value: _contactNumber,
                    onTap: _launchWhatsApp,
                    trailingIcon: Icons.open_in_new_rounded,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 14),

            // ── Feedback ─────────────────────────────────────────────────
            _SectionCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const _SectionTitle(
                      icon: Icons.feedback_outlined,
                      label: 'Send Feedback'),
                  const SizedBox(height: 4),
                  const Text(
                    'Help us improve HostelHub — share your thoughts.',
                    style: TextStyle(
                        fontSize: 12, color: Color(0xFF9CA3AF)),
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _feedbackCtrl,
                    maxLines: 4,
                    style: const TextStyle(
                        fontSize: 14, color: Color(0xFF1F1F2E)),
                    decoration: InputDecoration(
                      hintText:
                          'Write your feedback or suggestion here...',
                      hintStyle: const TextStyle(
                          color: Color(0xFF9CA3AF), fontSize: 13),
                      filled: true,
                      fillColor: const Color(0xFFF9FAFB),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                              color: Color(0xFFE5E7EB))),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                              color: Color(0xFFE5E7EB))),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                              color: Color(0xFF4F46E5), width: 2)),
                      contentPadding: const EdgeInsets.all(13),
                    ),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      onPressed:
                          _isSubmitting ? null : _submitFeedback,
                      child: _isSubmitting
                          ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2.5))
                          : const Text('Submit Feedback'),
                    ),
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

// ── Shared widgets ─────────────────────────────────────────────────────────────
class _SectionCard extends StatelessWidget {
  final Widget child;
  const _SectionCard({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 6)
        ],
      ),
      child: child,
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final IconData icon;
  final String label;
  const _SectionTitle({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Icon(icon, size: 17, color: const Color(0xFF4F46E5)),
      const SizedBox(width: 8),
      Text(label,
          style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
              color: Color(0xFF4F46E5))),
    ]);
  }
}

class _ChannelTile extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String label;
  final String value;
  final VoidCallback? onTap;
  final IconData? trailingIcon;

  const _ChannelTile({
    required this.icon,
    required this.color,
    required this.label,
    required this.value,
    this.onTap,
    this.trailingIcon,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Row(children: [
          Container(
            padding: const EdgeInsets.all(9),
            decoration: BoxDecoration(
                color: color.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(10)),
            child: Icon(icon, color: color, size: 18),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label,
                    style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF1F1F2E))),
                const SizedBox(height: 1),
                Text(value,
                    style: const TextStyle(
                        fontSize: 12,
                        color: Color(0xFF4F46E5),
                        fontWeight: FontWeight.w500)),
              ],
            ),
          ),
          if (trailingIcon != null)
            Icon(trailingIcon, size: 15, color: const Color(0xFF9CA3AF))
          else
            const Icon(Icons.chevron_right_rounded,
                size: 18, color: Color(0xFF9CA3AF)),
        ]),
      ),
    );
  }
}
