/// Enterprise AppSearchField with clear query trigger.
library;

import 'package:ai_hustle_copilot/core/design_system/components/buttons/app_icon_button.dart';
import 'package:ai_hustle_copilot/core/design_system/inputs/app_text_field.dart';
import 'package:flutter/material.dart';

/// Search input field widget.
class AppSearchField extends StatefulWidget {
  /// Creates an [AppSearchField].
  const AppSearchField({
    super.key,
    this.controller,
    this.hintText = 'Search...',
    this.onChanged,
    this.onSubmitted,
    this.onClear,
  });

  /// Text editing controller.
  final TextEditingController? controller;

  /// Placeholder hint.
  final String hintText;

  /// Value change callback.
  final ValueChanged<String>? onChanged;

  /// Search submit callback.
  final ValueChanged<String>? onSubmitted;

  /// Clear button callback.
  final VoidCallback? onClear;

  @override
  State<AppSearchField> createState() => _AppSearchFieldState();
}

class _AppSearchFieldState extends State<AppSearchField> {
  late final TextEditingController _effectiveController;
  bool _showClear = false;

  @override
  void initState() {
    super.initState();
    _effectiveController = widget.controller ?? TextEditingController();
    _effectiveController.addListener(_handleTextChanged);
    _showClear = _effectiveController.text.isNotEmpty;
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _effectiveController.dispose();
    } else {
      _effectiveController.removeListener(_handleTextChanged);
    }
    super.dispose();
  }

  void _handleTextChanged() {
    final hasText = _effectiveController.text.isNotEmpty;
    if (hasText != _showClear) {
      setState(() => _showClear = hasText);
    }
  }

  void _handleClear() {
    _effectiveController.clear();
    widget.onChanged?.call('');
    widget.onClear?.call();
  }

  @override
  Widget build(BuildContext context) {
    return AppTextField(
      controller: _effectiveController,
      type: AppTextFieldType.search,
      hint: widget.hintText,
      textInputAction: TextInputAction.search,
      onChanged: widget.onChanged,
      onSubmitted: widget.onSubmitted,
      suffixIcon: _showClear
          ? AppIconButton(
              icon: Icons.close_rounded,
              tooltip: 'Clear search query',
              onPressed: _handleClear,
            )
          : null,
    );
  }
}
