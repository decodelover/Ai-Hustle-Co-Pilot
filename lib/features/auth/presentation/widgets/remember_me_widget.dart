/// Enterprise RememberMeWidget checkbox with reference design styling.
library;

import 'package:flutter/material.dart';

/// Reusable Remember Me checkbox widget.
class RememberMeWidget extends StatelessWidget {
  /// Creates a [RememberMeWidget].
  const RememberMeWidget({
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
    return InkWell(
      onTap: () => onChanged(!value),
      borderRadius: BorderRadius.circular(8.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
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
          const Text(
            'Remember me',
            style: TextStyle(
              color: Color(0xFF777777),
              fontSize: 13.0,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
