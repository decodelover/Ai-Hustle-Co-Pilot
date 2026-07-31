/// Reusable Number Input component for AI Hustle Co-Pilot design system.
library;

import 'package:ai_hustle_copilot/core/design_system/components/inputs/app_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Numeric input field for rates, budgets, and numerical values.
class AppNumberField extends StatelessWidget {
  const AppNumberField({
    super.key,
    this.controller,
    this.label,
    this.hintText = '0.00',
    this.errorText,
    this.helperText,
    this.prefixText,
    this.suffixText,
    this.allowDecimals = true,
    this.onChanged,
    this.onSubmitted,
  });

  final TextEditingController? controller;
  final String? label;
  final String hintText;
  final String? errorText;
  final String? helperText;
  final String? prefixText;
  final String? suffixText;
  final bool allowDecimals;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;

  @override
  Widget build(BuildContext context) {
    return AppTextField(
      controller: controller,
      label: label,
      hintText: hintText,
      errorText: errorText,
      helperText: helperText,
      keyboardType: TextInputType.numberWithOptions(decimal: allowDecimals),
      inputFormatters: [
        if (allowDecimals)
          FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*'))
        else
          FilteringTextInputFormatter.digitsOnly,
      ],
      prefixIcon: prefixText != null
          ? Padding(
              padding: const EdgeInsets.only(left: 16, right: 8),
              child: Center(
                widthFactor: 1,
                child: Text(
                  prefixText!,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            )
          : null,
      suffixIcon: suffixText != null
          ? Padding(
              padding: const EdgeInsets.only(right: 16, left: 8),
              child: Center(
                widthFactor: 1,
                child: Text(
                  suffixText!,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
            )
          : null,
      onChanged: onChanged,
      onSubmitted: onSubmitted,
    );
  }
}
