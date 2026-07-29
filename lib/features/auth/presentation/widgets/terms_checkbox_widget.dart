/// Enterprise TermsCheckboxWidget matching reference design.
library;

import 'package:ai_hustle_copilot/core/design_system/feedback/app_dialog.dart';
import 'package:flutter/material.dart';

/// Reusable terms and conditions agreement checkbox widget.
class TermsCheckboxWidget extends StatelessWidget {
  /// Creates a [TermsCheckboxWidget].
  const TermsCheckboxWidget({
    required this.value,
    required this.onChanged,
    super.key,
  });

  /// Checkbox value state.
  final bool value;

  /// Value change callback.
  final ValueChanged<bool?> onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 24.0,
          height: 24.0,
          child: Checkbox(
            value: value,
            onChanged: onChanged,
            activeColor: const Color(0xFF3D82F7),
            checkColor: Colors.white,
            side: const BorderSide(color: Color(0xFFCCCCCC), width: 1.5),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
            ),
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
        ),
        const SizedBox(width: 8.0),
        Expanded(
          child: GestureDetector(
            onTap: () => onChanged(!value),
            child: Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                const Text(
                  'I agree to the ',
                  style: TextStyle(
                    color: Color(0xFF777777),
                    fontSize: 13.0,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    AppDialog.show<void>(
                      context: context,
                      title: 'Terms of Service',
                      description:
                          'By using AI Hustle Co-Pilot, you agree to comply with our terms and enterprise user policies.',
                      primaryActionText: 'Close',
                    );
                  },
                  child: const Text(
                    'Terms of Service',
                    style: TextStyle(
                      color: Color(0xFF3D82F7),
                      fontSize: 13.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
