import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/history_model.dart';
import '../../providers/history_provider.dart';
import '../../services/api_service.dart';
import '../../services/complaint_service.dart';
import '../../widgets/custom_text_field.dart';

class ComplaintScreen extends StatefulWidget {
  final ComplaintRecord? editRecord;
  const ComplaintScreen({super.key, this.editRecord});

  @override
  State<ComplaintScreen> createState() => _ComplaintScreenState();
}

class _ComplaintScreenState extends State<ComplaintScreen> {
  final _formKey  = GlobalKey<FormState>();
  final _descCtrl = TextEditingController();

  String _category  = 'Electricity';
  bool   _isLoading = false;

  bool get _isEditing => widget.editRecord != null;

  final List<String> _categories = [
    'Electricity', 'Water', 'Cleanliness', 'Internet', 'Noise', 'Other',
  ];

  @override
  void initState() {
    super.initState();
    if (_isEditing) {
      _category      = widget.editRecord!.category;
      _descCtrl.text = widget.editRecord!.description;
    }
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);
    final provider = context.read<HistoryProvider>();

    try {
      if (_isEditing) {
        final record = widget.editRecord!;
        // If it's an API record, persist the change to the backend
        if (ApiService.isApiRecord(record.id)) {
          await ComplaintService.update(
              record.id, _category, _descCtrl.text.trim());
        }
        provider.updateRecord(
          record.copyWith(
            category:    _category,
            description: _descCtrl.text.trim(),
          ),
        );
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content:         Text('✅ Complaint updated successfully!'),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.pop(context);
      } else {
        // Create via API → get back the record with a real database id
        final newRecord = await ComplaintService.create(
            _category, _descCtrl.text.trim());
        if (!mounted) return;
        provider.addRecord(newRecord);
        _descCtrl.clear();
        setState(() => _category = 'Electricity');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content:         Text('✅ Complaint submitted! Admin will respond shortly.'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            '❌ ${e.toString().replaceAll('Exception: ', '')}',
          ),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  void dispose() {
    _descCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F4FF),
      appBar: AppBar(
          title: Text(_isEditing ? 'Edit Complaint' : 'Submit Complaint')),
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
                    color: const Color(0xFFEEF2FF),
                    borderRadius: BorderRadius.circular(12)),
                child: const Row(children: [
                  Icon(Icons.info_outline, color: Color(0xFF4F46E5)),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                        'Your complaint will be reviewed and addressed by the admin.',
                        style: TextStyle(
                            fontSize: 13, color: Color(0xFF4F46E5))),
                  ),
                ]),
              ),

              const SizedBox(height: 22),

              const Text('Select Category',
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                      color: Color(0xFF374151))),
              const SizedBox(height: 10),

              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withValues(alpha: 0.04),
                        blurRadius: 6)
                  ],
                ),
                child: Column(
                  children: _categories
                      .map((cat) => RadioListTile<String>(
                            title: Text(cat,
                                style: const TextStyle(fontSize: 14)),
                            value:      cat,
                            groupValue: _category,
                            activeColor: const Color(0xFF4F46E5),
                            onChanged: (v) =>
                                setState(() => _category = v ?? 'Electricity'),
                          ))
                      .toList(),
                ),
              ),

              const SizedBox(height: 20),

              CustomTextField(
                label:      'Describe the Issue',
                hint:       'Explain your problem in detail...',
                controller: _descCtrl,
                maxLines:   4,
                validator: (v) {
                  if (v == null || v.trim().isEmpty) {
                    return 'Description is required';
                  }
                  if (v.trim().length < 10) {
                    return 'Too short — add more detail';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 10),

              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _submit,
                  child: _isLoading
                      ? const SizedBox(
                          width: 22,
                          height: 22,
                          child: CircularProgressIndicator(
                              color: Colors.white, strokeWidth: 2.5))
                      : Text(_isEditing
                          ? 'Update Complaint'
                          : 'Submit Complaint'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
