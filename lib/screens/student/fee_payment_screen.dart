import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/student_provider.dart';

class FeePaymentScreen extends StatelessWidget {
  const FeePaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final student = context.watch<StudentProvider>().student;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F4FF),
      appBar: AppBar(title: const Text('Fee Payment')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                  color: const Color(0xFF0EA5E9).withOpacity(0.10), shape: BoxShape.circle),
              child: const Icon(Icons.payments_outlined, size: 60, color: Color(0xFF0EA5E9)),
            ),
            const SizedBox(height: 20),
            const Text('Hostel Fee Payment',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF1F1F2E))),
            const SizedBox(height: 6),
            const Text('Please read the payment instructions carefully.',
                style: TextStyle(fontSize: 13, color: Color(0xFF6B7280)), textAlign: TextAlign.center),
            const SizedBox(height: 24),

            // Instruction card
            Container(
              width: double.infinity, padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFF0EA5E9).withOpacity(0.4)),
                boxShadow: [BoxShadow(color: const Color(0xFF0EA5E9).withOpacity(0.06), blurRadius: 10)],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(children: [
                    Icon(Icons.info_outline, color: Color(0xFF0EA5E9), size: 20),
                    SizedBox(width: 8),
                    Text('Payment Instructions',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Color(0xFF0EA5E9))),
                  ]),
                  const SizedBox(height: 12),
                  const Divider(color: Color(0xFFE5E7EB)),
                  const SizedBox(height: 12),
                  // KEY CONCEPT: String interpolation in multi-line text
                  Text(
                    'Dear ${student.name},\n\n'
                    'Please submit your hostel fee in cash directly to the '
                    'Admin Office (Room A-001) during office hours:\n\n'
                    '🕘  Monday – Friday\n'
                    '    9:00 AM to 4:00 PM\n\n'
                    'Bring your Roll No. (${student.rollNumber}) '
                    'and fee receipt book for verification.',
                    style: const TextStyle(fontSize: 13, color: Color(0xFF4B5563), height: 1.7),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 14),

           
            Container(
              width: double.infinity, padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(14),
                boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 6)],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Your Details',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Color(0xFF374151))),
                  const SizedBox(height: 12),
                  _FeeRow('Name',        student.name),
                  _FeeRow('Roll Number', student.rollNumber),
                  _FeeRow('Room Number', student.roomNumber),
                  const _FeeRow('Monthly Fee', 'Rs. 8,500'),
                  const _FeeRow('Status',      '⏳ Pending'),
                ],
              ),
            ),

            const SizedBox(height: 14),

            // Warning banner
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFFFEF3C7), borderRadius: BorderRadius.circular(10),
                border: Border.all(color: const Color(0xFFF59E0B)),
              ),
              child: const Row(children: [
                Icon(Icons.warning_amber_outlined, color: Color(0xFFF59E0B), size: 18),
                SizedBox(width: 8),
                Expanded(
                  child: Text('Late fee of Rs. 200/day after the 15th of each month.',
                      style: TextStyle(fontSize: 12, color: Color(0xFF92400E))),
                ),
              ]),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}

class _FeeRow extends StatelessWidget {
  final String label; final String value;
  const _FeeRow(this.label, this.value);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontSize: 13, color: Color(0xFF6B7280))),
          Text(value, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Color(0xFF1F1F2E))),
        ],
      ),
    );
  }
}