/// Production-ready enterprise AppTextField component supporting validation,
/// prefix/suffix icons, password visibility toggle, character counter, and Material 3 focus animation.
library;

import 'package:ai_hustle_copilot/core/design_system/utils/context_extensions.dart';
import 'package:ai_hustle_copilot/core/theme/app_colors.dart';
import 'package:ai_hustle_copilot/core/theme/app_radius.dart';
import 'package:ai_hustle_copilot/core/theme/app_spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Preset field type modes for [AppTextField].
enum AppTextFieldType {
  /// Standard text input.
  text,

  /// Email input with email keyboard.
  email,

  /// Obscurable password input with toggle button.
  password,

  /// Search input with search icon.
  search,

  /// Numeric input with digits keyboard.
  number,

  /// Multiline input area.
  multiline,
}

/// Enterprise Material 3 Text Field component.
class AppTextField extends StatefulWidget {
  /// Creates an [AppTextField].
  const AppTextField({
    super.key,
    this.controller,
    this.type = AppTextFieldType.text,
    this.label,
    this.hint,
    this.errorText,
    this.helperText,
    this.prefixIcon,
    this.suffixIcon,
    this.validator,
    this.onChanged,
    this.onSubmitted,
    this.enabled = true,
    this.isDisabled,
    this.readOnly = false,
    this.autofocus = false,
    this.isSuccess = false,
    this.maxLength,
    this.maxLines = 1,
    this.inputFormatters,
    this.keyboardType,
    this.textInputAction,
    this.focusNode,
  });

  /// Optional text editing controller.
  final TextEditingController? controller;

  /// Field type preset mode.
  final AppTextFieldType type;

  /// Optional field floating label.
  final String? label;

  /// Optional field placeholder hint.
  final String? hint;

  /// Explicit error message text (overrides internal validation).
  final String? errorText;

  /// Secondary helper caption text.
  final String? helperText;

  /// Optional leading prefix icon.
  final IconData? prefixIcon;

  /// Optional trailing suffix widget.
  final Widget? suffixIcon;

  /// Form validation callback.
  final String? Function(String?)? validator;

  /// Value change callback.
  final ValueChanged<String>? onChanged;

  /// Field submission callback.
  final ValueChanged<String>? onSubmitted;

  /// Enables field input when true.
  final bool enabled;

  /// Convenient inverse parameter for disabling field input.
  final bool? isDisabled;

  /// Read-only mode when true.
  final bool readOnly;

  /// Focuses field on render when true.
  final bool autofocus;

  /// Highlights border green for success state when true.
  final bool isSuccess;

  /// Maximum character limit.
  final int? maxLength;

  /// Maximum visible text lines.
  final int? maxLines;

  /// Custom input formatters.
  final List<TextInputFormatter>? inputFormatters;

  /// Keyboard input type override.
  final TextInputType? keyboardType;

  /// Keyboard action button.
  final TextInputAction? textInputAction;

  /// External FocusNode.
  final FocusNode? focusNode;

  /// Evaluates effective enabled state.
  bool get effectiveEnabled => isDisabled != null ? !isDisabled! : enabled;

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  late bool _obscureText;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.type == AppTextFieldType.password;
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final isDark = context.isDarkMode;

    final effectiveKeyboardType = _getKeyboardType();
    final effectivePrefixIcon = _getPrefixIcon();
    final effectiveSuffixIcon = _getSuffixIcon(isDark);

    final borderColor = widget.errorText != null
        ? (isDark ? AppColors.darkDanger : AppColors.danger)
        : widget.isSuccess
            ? (isDark ? AppColors.darkSuccess : AppColors.success)
            : (isDark ? AppColors.darkOutline : AppColors.outline);

