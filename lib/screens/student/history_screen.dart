import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/history_model.dart';
import '../../providers/history_provider.dart';
import 'complaint_screen.dart';
import 'leave_request_screen.dart';
import 'visitor_request_screen.dart';
import 'room_change_screen.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  final TextEditingController _searchCtrl = TextEditingController();
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    // Simulate a brief loading state on first open
    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) setState(() => _isLoading = false);
    });
    _searchCtrl.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  Future<void> _onRefresh() async {
    setState(() => _isLoading = true);
    await Future.delayed(const Duration(milliseconds: 800));
    if (mounted) setState(() => _isLoading = false);
  }

  // ── Delete with confirmation ───────────────────────────────────────────────
  void _confirmDelete(BuildContext ctx, String id) {
    showDialog<bool>(
      context: ctx,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        title: const Text('Delete Record',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        content: const Text('Are you sure you want to delete this item?',
            style: TextStyle(fontSize: 14, color: Color(0xFF374151))),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Cancel',
                style: TextStyle(color: Color(0xFF9CA3AF))),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Delete',
                style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    ).then((confirmed) {
      if (confirmed == true && mounted) {
        context.read<HistoryProvider>().deleteRecord(id);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Record deleted.'),
            backgroundColor: Colors.red,
            duration: Duration(seconds: 2),
          ),
        );
      }
    });
  }

  // ── Navigate to edit form ──────────────────────────────────────────────────
  void _editRecord(HistoryRecord record) {
    Widget screen;
    switch (record.type) {
      case RecordType.complaint:
        screen = ComplaintScreen(editRecord: record as ComplaintRecord);
        break;
      case RecordType.leaveRequest:
        screen = LeaveRequestScreen(editRecord: record as LeaveRecord);
        break;
      case RecordType.visitorRequest:
        screen = VisitorRequestScreen(editRecord: record as VisitorRecord);
        break;
      case RecordType.roomChange:
        screen = RoomChangeScreen(editRecord: record as RoomChangeRecord);
        break;
    }
    Navigator.push(context, MaterialPageRoute(builder: (_) => screen));
  }

  // ── Helpers ────────────────────────────────────────────────────────────────
  String _fmtDate(DateTime d) {
    const m = [
      '', 'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    return '${d.day} ${m[d.month]} ${d.year}';
  }

  String _fmtTime(TimeOfDay t) {
    final h = t.hourOfPeriod == 0 ? 12 : t.hourOfPeriod;
    final min = t.minute.toString().padLeft(2, '0');
    final ap = t.period == DayPeriod.am ? 'AM' : 'PM';
    return '$h:$min $ap';
  }

  // ── Card builders ──────────────────────────────────────────────────────────
  Widget _buildCard(HistoryRecord record) {
    switch (record.type) {
      case RecordType.complaint:
        return _ComplaintCard(
          record: record as ComplaintRecord,
          onEdit: () => _editRecord(record),
          onDelete: () => _confirmDelete(context, record.id),
        );
      case RecordType.leaveRequest:
        return _LeaveCard(
          record: record as LeaveRecord,
          fmtDate: _fmtDate,
          onEdit: () => _editRecord(record),
          onDelete: () => _confirmDelete(context, record.id),
        );
      case RecordType.visitorRequest:
        return _VisitorCard(
          record: record as VisitorRecord,
          fmtDate: _fmtDate,
          fmtTime: _fmtTime,
          onEdit: () => _editRecord(record),
          onDelete: () => _confirmDelete(context, record.id),
        );
      case RecordType.roomChange:
        return _RoomChangeCard(
          record: record as RoomChangeRecord,
          onEdit: () => _editRecord(record),
          onDelete: () => _confirmDelete(context, record.id),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F4FF),
      appBar: AppBar(title: const Text('My History')),
      body: Column(
        children: [
          // ── Search bar ───────────────────────────────────────────────────
          Container(
            color: const Color(0xFF4F46E5),
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: TextField(
              controller: _searchCtrl,
              style: const TextStyle(fontSize: 14, color: Color(0xFF1F1F2E)),
              decoration: InputDecoration(
                hintText: 'Search complaints, leave, visitor...',
                hintStyle:
                    const TextStyle(color: Color(0xFF9CA3AF), fontSize: 13),
                prefixIcon: const Icon(Icons.search, color: Color(0xFF9CA3AF)),
                suffixIcon: _searchCtrl.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.close,
                            color: Color(0xFF9CA3AF), size: 18),
                        onPressed: () => _searchCtrl.clear(),
                      )
                    : null,
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide:
                      const BorderSide(color: Color(0xFF4F46E5), width: 2),
                ),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 11),
              ),
            ),
          ),

          // ── Body ─────────────────────────────────────────────────────────
          Expanded(
            child: _isLoading
                ? const Center(
                    child: CircularProgressIndicator(
                      color: Color(0xFF4F46E5),
                    ),
                  )
                : Consumer<HistoryProvider>(
                    builder: (context, hp, _) {
                      final filtered = hp.search(_searchCtrl.text);

                      if (hp.records.isEmpty) {
                        return _EmptyState(
                            message:
                                'No submissions yet.\nUse Quick Actions to submit requests.');
                      }

                      if (filtered.isEmpty) {
                        return _EmptyState(
                            message:
                                'No results found for\n"${_searchCtrl.text}"');
                      }

                      return RefreshIndicator(
                        color: const Color(0xFF4F46E5),
                        onRefresh: _onRefresh,
                        child: ListView.builder(
                          padding: const EdgeInsets.fromLTRB(16, 14, 16, 20),
                          physics: const AlwaysScrollableScrollPhysics(
                              parent: BouncingScrollPhysics()),
                          itemCount: filtered.length,
                          itemBuilder: (_, i) => Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: _buildCard(filtered[i]),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

// ── Empty state ──────────────────────────────────────────────────────────────
class _EmptyState extends StatelessWidget {
  final String message;
  const _EmptyState({required this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: const Color(0xFFEEF2FF),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.history_rounded,
                  size: 52, color: Color(0xFF4F46E5)),
            ),
            const SizedBox(height: 20),
            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontSize: 15,
                  color: Color(0xFF374151),
                  fontWeight: FontWeight.w500,
                  height: 1.5),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Shared card shell ─────────────────────────────────────────────────────────
class _CardShell extends StatelessWidget {
  final Color accentColor;
  final IconData typeIcon;
  final String typeLabel;
  final List<Widget> fields;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const _CardShell({
    required this.accentColor,
    required this.typeIcon,
    required this.typeLabel,
    required this.fields,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 8)
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Type badge row
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(7),
                decoration: BoxDecoration(
                    color: accentColor.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(8)),
                child: Icon(typeIcon, color: accentColor, size: 16),
              ),
              const SizedBox(width: 8),
              Text(typeLabel,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                      color: accentColor)),
              const Spacer(),
              // Edit button
              InkWell(
                onTap: onEdit,
                borderRadius: BorderRadius.circular(8),
                child: Padding(
                  padding: const EdgeInsets.all(6),
                  child: Icon(Icons.edit_outlined,
                      size: 18, color: const Color(0xFF4F46E5)),
                ),
              ),
              const SizedBox(width: 2),
              // Delete button
              InkWell(
                onTap: onDelete,
                borderRadius: BorderRadius.circular(8),
                child: Padding(
                  padding: const EdgeInsets.all(6),
                  child:
                      Icon(Icons.delete_outline, size: 18, color: Colors.red),
                ),
              ),
            ],
          ),

          const SizedBox(height: 10),
          const Divider(height: 1, color: Color(0xFFE5E7EB)),
          const SizedBox(height: 10),

          ...fields,
        ],
      ),
    );
  }
}

