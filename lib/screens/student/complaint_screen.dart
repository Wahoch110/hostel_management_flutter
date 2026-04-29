import 'package:flutter/material.dart';
import '../../widgets/custom_text_field.dart';

class ComplaintScreen extends StatefulWidget {
  const ComplaintScreen({super.key});

  @override
  State<ComplaintScreen> createState() => _ComplaintScreenState();
}

class _ComplaintScreenState extends State<ComplaintScreen> {
  final _formKey  = GlobalKey<FormState>();
  final _descCtrl = TextEditingController();

  String _category  = 'Electricity';
  bool   _isLoading = false;

  final List<String> _categories = [
    'Electricity', 'Water', 'Cleanliness', 'Internet', 'Noise', 'Other',
  ];

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isLoading = true);
    await Future.delayed(const Duration(seconds: 2));
    setState(() => _isLoading = false);
    if (mounted) {
      _descCtrl.clear();
      setState(() => _category = 'Electricity');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content:         Text('✅ Complaint submitted! Admin will respond shortly.'),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  @override
  void dispose() { _descCtrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F4FF),
      appBar: AppBar(title: const Text('Submit Complaint')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        physics: const BouncingScrollPhysics(),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Info card
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                    color: const Color(0xFFEEF2FF), borderRadius: BorderRadius.circular(12)),
                child: const Row(children: [
                  Icon(Icons.info_outline, color: Color(0xFF4F46E5)),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text('Your complaint will be reviewed and addressed by the admin.',
                        style: TextStyle(fontSize: 13, color: Color(0xFF4F46E5))),
                  ),
                ]),
              ),

              const SizedBox(height: 22),

              const Text('Select Category',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15, color: Color(0xFF374151))),
              const SizedBox(height: 10),

              Container(
                decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(12),
                  boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 6)],
                ),
                child: Column(
                  children: _categories.map((cat) =>
                    // KEY CONCEPT: RadioListTile — grouped radio buttons
                    RadioListTile<String>(
                      title:      Text(cat, style: const TextStyle(fontSize: 14)),
                      value:      cat,
                      groupValue: _category, // currently selected
                      activeColor: const Color(0xFF4F46E5),
                      onChanged: (v) =>
                          setState(() => _category = v ?? 'Electricity'),
                    ),
                  ).toList(),
                ),
              ),

              const SizedBox(height: 20),

              CustomTextField(
                label:    'Describe the Issue',
                hint:     'Explain your problem in detail...',
                controller: _descCtrl,
                maxLines: 4,
                validator: (v) {
                  if (v == null || v.trim().isEmpty) return 'Description is required';
                  if (v.trim().length < 10)          return 'Too short — add more detail';
                  return null;
                },
              ),

              const SizedBox(height: 10),

              SizedBox(
                width: double.infinity, height: 52,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _submit,
                  child: _isLoading
                      ? const SizedBox(width: 22, height: 22,
                          child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2.5))
                      : const Text('Submit Complaint'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}