    final focusedBorderColor = widget.errorText != null
        ? (isDark ? AppColors.darkDanger : AppColors.danger)
        : widget.isSuccess
            ? (isDark ? AppColors.darkSuccess : AppColors.success)
            : (isDark ? AppColors.darkPrimary : AppColors.primary);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (widget.label != null) ...[
          Text(
            widget.label!,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w500,
              color: isDark ? AppColors.darkOnSurface : AppColors.onSurface,
            ),
          ),
          const SizedBox(height: AppSpacing.space8),
        ],
        TextFormField(
          controller: widget.controller,
          focusNode: widget.focusNode,
          enabled: widget.effectiveEnabled,
          readOnly: widget.readOnly,
          autofocus: widget.autofocus,
          obscureText: widget.type == AppTextFieldType.password && _obscureText,
          keyboardType: effectiveKeyboardType,
          textInputAction: widget.textInputAction,
          maxLength: widget.maxLength,
          maxLines: widget.type == AppTextFieldType.multiline
              ? (widget.maxLines ?? 4)
              : 1,
          inputFormatters: widget.inputFormatters,
          onChanged: widget.onChanged,
          onFieldSubmitted: widget.onSubmitted,
          validator: widget.validator,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: isDark ? AppColors.darkOnSurface : AppColors.onSurface,
          ),
          decoration: InputDecoration(
            hintText: widget.hint,
            errorText: widget.errorText,
            helperText: widget.helperText,
            filled: true,
            fillColor: isDark
                ? AppColors.darkSurfaceVariant
                : AppColors.surfaceVariant,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.space16,
              vertical: AppSpacing.space12,
            ),
            prefixIcon: effectivePrefixIcon != null
                ? Icon(
                    effectivePrefixIcon,
                    size: 20.0,
                    color: isDark
                        ? AppColors.darkOnSurfaceVariant
                        : AppColors.onSurfaceVariant,
                  )
                : null,
            suffixIcon: effectiveSuffixIcon,
            border: OutlineInputBorder(
              borderRadius: AppRadius.borderMedium,
              borderSide: BorderSide(color: borderColor),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: AppRadius.borderMedium,
              borderSide: BorderSide(color: borderColor),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: AppRadius.borderMedium,
              borderSide: BorderSide(color: focusedBorderColor, width: 2.0),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: AppRadius.borderMedium,
              borderSide: BorderSide(
                color: isDark ? AppColors.darkDanger : AppColors.danger,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: AppRadius.borderMedium,
              borderSide: BorderSide(
                color: isDark ? AppColors.darkDanger : AppColors.danger,
                width: 2.0,
              ),
            ),
          ),
        ),
      ],
    );
  }

  TextInputType _getKeyboardType() {
    if (widget.keyboardType != null) return widget.keyboardType!;
    switch (widget.type) {
      case AppTextFieldType.email:
        return TextInputType.emailAddress;
      case AppTextFieldType.number:
        return TextInputType.number;
      case AppTextFieldType.multiline:
        return TextInputType.multiline;
      default:
        return TextInputType.text;
    }
  }

  IconData? _getPrefixIcon() {
    if (widget.prefixIcon != null) return widget.prefixIcon;
    switch (widget.type) {
      case AppTextFieldType.email:
        return Icons.email_outlined;
      case AppTextFieldType.password:
        return Icons.lock_outline_rounded;
      case AppTextFieldType.search:
        return Icons.search_rounded;
      default:
        return null;
    }
  }

  Widget? _getSuffixIcon(bool isDark) {
    if (widget.suffixIcon != null) return widget.suffixIcon;
    if (widget.type == AppTextFieldType.password) {
      return IconButton(
        icon: Icon(
          _obscureText
              ? Icons.visibility_outlined
              : Icons.visibility_off_outlined,
          size: 20.0,
          color: isDark
              ? AppColors.darkOnSurfaceVariant
              : AppColors.onSurfaceVariant,
        ),
        onPressed: () {
          setState(() => _obscureText = !_obscureText);
        },
      );
    }
    return null;
  }
}
