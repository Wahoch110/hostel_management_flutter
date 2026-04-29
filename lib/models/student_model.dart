class StudentModel {
  final String name;
  final String email;
  final String phone;
  final String rollNumber;
  final String roomNumber;
  final String cnic;
  final String department;

  const StudentModel({
    required this.name,
    required this.email,
    required this.phone,
    required this.rollNumber,
    required this.roomNumber,
    required this.cnic,
    required this.department,
  });

  StudentModel copyWith({
    String? name,
    String? email,
    String? phone,
    String? rollNumber,
    String? roomNumber,
    String? cnic,
    String? department,
  }) {
    return StudentModel(
      name:       name       ?? this.name,
      email:      email      ?? this.email,
      phone:      phone      ?? this.phone,
      rollNumber: rollNumber ?? this.rollNumber,
      roomNumber: roomNumber ?? this.roomNumber,
      cnic:       cnic       ?? this.cnic,
      department: department ?? this.department,
    );
  }
}