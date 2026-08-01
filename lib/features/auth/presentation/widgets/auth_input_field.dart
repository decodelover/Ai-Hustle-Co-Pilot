/// Dedicated AuthInputField component matching Master Design System V2.0 specs.
///
/// Features filled background (#F8FAFC), height 56, border radius 16,
/// label above field, floating focus border (#0D1B2A), and password eye toggle.
library;

import 'package:ai_hustle_copilot/core/theme/app_colors.dart';
import 'package:ai_hustle_copilot/core/theme/app_radius.dart';
import 'package:ai_hustle_copilot/core/theme/app_spacing.dart';
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
    this.textInputAction,
    this.autofillHints,
    this.focusNode,
    this.maxLength,
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

  /// Keyboard action displayed for this field.
  final TextInputAction? textInputAction;

  /// Platform autofill hints.
  final Iterable<String>? autofillHints;

  /// Optional focus node for keyboard flow.
  final FocusNode? focusNode;

  /// Optional maximum character count.
  final int? maxLength;

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
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
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
          style: theme.textTheme.labelLarge?.copyWith(
            color: isDark ? AppColors.darkOnSurface : AppColors.onSurface,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: AppSpacing.space8),
        TextFormField(
          controller: widget.controller,
          focusNode: widget.focusNode,
          enabled: !widget.isDisabled,
          obscureText: widget.isPassword && _obscureText,
          keyboardType:
              widget.keyboardType ??
              (widget.isPassword
                  ? TextInputType.visiblePassword
                  : TextInputType.text),
          onChanged: widget.onChanged,
          onFieldSubmitted: widget.onSubmitted,
          textInputAction: widget.textInputAction,
          autofillHints: widget.autofillHints,
          maxLength: widget.maxLength,
          style: theme.textTheme.bodyLarge?.copyWith(
            color: isDark ? AppColors.darkOnSurface : AppColors.onSurface,
            fontWeight: FontWeight.w500,
          ),
          decoration: InputDecoration(
            hintText: widget.hintText,
            counterText: '',
            filled: true,
            fillColor: isDark
                ? AppColors.darkSurfaceVariant
                : AppColors.surfaceVariant,
            hintStyle: theme.textTheme.bodyMedium?.copyWith(
              color: isDark
                  ? AppColors.darkOnSurfaceVariant
                  : AppColors.onSurfaceVariant,
            ),
            prefixIcon: Padding(
              padding: const EdgeInsets.only(left: 4),
              child: Icon(
                icon,
                color: isDark
                    ? AppColors.darkOnSurfaceVariant
                    : AppColors.onSurfaceVariant,
                size: 20,
              ),
            ),
            prefixIconConstraints: const BoxConstraints(
              minWidth: 48,
              minHeight: 56,
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.space16,
              vertical: AppSpacing.space16,
            ),
            border: const OutlineInputBorder(
              borderRadius: AppRadius.borderMedium,
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: AppRadius.borderMedium,
              borderSide: BorderSide(
                color: isDark
                    ? AppColors.darkOutlineVariant
                    : AppColors.outlineVariant,
              ),
            ),
            focusedBorder: const OutlineInputBorder(
              borderRadius: AppRadius.borderMedium,
              borderSide: BorderSide(color: AppColors.primary, width: 2),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: AppRadius.borderMedium,
              borderSide: BorderSide(
                color: isDark ? AppColors.darkOutline : AppColors.outline,
              ),
            ),
            errorBorder: const OutlineInputBorder(
              borderRadius: AppRadius.borderMedium,
              borderSide: BorderSide(color: AppColors.danger),
            ),
            focusedErrorBorder: const OutlineInputBorder(
              borderRadius: AppRadius.borderMedium,
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
                      color: isDark
                          ? AppColors.darkOnSurfaceVariant
                          : AppColors.onSurfaceVariant,
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
