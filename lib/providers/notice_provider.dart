import 'package:flutter/material.dart';
import '../models/notice_model.dart';

class NoticeProvider extends ChangeNotifier {

  final List<NoticeModel> _notices = const [
    NoticeModel(
      id: '1', title: 'Hostel Fee Due Date', category: 'Urgent',
      body: 'All students must submit hostel fee before 15th of every month. '
            'Late fee of Rs. 200/day will be charged after the due date.',
      date: '10 Jan 2025', postedBy: 'Admin Office',
    ),
    NoticeModel(
      id: '2', title: 'Water Supply Maintenance', category: 'General',
      body: 'Water supply will be suspended on 12 Jan from 9 AM to 2 PM '
            'due to scheduled maintenance work in Block A and B.',
      date: '09 Jan 2025', postedBy: 'Maintenance Dept.',
    ),
    NoticeModel(
      id: '3', title: 'Mess Menu Updated', category: 'General',
      body: 'The weekly mess menu has been updated. Check the Mess section '
            'in the app for the latest schedule.',
      date: '08 Jan 2025', postedBy: 'Mess Manager',
    ),
    NoticeModel(
      id: '4', title: 'Curfew Time Reminder', category: 'Urgent',
      body: 'All students must return to hostel by 10:00 PM. Strict '
            'disciplinary action will be taken against violators.',
      date: '07 Jan 2025', postedBy: 'Hostel Warden',
    ),
    NoticeModel(
      id: '5', title: 'Annual Sports Day', category: 'Event',
      body: 'Annual Sports Day will be held on 20 Jan. Students are '
            'encouraged to register for their desired events.',
      date: '06 Jan 2025', postedBy: 'Sports Committee',
    ),
    NoticeModel(
      id: '6', title: 'Room Inspection Notice', category: 'General',
      body: 'Room inspection will be carried out on 14 Jan by the warden. '
            'Keep your rooms clean and tidy.',
      date: '05 Jan 2025', postedBy: 'Admin Office',
    ),
  ];

  List<NoticeModel> get notices => _notices;
  List<NoticeModel> get recentNotices => _notices.take(3).toList();
}