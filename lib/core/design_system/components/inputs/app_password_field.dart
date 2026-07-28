/// Enterprise AppPasswordField with built-in visibility toggle.
library;

import 'package:ai_hustle_copilot/core/design_system/components/buttons/app_icon_button.dart';
import 'package:ai_hustle_copilot/core/design_system/inputs/app_text_field.dart';
import 'package:flutter/material.dart';

/// Password input field wrapper widget.
class AppPasswordField extends StatefulWidget {
  /// Creates an [AppPasswordField].
  const AppPasswordField({
    super.key,
    this.controller,
    this.label = 'Password',
    this.hint = '••••••••',
    this.errorText,
    this.helperText,
    this.onChanged,
    this.onSubmitted,
    this.validator,
  });

  /// Text controller.
  final TextEditingController? controller;

  /// Field label text.
  final String? label;

  /// Placeholder hint.
  final String? hint;

  /// Error text.
  final String? errorText;

  /// Helper text.
  final String? helperText;

  /// Value change callback.
  final ValueChanged<String>? onChanged;

  /// Submitted callback.
  final ValueChanged<String>? onSubmitted;

  /// Validator callback.
  final String? Function(String?)? validator;

  @override
  State<AppPasswordField> createState() => _AppPasswordFieldState();
}

class _AppPasswordFieldState extends State<AppPasswordField> {
  bool _obscureText = true;

  void _toggleVisibility() {
    setState(() => _obscureText = !_obscureText);
  }

  @override
  Widget build(BuildContext context) {
    return AppTextField(
      controller: widget.controller,
      type: AppTextFieldType.password,
      label: widget.label,
      hint: widget.hint,
      errorText: widget.errorText,
      helperText: widget.helperText,
      onChanged: widget.onChanged,
      onSubmitted: widget.onSubmitted,
      validator: widget.validator,
      suffixIcon: AppIconButton(
        icon: _obscureText
            ? Icons.visibility_off_outlined
            : Icons.visibility_outlined,
        onPressed: _toggleVisibility,
        tooltip: _obscureText ? 'Show password' : 'Hide password',
      ),
    );
  }
}
