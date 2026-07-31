/// CreditWalletBadge — Credit Display Badge (Amendment 3.2G)
library;

import 'package:flutter/material.dart';

/// Top bar badge displaying current user AI credit balance.
class CreditWalletBadge extends StatelessWidget {
  /// Creates a [CreditWalletBadge].
  const CreditWalletBadge({super.key, this.credits = 485.0, this.onTap});

  /// Remaining credits.
  final double credits;

  /// Tap callback.
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20.0),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
        decoration: BoxDecoration(
          color: const Color(0xFF0D1B2A).withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(20.0),
          border: Border.all(
            color: const Color(0xFF0D1B2A).withValues(alpha: 0.15),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.bolt_rounded,
              color: Color(0xFFF59E0B),
              size: 16.0,
            ),
            const SizedBox(width: 4.0),
            Text(
              '${credits.toStringAsFixed(0)} credits',
              style: const TextStyle(
                color: Color(0xFF0D1B2A),
                fontSize: 12.0,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