// ── Field row inside card ──────────────────────────────────────────────────
class _FieldRow extends StatelessWidget {
  final String label;
  final String value;

  const _FieldRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 110,
            child: Text(label,
                style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF9CA3AF),
                    fontWeight: FontWeight.w500)),
          ),
          Expanded(
            child: Text(value,
                style: const TextStyle(
                    fontSize: 13,
                    color: Color(0xFF1F1F2E),
                    fontWeight: FontWeight.w600)),
          ),
        ],
      ),
    );
  }
}

// ── Complaint card ────────────────────────────────────────────────────────────
class _ComplaintCard extends StatelessWidget {
  final ComplaintRecord record;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const _ComplaintCard(
      {required this.record, required this.onEdit, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return _CardShell(
      accentColor: const Color(0xFFEF4444),
      typeIcon: Icons.report_problem_outlined,
      typeLabel: 'Complaint',
      onEdit: onEdit,
      onDelete: onDelete,
      fields: [
        _FieldRow(label: 'Category', value: record.category),
        _FieldRow(label: 'Description', value: record.description),
      ],
    );
  }
}

// ── Leave card ────────────────────────────────────────────────────────────────
class _LeaveCard extends StatelessWidget {
  final LeaveRecord record;
  final String Function(DateTime) fmtDate;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const _LeaveCard({
    required this.record,
    required this.fmtDate,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return _CardShell(
      accentColor: const Color(0xFFF59E0B),
      typeIcon: Icons.exit_to_app_outlined,
      typeLabel: 'Leave Request',
      onEdit: onEdit,
      onDelete: onDelete,
      fields: [
        _FieldRow(label: 'Leave Date', value: fmtDate(record.leaveDate)),
        _FieldRow(label: 'Return Date', value: fmtDate(record.returnDate)),
        _FieldRow(label: 'Reason', value: record.reason),
        _FieldRow(label: 'Details', value: record.additionalDetails),
      ],
    );
  }
}

// ── Visitor card ──────────────────────────────────────────────────────────────
class _VisitorCard extends StatelessWidget {
  final VisitorRecord record;
  final String Function(DateTime) fmtDate;
  final String Function(TimeOfDay) fmtTime;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const _VisitorCard({
    required this.record,
    required this.fmtDate,
    required this.fmtTime,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return _CardShell(
      accentColor: const Color(0xFF10B981),
      typeIcon: Icons.people_outline_rounded,
      typeLabel: 'Visitor Request',
      onEdit: onEdit,
      onDelete: onDelete,
      fields: [
        _FieldRow(label: 'Visitor Name', value: record.visitorName),
        _FieldRow(label: 'Phone', value: record.visitorPhone),
        _FieldRow(label: 'Purpose', value: record.purpose),
        _FieldRow(label: 'Relationship', value: record.relationship),
        _FieldRow(
            label: 'Visit Date',
            value:
                '${fmtDate(record.visitDate)}  ${fmtTime(record.visitTime)}'),
      ],
    );
  }
}

// ── Room change card ──────────────────────────────────────────────────────────
class _RoomChangeCard extends StatelessWidget {
  final RoomChangeRecord record;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const _RoomChangeCard(
      {required this.record, required this.onEdit, required this.onDelete});

  Color get _priorityColor => record.priority == 'Urgent'
      ? const Color(0xFFEF4444)
      : const Color(0xFF8B5CF6);

  @override
  Widget build(BuildContext context) {
    return _CardShell(
      accentColor: const Color(0xFF8B5CF6),
      typeIcon: Icons.swap_horiz_rounded,
      typeLabel: 'Room Change',
      onEdit: onEdit,
      onDelete: onDelete,
      fields: [
        _FieldRow(label: 'Current Room', value: record.currentRoom),
        _FieldRow(label: 'Requested', value: record.requestedRoom),
        _FieldRow(label: 'Reason', value: record.reason),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              width: 110,
              child: Text('Priority',
                  style: TextStyle(
                      fontSize: 12,
                      color: Color(0xFF9CA3AF),
                      fontWeight: FontWeight.w500)),
            ),
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
              decoration: BoxDecoration(
                  color: _priorityColor.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(20)),
              child: Text(record.priority,
                  style: TextStyle(
                      fontSize: 12,
                      color: _priorityColor,
                      fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ],
    );
  }
}
