import 'package:flutter/material.dart';
import '../../widgets/custom_text_field.dart';

class VisitorRequestScreen extends StatefulWidget {
  const VisitorRequestScreen({super.key});

  @override
  State<VisitorRequestScreen> createState() => _VisitorRequestScreenState();
}

class _VisitorRequestScreenState extends State<VisitorRequestScreen> {
  final _formKey     = GlobalKey<FormState>();
  final _nameCtrl    = TextEditingController();
  final _phoneCtrl   = TextEditingController();
  final _purposeCtrl = TextEditingController();

  DateTime?  _visitDate;
  TimeOfDay? _visitTime; 
  String     _relationship = 'Select relationship';
  bool       _isLoading    = false;

  final List<String> _relationships = [
    'Select relationship', 'Father', 'Mother', 'Brother',
    'Sister', 'Uncle', 'Aunt', 'Friend', 'Other',
  ];

  String _fmtDate(DateTime d) {
    const months = ['','Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'];
    return '${d.day} ${months[d.month]} ${d.year}';
  }

  String _fmtTime(TimeOfDay t) {
    final h  = t.hourOfPeriod == 0 ? 12 : t.hourOfPeriod;
    final m  = t.minute.toString().padLeft(2, '0');
    final ap = t.period == DayPeriod.am ? 'AM' : 'PM';
    return '$h:$m $ap';
  }

  Future<void> _pickDate() async {
    final d = await showDatePicker(
      context: context, initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate:  DateTime.now().add(const Duration(days: 60)),
      builder: (ctx, child) => Theme(
        data: Theme.of(ctx).copyWith(
            colorScheme: const ColorScheme.light(primary: Color(0xFF4F46E5))),
        child: child!,
      ),
    );
    if (d != null) setState(() => _visitDate = d);
  }

  // showTimePicker — shows clock dialog, returns TimeOfDay?
  Future<void> _pickTime() async {
    final t = await showTimePicker(
      context: context, initialTime: TimeOfDay.now(),
      builder: (ctx, child) => Theme(
        data: Theme.of(ctx).copyWith(
            colorScheme: const ColorScheme.light(primary: Color(0xFF4F46E5))),
        child: child!,
      ),
    );
    if (t != null) setState(() => _visitTime = t);
  }

  Future<void> _submit() async {
    if (_visitDate == null || _visitTime == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('⚠️ Please select visit date and time'),
          backgroundColor: Colors.orange));
      return;
    }
    if (_relationship == 'Select relationship') {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('⚠️ Please select visitor relationship'),
          backgroundColor: Colors.orange));
      return;
    }
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isLoading = true);
    await Future.delayed(const Duration(seconds: 2));
    setState(() => _isLoading = false);
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('✔️Visitor pass request submitted successfully!'),
          backgroundColor: Colors.green));
      Navigator.pop(context);
    }
  }

  Widget _pickerTile({required String label, required String value, required VoidCallback onTap, required IconData icon}) {
    final bool hasValue = value != 'Tap to select date' && value != 'Tap to select time';
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14, color: Color(0xFF374151))),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 13),
            decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(10),
              border: Border.all(color: const Color(0xFFE5E7EB)),
            ),
            child: Row(children: [
              Icon(icon, size: 16, color: const Color(0xFF4F46E5)),
              const SizedBox(width: 6),
              Expanded(
                child: Text(value,
                    style: TextStyle(
                        fontSize: 12,
                        color: hasValue ? const Color(0xFF1F1F2E) : const Color(0xFF9CA3AF))),
              ),
            ]),
          ),
        ),
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
  void dispose() { _nameCtrl.dispose(); _phoneCtrl.dispose(); _purposeCtrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F4FF),
      appBar: AppBar(title: const Text('Visitor Request')),
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
                  color: const Color(0xFFECFDF5), borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: const Color(0xFF10B981)),
                ),
                child: const Row(children: [
                  Icon(Icons.people_outline, color: Color(0xFF10B981), size: 16),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text('Visits allowed 9 AM – 8 PM only.',
                        style: TextStyle(fontSize: 12, color: Color(0xFF065F46))),
                  ),
                ]),
              ),
              const SizedBox(height: 20),

              CustomTextField(
                label: 'Visitor Full Name', hint: "Enter visitor's full name",
                controller: _nameCtrl,
                validator: (v) => (v == null || v.isEmpty) ? 'Visitor name required' : null,
              ),
              CustomTextField(
                label: 'Visitor Phone', hint: '03XX-XXXXXXX',
                controller: _phoneCtrl, keyboardType: TextInputType.phone,
                validator: (v) => (v == null || v.isEmpty) ? 'Phone number required' : null,
              ),
              CustomTextField(
                label: 'Purpose of Visit', hint: 'Reason for the visit...',
                controller: _purposeCtrl, maxLines: 2,
                validator: (v) => (v == null || v.isEmpty) ? 'Purpose is required' : null,
              ),

              const Text('Relationship',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14, color: Color(0xFF374151))),
              const SizedBox(height: 8),
              DropdownButtonFormField<String>(
                value: _relationship, decoration: _dropDec(),
                items: _relationships.map((r) => DropdownMenuItem(value: r,
                    child: Text(r, style: const TextStyle(fontSize: 14)))).toList(),
                onChanged: (v) => setState(() => _relationship = v ?? 'Select relationship'),
              ),
              const SizedBox(height: 16),

              // Date and time pickers side by side
              Row(
                children: [
                  Expanded(
                    child: _pickerTile(
                      label:  'Visit Date',
                      value:  _visitDate != null ? _fmtDate(_visitDate!) : 'Tap to select date',
                      onTap:  _pickDate,
                      icon:   Icons.calendar_today_outlined,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _pickerTile(
                      label:  'Visit Time',
                      value:  _visitTime != null ? _fmtTime(_visitTime!) : 'Tap to select time',
                      onTap:  _pickTime,
                      icon:   Icons.access_time_outlined,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              SizedBox(
                width: double.infinity, height: 52,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _submit,
                  child: _isLoading
                      ? const SizedBox(width: 22, height: 22,
                          child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2.5))
                      : const Text('Submit Visitor Request'),
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