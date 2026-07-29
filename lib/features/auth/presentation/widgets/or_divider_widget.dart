/// Enterprise OrDividerWidget displaying centered light gray divider text.
library;

import 'package:flutter/material.dart';

/// Reusable section separator widget with centered label text.
class OrDividerWidget extends StatelessWidget {
  /// Creates an [OrDividerWidget].
  const OrDividerWidget({
    super.key,
    this.label = 'Or Sign in with',
  });

  /// Custom divider text label.
  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: Center(
        child: Text(
          label,
          style: const TextStyle(
            color: Color(0xFF777777),
            fontSize: 13.0,
            fontWeight: FontWeight.w400,
            letterSpacing: 0.2,
          ),
        ),
      ),
    );
  }
}
