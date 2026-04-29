import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String                     label;
  final String                     hint;
  final TextEditingController      controller;
  final bool                       obscureText;
  final TextInputType              keyboardType;
  final String? Function(String?)? validator;
  final Widget?                    suffixIcon;
  final Widget?                    prefixIcon;
  final int                        maxLines;
  final bool                       readOnly;

  const CustomTextField({
    super.key,
    required this.label,
    required this.hint,
    required this.controller,
    this.obscureText  = false,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.suffixIcon,
    this.prefixIcon,
    this.maxLines  = 1,
    this.readOnly  = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label.isNotEmpty) ...[
          Text(label,
              style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  color: Color(0xFF374151))),
          const SizedBox(height: 6),
        ],
        TextFormField(
          controller:   controller,
          obscureText:  obscureText,
          keyboardType: keyboardType,
          validator:    validator,
          maxLines:     maxLines,
          readOnly:     readOnly,
          style: const TextStyle(fontSize: 14, color: Color(0xFF1F1F2E)),
          decoration: InputDecoration(
            hintText:   hint,
            hintStyle:  const TextStyle(color: Color(0xFF9CA3AF), fontSize: 14),
            suffixIcon: suffixIcon,
            prefixIcon: prefixIcon,
            filled:     true,
            fillColor:  const Color(0xFFF9FAFB),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Color(0xFFE5E7EB))),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Color(0xFFE5E7EB))),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Color(0xFF4F46E5), width: 2)),
            errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Colors.red)),
            focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Colors.red, width: 2)),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}