import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/history_model.dart';
import '../../providers/history_provider.dart';
import '../../widgets/custom_text_field.dart';

class RoomChangeScreen extends StatefulWidget {
  final RoomChangeRecord? editRecord;
  const RoomChangeScreen({super.key, this.editRecord});

  @override
  State<RoomChangeScreen> createState() => _RoomChangeScreenState();
}

class _RoomChangeScreenState extends State<RoomChangeScreen> {
  final _formKey     = GlobalKey<FormState>();
  final _currentCtrl = TextEditingController(text: 'B-204');
  final _requestCtrl = TextEditingController();
  final _reasonCtrl  = TextEditingController();

  String _priority  = 'Normal';
  bool   _isLoading = false;

  bool get _isEditing => widget.editRecord != null;

  final List<String> _priorities = ['Normal', 'Urgent'];

  @override
  void initState() {
    super.initState();
    if (_isEditing) {
      _currentCtrl.text = widget.editRecord!.currentRoom;
      _requestCtrl.text = widget.editRecord!.requestedRoom;
      _reasonCtrl.text  = widget.editRecord!.reason;
      _priority         = widget.editRecord!.priority;
    }
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isLoading = true);
    await Future.delayed(const Duration(seconds: 2));
    setState(() => _isLoading = false);
    if (!mounted) return;

    final provider = context.read<HistoryProvider>();

    if (_isEditing) {
      provider.updateRecord(
        widget.editRecord!.copyWith(
          currentRoom:   _currentCtrl.text.trim(),
          requestedRoom: _requestCtrl.text.trim(),
          reason:        _reasonCtrl.text.trim(),
          priority:      _priority,
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content:         Text('✅ Room change request updated!'),
          backgroundColor: Colors.green,
        ),
      );
    } else {
      provider.addRecord(RoomChangeRecord(
        id:            HistoryProvider.generateId(),
        currentRoom:   _currentCtrl.text.trim(),
        requestedRoom: _requestCtrl.text.trim(),
        reason:        _reasonCtrl.text.trim(),
        priority:      _priority,
      ));
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content:         Text('Room change request submitted! Admin will review it.'),
          backgroundColor: Colors.green,
        ),
      );
    }
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _currentCtrl.dispose();
    _requestCtrl.dispose();
    _reasonCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F4FF),
      appBar: AppBar(
          title: Text(_isEditing
              ? 'Edit Room Change Request'
              : 'Room Change Request')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        physics: const BouncingScrollPhysics(),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                    color: const Color(0xFFEEF2FF),
                    borderRadius: BorderRadius.circular(12)),
                child: const Row(children: [
                  Icon(Icons.swap_horiz_rounded,
                      color: Color(0xFF4F46E5)),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'Room change requests are subject to availability and admin approval.',
                      style: TextStyle(
                          fontSize: 13, color: Color(0xFF4F46E5)),
                    ),
                  ),
                ]),
              ),

              const SizedBox(height: 24),

              CustomTextField(
                label:    'Current Room',
                hint:     'Your current room',
                controller: _currentCtrl,
                readOnly: true,
              ),

              CustomTextField(
                label:    'Requested Room',
                hint:     'e.g. A-101, C-302',
                controller: _requestCtrl,
                validator: (v) => (v == null || v.isEmpty)
                    ? 'Enter preferred room number'
                    : null,
              ),

              CustomTextField(
                label:    'Reason for Change',
                hint:     'Explain why you need to change room...',
                controller: _reasonCtrl,
                maxLines: 3,
                validator: (v) => (v == null || v.trim().isEmpty)
                    ? 'Reason is required'
                    : null,
              ),

              const Text('Priority',
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      color: Color(0xFF374151))),
              const SizedBox(height: 10),

              Row(
                children: _priorities.map((p) {
                  final bool sel = _priority == p;
                  return Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: GestureDetector(
                      onTap: () => setState(() => _priority = p),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 22, vertical: 10),
                        decoration: BoxDecoration(
                          color: sel
                              ? const Color(0xFF4F46E5)
                              : Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                              color: sel
                                  ? const Color(0xFF4F46E5)
                                  : const Color(0xFFE5E7EB)),
                        ),
                        child: Text(p,
                            style: TextStyle(
                                color: sel
                                    ? Colors.white
                                    : const Color(0xFF374151),
                                fontWeight: FontWeight.w600)),
                      ),
                    ),
                  );
                }).toList(),
              ),

              const SizedBox(height: 28),

              SizedBox(
                width: double.infinity, height: 52,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _submit,
                  child: _isLoading
                      ? const SizedBox(
                          width: 22, height: 22,
                          child: CircularProgressIndicator(
                              color: Colors.white, strokeWidth: 2.5))
                      : Text(_isEditing
                          ? 'Update Request'
                          : 'Submit Request'),
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
