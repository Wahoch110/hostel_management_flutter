import 'package:flutter/material.dart';
import '../models/student_model.dart';

class StudentProvider extends ChangeNotifier {
  StudentModel _student = const StudentModel(
    name:       'Muhammad Raza ',
    email:      'raza@szabist.edu.pk',
    phone:      '0348-6418918',
    rollNumber: 'BSSE-2380157',
    roomNumber: 'B-204',
    cnic:       '43403-0404870-7',
    department: 'Software Engineering',
  );


  String _profileImagePath = 'assets/images/profile.png'; 
  String _profileImageType = 'asset';

  StudentModel get student          => _student;
  String       get profileImagePath => _profileImagePath;
  String       get profileImageType => _profileImageType;
  bool         get hasCustomImage   => _profileImagePath.isNotEmpty;

  void updateStudent({
    required String name,
    required String email,
    required String phone,
  }) {
    _student = _student.copyWith(name: name, email: email, phone: phone);
    notifyListeners(); 
  }

  void setFileImage(String filePath) {
    _profileImagePath = filePath;
    _profileImageType = 'file';
    notifyListeners();
  }


  void setAssetImage(String assetPath) {
    _profileImagePath = assetPath;
    _profileImageType = 'asset';
    notifyListeners();
  }

  void clearImage() {
    _profileImagePath = 'assets/images/profile.png';
    _profileImageType = 'asset';
    notifyListeners();
  }
}