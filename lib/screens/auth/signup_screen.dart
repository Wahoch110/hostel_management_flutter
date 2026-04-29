import 'package:flutter/material.dart';
import '../../routes/app_routes.dart';
import '../../widgets/custom_text_field.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});
  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey      = GlobalKey<FormState>();
  final _nameCtrl     = TextEditingController();
  final _emailCtrl    = TextEditingController();
  final _phoneCtrl    = TextEditingController();
  final _rollCtrl     = TextEditingController();
  final _cnicCtrl     = TextEditingController();
  final _passCtrl     = TextEditingController();
  bool  _obscurePass  = true;
  bool  _agreeTerms   = false;
  bool  _isLoading    = false;
  String _roomType    = 'Double';
  final List<String> _roomTypes = ['Single', 'Double', 'Triple', 'Quad'];

  Future<void> _signup() async {
    if (!_agreeTerms) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Please agree to terms and conditions'),
          backgroundColor: Colors.orange));
      return;
    }
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isLoading = true);
    await Future.delayed(const Duration(seconds: 2));
    setState(() => _isLoading = false);
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('✅ Account created! Please login.'),
          backgroundColor: Colors.green));
      Navigator.pushReplacementNamed(context, AppRoutes.login);
    }
  }

  @override
  void dispose() {
    _nameCtrl.dispose(); _emailCtrl.dispose(); _phoneCtrl.dispose();
    _rollCtrl.dispose(); _cnicCtrl.dispose();  _passCtrl.dispose();
    super.dispose();
  }

  InputDecoration _dropdownDecoration() => InputDecoration(
    filled: true, fillColor: const Color(0xFFF9FAFB),
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Color(0xFFE5E7EB))),
    enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Color(0xFFE5E7EB))),
    contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 30),
                GestureDetector(onTap: () => Navigator.pop(context),
                    child: const Icon(Icons.arrow_back_ios_new, size: 20, color: Color(0xFF374151))),
                const SizedBox(height: 24),
                const Text('Create Account 📝',
                    style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Color(0xFF1F1F2E))),
                const Text('Fill in your details to register',
                    style: TextStyle(fontSize: 14, color: Color(0xFF6B7280))),
                const SizedBox(height: 26),

                CustomTextField(label: 'Full Name', hint: 'e.g. Raza', controller: _nameCtrl,
                    validator: (v) => (v == null || v.isEmpty) ? 'Name is required' : null),
                CustomTextField(label: 'University Email', hint: 'e.g. raza@university.edu.pk',
                    controller: _emailCtrl, keyboardType: TextInputType.emailAddress,
                    validator: (v) {
                      if (v == null || v.isEmpty) return 'Email is required';
                      if (!v.contains('@')) return 'Enter a valid email';
                      return null;
                    }),
                CustomTextField(label: 'Phone Number', hint: '03XX-XXXXXXX',
                    controller: _phoneCtrl, keyboardType: TextInputType.phone,
                    validator: (v) => (v == null || v.isEmpty) ? 'Phone is required' : null),
                CustomTextField(label: 'Roll Number', hint: 'e.g. BS-SE-2380157',
                    controller: _rollCtrl,
                    validator: (v) => (v == null || v.isEmpty) ? 'Roll number required' : null),
                CustomTextField(label: 'CNIC', hint: 'XXXXX-XXXXXXX-X',
                    controller: _cnicCtrl, keyboardType: TextInputType.number,
                    validator: (v) => (v == null || v.isEmpty) ? 'CNIC is required' : null),

                const Text('Room Type Preference',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14, color: Color(0xFF374151))),
                const SizedBox(height: 6),
                DropdownButtonFormField<String>(
                  value: _roomType, decoration: _dropdownDecoration(),
                  items: _roomTypes.map((t) => DropdownMenuItem(value: t, child: Text(t))).toList(),
                  onChanged: (v) => setState(() => _roomType = v ?? 'Double'),
                ),
                const SizedBox(height: 16),

                CustomTextField(label: 'Password', hint: 'Minimum 6 characters',
                    controller: _passCtrl, obscureText: _obscurePass,
                    suffixIcon: GestureDetector(
                      onTap: () => setState(() => _obscurePass = !_obscurePass),
                      child: Icon(_obscurePass ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                          color: Colors.grey),
                    ),
                    validator: (v) {
                      if (v == null || v.isEmpty) return 'Password required';
                      if (v.length < 6) return 'Minimum 6 characters';
                      return null;
                    }),

                Row(children: [
                  Checkbox(
                    value: _agreeTerms, activeColor: const Color(0xFF4F46E5),
                    onChanged: (v) => setState(() => _agreeTerms = v ?? false),
                  ),
                  const Expanded(child: Text('I agree to the hostel terms and conditions',
                      style: TextStyle(fontSize: 13, color: Color(0xFF374151)))),
                ]),

                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity, height: 52,
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _signup,
                    child: _isLoading
                        ? const SizedBox(width: 22, height: 22,
                            child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2.5))
                        : const Text('Create Account'),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Already have an account? ', style: TextStyle(color: Color(0xFF6B7280))),
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Text('Login',
                          style: TextStyle(color: Color(0xFF4F46E5), fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}