// ============================================================
// MODEL: NoticeModel
// KEY CONCEPT: const constructor, final fields
// ============================================================

class NoticeModel {
  final String id;
  final String title;
  final String body;
  final String date;
  final String postedBy;
  final String category; // 'General', 'Urgent', 'Event'

  const NoticeModel({
    required this.id,
    required this.title,
    required this.body,
    required this.date,
    required this.postedBy,
    required this.category,
  });
}