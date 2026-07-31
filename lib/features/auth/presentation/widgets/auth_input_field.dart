/// Dedicated AuthInputField component matching Master Design System V2.0 specs.
///
/// Features filled background (#F8FAFC), height 56, border radius 16,
/// label above field, floating focus border (#0D1B2A), and password eye toggle.
library;

import 'package:flutter/material.dart';

/// Pixel-perfect input field for authentication forms.
class AuthInputField extends StatefulWidget {
  /// Creates an [AuthInputField].
  const AuthInputField({
    required this.label,
    required this.hintText,
    super.key,
    this.controller,
    this.isPassword = false,
    this.keyboardType,
    this.errorText,
    this.isDisabled = false,
    this.onChanged,
    this.onSubmitted,
  });

  /// Label displayed above the input box.
  final String label;

  /// Placeholder hint text.
  final String hintText;

  /// Text editing controller.
  final TextEditingController? controller;

  /// Whether this field is an obscure password input.
  final bool isPassword;

  /// Keyboard type.
  final TextInputType? keyboardType;

  /// Error message text.
  final String? errorText;

  /// Disabled state flag.
  final bool isDisabled;

  /// Value change callback.
  final ValueChanged<String>? onChanged;

  /// Submitted callback.
  final ValueChanged<String>? onSubmitted;

  @override
  State<AuthInputField> createState() => _AuthInputFieldState();
}

class _AuthInputFieldState extends State<AuthInputField> {
  late bool _obscureText;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.isPassword;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          widget.label,
          style: const TextStyle(
            color: Color(0xFF111827),
            fontSize: 14.0,
            fontWeight: FontWeight.w600,
            letterSpacing: -0.1,
          ),
        ),
        const SizedBox(height: 8.0),
        SizedBox(
          height: widget.errorText != null ? 76.0 : 56.0,
          child: TextFormField(
            controller: widget.controller,
            enabled: !widget.isDisabled,
            obscureText: widget.isPassword && _obscureText,
            keyboardType: widget.keyboardType ??
                (widget.isPassword
                    ? TextInputType.visiblePassword
                    : TextInputType.text),
            onChanged: widget.onChanged,
            onFieldSubmitted: widget.onSubmitted,
            style: const TextStyle(
              color: Color(0xFF111827),
              fontSize: 14.0,
              fontWeight: FontWeight.w500,
            ),
            decoration: InputDecoration(
              hintText: widget.hintText,
              hintStyle: const TextStyle(
                color: Color(0xFF9CA3AF),
                fontSize: 14.0,
                fontWeight: FontWeight.w400,
              ),
              errorText: widget.errorText,
              filled: true,
              fillColor: const Color(0xFFF8FAFC),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 16.0,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16.0),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16.0),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16.0),
                borderSide: const BorderSide(
                  color: Color(0xFF0D1B2A),
                  width: 1.5,
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16.0),
                borderSide: const BorderSide(
                  color: Color(0xFFEF4444),
                  width: 1.5,
                ),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16.0),
                borderSide: const BorderSide(
                  color: Color(0xFFEF4444),
                  width: 1.5,
                ),
              ),
              suffixIcon: widget.isPassword
                  ? IconButton(
                      icon: Icon(
                        _obscureText
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                        color: const Color(0xFF6B7280),
                        size: 20.0,
                      ),
                      onPressed: () {
                        setState(() => _obscureText = !_obscureText);
                      },
                    )
                  : null,
            ),
          ),
        ),
      ],
    );
  }
}
