import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../../providers/student_provider.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/profile_avatar.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey   = GlobalKey<FormState>();
  final _nameCtrl  = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();
  bool  _isLoading = false;

  // image picker instanatly open gallery
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final student = context.read<StudentProvider>().student;
      _nameCtrl.text  = student.name;
      _emailCtrl.text = student.email;
      _phoneCtrl.text = student.phone;
    });
  }


  void _showPhotoOptions() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (_) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
             
              Center(
                child: Container(
                  width: 40, height: 4,
                  decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(10)),
                ),
              ),
              const SizedBox(height: 16),
              const Text('Change Profile Photo',
                  style: TextStyle(
                      fontSize: 17, fontWeight: FontWeight.bold,
                      color: Color(0xFF1F1F2E))),
              const SizedBox(height: 4),
              const Text('Choose an option to update your photo',
                  style: TextStyle(fontSize: 13, color: Color(0xFF6B7280))),
              const SizedBox(height: 20),

              _PhotoOption(
                icon: Icons.photo_library_outlined,
                color: const Color(0xFF4F46E5),
                title: 'Choose from Gallery',
                subtitle: 'Pick any photo from your phone',
                onTap: () { Navigator.pop(context); _pickFromGallery(); },
              ),
              const SizedBox(height: 10),

              _PhotoOption(
                icon: Icons.camera_alt_outlined,
                color: const Color(0xFF10B981),
                title: 'Take a Photo',
                subtitle: 'Use your camera right now',
                onTap: () { Navigator.pop(context); _pickFromCamera(); },
              ),
              const SizedBox(height: 10),

              _PhotoOption(
                icon: Icons.delete_outline,
                color: Colors.red,
                title: 'Remove Photo',
                subtitle: 'Reset to default profile image',
                onTap: () {
                  Navigator.pop(context);
                  context.read<StudentProvider>().clearImage();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text('Photo removed.'),
                        backgroundColor: Colors.orange),
                  );
                },
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }


  Future<void> _pickFromGallery() async {
    try {
      final XFile? file = await _picker.pickImage(
        source:       ImageSource.gallery,
        imageQuality: 80,
        maxWidth:     800,
        maxHeight:    800,
      );
      if (file != null && mounted) {
        context.read<StudentProvider>().setFileImage(file.path);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('✅ Photo updated from gallery!'),
              backgroundColor: Colors.green),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('⚠️ Could not access gallery. Check permissions.'),
              backgroundColor: Colors.orange),
        );
      }
    }
  }

  
  Future<void> _pickFromCamera() async {
    try {
      final XFile? file = await _picker.pickImage(
        source:       ImageSource.camera,
        imageQuality: 80,
        maxWidth:     800,
        maxHeight:    800,
        
      );
      if (file != null && mounted) {
        context.read<StudentProvider>().setFileImage(file.path);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('✅ Photo taken successfully!'),
              backgroundColor: Colors.green),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('⚠️ Could not access camera. Check permissions.'),
              backgroundColor: Colors.orange),
        );
      }
    }
  }


  Future<void> _saveProfile() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isLoading = true);
    await Future.delayed(const Duration(milliseconds: 500));
    setState(() => _isLoading = false);
    if (mounted) {
      context.read<StudentProvider>().updateStudent(
        name:  _nameCtrl.text.trim(),
        email: _emailCtrl.text.trim(),
        phone: _phoneCtrl.text.trim(),
      );
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('✅ Profile saved successfully!'),
            backgroundColor: Colors.green),
      );
      Navigator.pop(context);
    }
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _emailCtrl.dispose();
    _phoneCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<StudentProvider>();
    final imgType  = provider.profileImageType;
    final imgPath  = provider.profileImagePath;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F4FF),
      appBar: AppBar(title: const Text('Edit Profile')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        physics: const BouncingScrollPhysics(),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              //AVATAR SECTION
              Center(
                child: Column(
                  children: [
                    ProfileAvatar(
                      radius:        56,
                      showEditBadge: true,
                      onTap:         _showPhotoOptions,
                    ),
                    const SizedBox(height: 12),
                    TextButton.icon(
                      onPressed: _showPhotoOptions,
                      icon: const Icon(Icons.camera_alt_outlined,
                          size: 16, color: Color(0xFF4F46E5)),
                      label: const Text('Change Profile Photo',
                          style: TextStyle(
                              color: Color(0xFF4F46E5),
                              fontWeight: FontWeight.w600)),
                    ),
                    Text(
                      imgType == 'file'
                          ? '📷 Custom photo from gallery/camera'
                          : '🖼️ Default profile image',
                      style: const TextStyle(
                          fontSize: 11, color: Color(0xFF9CA3AF)),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

            
              if (imgPath.isNotEmpty)
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                      color: const Color(0xFFEEF2FF),
                      borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    children: [
                      ClipOval(
                        child: SizedBox(
                          width: 40, height: 40,
                          child: imgType == 'file'
                              ? Image.file(File(imgPath),
                                  fit: BoxFit.cover,
                                  errorBuilder: (_, __, ___) =>
                                      const Icon(Icons.person, color: Colors.grey))
                              : Image.asset(imgPath,
                                  fit: BoxFit.cover,
                                  errorBuilder: (_, __, ___) =>
                                      const Icon(Icons.person, color: Colors.grey)),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          imgType == 'file'
                              ? 'Custom photo is set as profile'
                              : 'Using default profile image',
                          style: const TextStyle(
                              fontSize: 12, color: Color(0xFF4F46E5)),
                        ),
                      ),
                      GestureDetector(
                        onTap: _showPhotoOptions,
                        child: const Text('Change',
                            style: TextStyle(
                                fontSize: 12, color: Color(0xFF4F46E5),
                                fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                ),

              const SizedBox(height: 24),

              const Text('Edit Your Information',
                  style: TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold,
                      color: Color(0xFF1F1F2E))),
              const SizedBox(height: 4),
              const Text('Name, email and phone can be updated.',
                  style: TextStyle(fontSize: 12, color: Color(0xFF9CA3AF))),
              const SizedBox(height: 20),

        
              CustomTextField(
                label: 'Full Name', hint: 'Enter your full name',
                controller: _nameCtrl,
                validator: (v) =>
                    (v == null || v.isEmpty) ? 'Name is required' : null,
              ),
              CustomTextField(
                label: 'Email Address', hint: 'Enter your email',
                controller: _emailCtrl, keyboardType: TextInputType.emailAddress,
                validator: (v) {
                  if (v == null || v.isEmpty) return 'Email is required';
                  if (!v.contains('@edu.pk')) return 'Enter a valid email';
                  return null;
                },
              ),
              CustomTextField(
                label: 'Phone Number', hint: '03XX-XXXXXXX',
                controller: _phoneCtrl, keyboardType: TextInputType.phone,
                validator: (v) =>
                    (v == null || v.isEmpty) ? 'Phone is required' : null,
              ),

              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                    color: const Color(0xFFF3F4F6),
                    borderRadius: BorderRadius.circular(10)),
                child: const Row(children: [
                  Icon(Icons.lock_outline, size: 16, color: Color(0xFF9CA3AF)),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'Roll number and room number cannot be changed until Admin Approve.',
                      style: TextStyle(fontSize: 12, color: Color(0xFF6B7280)),
                    ),
                  ),
                ]),
              ),

              const SizedBox(height: 28),

              SizedBox(
                width: double.infinity, height: 52,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _saveProfile,
                  child: _isLoading
                      ? const SizedBox(
                          width: 22, height: 22,
                          child: CircularProgressIndicator(
                              color: Colors.white, strokeWidth: 2.5))
                      : const Text('Save Changes'),
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}


class _PhotoOption extends StatelessWidget {
  final IconData     icon;
  final Color        color;
  final String       title;
  final String       subtitle;
  final VoidCallback onTap;

  const _PhotoOption({
    required this.icon,
    required this.color,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color:        color.withOpacity(0.06),
          borderRadius: BorderRadius.circular(12),
          border:       Border.all(color: color.withOpacity(0.2)),
        ),
        child: Row(children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: color.withOpacity(0.12), shape: BoxShape.circle),
            child: Icon(icon, color: color, size: 22),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                        fontWeight: FontWeight.w600, fontSize: 14,
                        color: Color(0xFF1F1F2E))),
                const SizedBox(height: 2),
                Text(subtitle,
                    style: const TextStyle(
                        fontSize: 12, color: Color(0xFF6B7280))),
              ],
            ),
          ),
          Icon(Icons.arrow_forward_ios,
              size: 14, color: color.withOpacity(0.5)),
        ]),
      ),
    );
  }
}