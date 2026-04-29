import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/student_provider.dart';

class ProfileAvatar extends StatelessWidget {
  final double       radius;
  final bool         showEditBadge;
  final VoidCallback? onTap;

  const ProfileAvatar({
    super.key,
    this.radius       = 50,
    this.showEditBadge = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final provider  = context.watch<StudentProvider>();
    final imgPath   = provider.profileImagePath;
    final imgType   = provider.profileImageType;

    return GestureDetector(
      onTap: onTap,
      child: Stack(
        children: [
          CircleAvatar(
            radius:          radius,
            backgroundColor: const Color(0xFFE0E7FF),
            // Show image based on type; null means show default icon
            backgroundImage: _imageProvider(imgPath, imgType),
            child: _imageProvider(imgPath, imgType) == null
                ? Icon(Icons.person_rounded, size: radius, color: const Color(0xFF4F46E5))
                : null,
          ),
          if (showEditBadge)
            Positioned(
              bottom: 0,
              right:  0,
              child: GestureDetector(
                onTap: onTap,
                child: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: const Color(0xFF4F46E5),
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                  child: Icon(Icons.camera_alt_rounded,
                      size: radius * 0.28, color: Colors.white),
                ),
              ),
            ),
        ],
      ),
    );
  }

  // Returns correct ImageProvider based on type
  ImageProvider? _imageProvider(String path, String type) {
    if (path.isEmpty) return null;
    if (type == 'file')  return FileImage(File(path));
    if (type == 'asset') return AssetImage(path);
    return null;
  }
}