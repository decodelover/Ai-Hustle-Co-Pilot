/// Reusable Multiline Input component for AI Hustle Co-Pilot design system.
library;

import 'package:ai_hustle_copilot/core/design_system/components/inputs/app_text_field.dart';
import 'package:flutter/material.dart';

/// Multi-line text field for long-form content (proposals, descriptions).
class AppMultilineField extends StatelessWidget {
  const AppMultilineField({
    super.key,
    this.controller,
    this.label,
    this.hintText = 'Enter details...',
    this.errorText,
    this.helperText,
    this.minLines = 3,
    this.maxLines = 6,
    this.onChanged,
  });

  final TextEditingController? controller;
  final String? label;
  final String hintText;
  final String? errorText;
  final String? helperText;
  final int minLines;
  final int maxLines;
  final ValueChanged<String>? onChanged;

  @override
  Widget build(BuildContext context) {
    return AppTextField(
      controller: controller,
      label: label,
      hintText: hintText,
      errorText: errorText,
      helperText: helperText,
      keyboardType: TextInputType.multiline,
      minLines: minLines,
      maxLines: maxLines,
      onChanged: onChanged,
    );
  }
}
