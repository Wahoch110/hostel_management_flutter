import 'package:flutter/material.dart';
import '../../widgets/custom_text_field.dart';

class LeaveRequestScreen extends StatefulWidget {
  const LeaveRequestScreen({super.key});

  @override
  State<LeaveRequestScreen> createState() => _LeaveRequestScreenState();
}

class _LeaveRequestScreenState extends State<LeaveRequestScreen> {
  final _formKey  = GlobalKey<FormState>();
  final _descCtrl = TextEditingController();

  // Nullable DateTime — null means not yet selected
  DateTime? _leaveDate;
  DateTime? _returnDate;

  // Dropdown value
  String _reason    = 'Select a reason';
  bool   _isLoading = false;

  final List<String> _reasons = [
    'Select a reason', 'Medical Issue', 'Family Emergency',
    'Family Event', 'Academic Purpose', 'Personal Work', 'Other',
  ];

  String _fmt(DateTime d) {
    const months = ['', 'Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'];
    return '${d.day} ${months[d.month]} ${d.year}';
  }

  // showDatePicker returns Future<DateTime?>
  Future<void> _pickDate({required bool isLeave}) async {
    final picked = await showDatePicker(
      context:     context,
      initialDate: DateTime.now(),
      firstDate:   DateTime.now(),
      lastDate:    DateTime.now().add(const Duration(days: 90)),
      builder: (ctx, child) => Theme(
        data: Theme.of(ctx).copyWith(
            colorScheme: const ColorScheme.light(primary: Color(0xFF4F46E5))),
        child: child!,
      ),
    );
    if (picked != null) {
      setState(() => isLeave ? _leaveDate = picked : _returnDate = picked);
    }
  }

  Future<void> _submit() async {
    if (_leaveDate == null || _returnDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('⚠️ Please select both dates'), backgroundColor: Colors.orange));
      return;
    }
    if (_reason == 'Select a reason') {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('⚠️ Please select a reason'), backgroundColor: Colors.orange));
      return;
    }
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isLoading = true);
    await Future.delayed(const Duration(seconds: 2));
    setState(() => _isLoading = false);
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('✅ Leave request submitted! Awaiting admin approval.'),
          backgroundColor: Colors.green));
      Navigator.pop(context);
    }
  }

  Widget _datePicker({required String label, required DateTime? date, required bool isLeave}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14, color: Color(0xFF374151))),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: () => _pickDate(isLeave: isLeave),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
            decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(10),
              border: Border.all(color: const Color(0xFFE5E7EB)),
            ),
            child: Row(children: [
              const Icon(Icons.calendar_today_outlined, color: Color(0xFF4F46E5), size: 18),
              const SizedBox(width: 10),
              Text(

                date != null ? _fmt(date) : 'Tap to select date',
                style: TextStyle(
                    fontSize: 14,
                    color: date != null ? const Color(0xFF1F1F2E) : const Color(0xFF9CA3AF)),
              ),
            ]),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  InputDecoration _dropDec() => InputDecoration(
    filled: true, fillColor: Colors.white,
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Color(0xFFE5E7EB))),
    enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Color(0xFFE5E7EB))),
    contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
  );

  @override
  void dispose() { _descCtrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F4FF),
      appBar: AppBar(title: const Text('Leave Request')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        physics: const BouncingScrollPhysics(),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFFFEF3C7), borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: const Color(0xFFF59E0B)),
                ),
                child: const Row(children: [
                  Icon(Icons.info_outline, color: Color(0xFFF59E0B), size: 16),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text('Submit at least 24 hours in advance.',
                        style: TextStyle(fontSize: 12, color: Color(0xFF92400E))),
                  ),
                ]),
              ),
              const SizedBox(height: 20),

              _datePicker(label: 'Leave Date',  date: _leaveDate,  isLeave: true),
              _datePicker(label: 'Return Date', date: _returnDate, isLeave: false),

              const Text('Reason for Leave',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14, color: Color(0xFF374151))),
              const SizedBox(height: 8),
              DropdownButtonFormField<String>(
                value: _reason, decoration: _dropDec(),
                items: _reasons.map((r) => DropdownMenuItem(value: r,
                    child: Text(r, style: const TextStyle(fontSize: 14)))).toList(),
                onChanged: (v) => setState(() => _reason = v ?? 'Select a reason'),
              ),
              const SizedBox(height: 16),

              CustomTextField(
                label: 'Additional Details', hint: 'Any extra information...',
                controller: _descCtrl, maxLines: 3,
                validator: (v) => (v == null || v.trim().isEmpty) ? 'Please add details' : null,
              ),

              SizedBox(
                width: double.infinity, height: 52,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _submit,
                  child: _isLoading
                      ? const SizedBox(width: 22, height: 22,
                          child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2.5))
                      : const Text('Submit Leave Request'),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}