/// Dedicated AuthInputField component matching Master Design System V2.0 specs.
///
/// Features filled background (#F8FAFC), height 56, border radius 16,
/// label above field, floating focus border (#0D1B2A), and password eye toggle.
library;

import 'package:ai_hustle_copilot/core/theme/app_colors.dart';
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
    final icon = widget.isPassword
        ? Icons.lock_outline_rounded
        : widget.label.toLowerCase().contains('email')
        ? Icons.mail_outline_rounded
        : Icons.person_outline_rounded;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          widget.label,
          style: const TextStyle(
            color: AppColors.primaryText,
            fontSize: 15.0,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 6),
        TextFormField(
          controller: widget.controller,
          enabled: !widget.isDisabled,
          obscureText: widget.isPassword && _obscureText,
          keyboardType:
              widget.keyboardType ??
              (widget.isPassword
                  ? TextInputType.visiblePassword
                  : TextInputType.text),
          onChanged: widget.onChanged,
          onFieldSubmitted: widget.onSubmitted,
          style: const TextStyle(
            color: AppColors.primaryText,
            fontSize: 15.0,
            fontWeight: FontWeight.w500,
          ),
          decoration: InputDecoration(
            hintText: widget.hintText,
            hintStyle: const TextStyle(
              color: AppColors.mutedText,
              fontSize: 14.0,
              fontWeight: FontWeight.w400,
            ),
            prefixIcon: Padding(
              padding: const EdgeInsets.only(right: 8),
              child: Icon(icon, color: AppColors.secondaryText, size: 19),
            ),
            prefixIconConstraints: const BoxConstraints(
              minWidth: 27,
              minHeight: 48,
            ),
            contentPadding: const EdgeInsets.only(top: 8, bottom: 9),
            border: const UnderlineInputBorder(
              borderSide: BorderSide(color: AppColors.outlineVariant),
            ),
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: AppColors.outlineVariant),
            ),
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: AppColors.primary, width: 2),
            ),
            disabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: AppColors.outline),
            ),
            errorBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: AppColors.danger),
            ),
            focusedErrorBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: AppColors.danger, width: 2),
            ),
            errorText: widget.errorText,
            errorStyle: const TextStyle(
              color: AppColors.danger,
              fontSize: 12,
              height: 1.2,
            ),
            suffixIcon: widget.isPassword
                ? IconButton(
                    tooltip: _obscureText ? 'Show password' : 'Hide password',
                    icon: Icon(
                      _obscureText
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                      color: AppColors.secondaryText,
                      size: 20,
                    ),
                    onPressed: () {
                      setState(() => _obscureText = !_obscureText);
                    },
                  )
                : null,
          ),
        ),
      ],
    );
  }
}
