/// Shared AI Hustle Co-Pilot identity row used by onboarding and auth.
library;

import 'package:ai_hustle_copilot/core/theme/app_colors.dart';
import 'package:ai_hustle_copilot/core/theme/app_spacing.dart';
import 'package:flutter/material.dart';

/// Displays the compact product mark used throughout the public experience.
class BrandIdentityHeader extends StatelessWidget {
  /// Creates a brand identity header.
  const BrandIdentityHeader({
    super.key,
    this.onBack,
    this.showTagline = true,
    this.onDarkSurface = true,
    this.compact = false,
  });

  /// Optional back action for nested auth screens.
  final VoidCallback? onBack;

  /// Whether to show the wider-screen product tagline.
  final bool showTagline;

  /// Whether the header sits on the navy onboarding/brand surface.
  final bool onDarkSurface;

  /// Uses the smaller mark spacing used in form headers.
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final foreground = onDarkSurface
        ? AppColors.onPrimary
        : AppColors.primaryText;
    final secondaryForeground = onDarkSurface
        ? AppColors.onPrimary.withValues(alpha: 0.68)
        : AppColors.secondaryText;

    return Row(
      children: [
        if (onBack != null)
          IconButton(
            tooltip: 'Back',
            onPressed: onBack,
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints.tightFor(
              width: AppSpacing.space48,
              height: AppSpacing.space48,
            ),
            icon: Icon(Icons.arrow_back_rounded, color: foreground),
          ),
        _AiBrandMark(onDarkSurface: onDarkSurface, compact: compact),
        SizedBox(width: compact ? AppSpacing.space8 : AppSpacing.space12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'AI Hustle Co-Pilot',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: foreground,
                  fontSize: compact ? 14 : 16,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -0.25,
                ),
              ),
              if (showTagline)
                Text(
                  'AI-powered freelance success',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: secondaryForeground,
                    fontSize: compact ? 10 : 11,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.1,
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}

class _AiBrandMark extends StatelessWidget {
  const _AiBrandMark({required this.onDarkSurface, required this.compact});

  final bool onDarkSurface;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final size = compact ? 36.0 : 42.0;
    final markBackground = onDarkSurface
        ? AppColors.background
        : AppColors.primary;
    final markForeground = onDarkSurface
        ? AppColors.primary
        : AppColors.onPrimary;

    return Semantics(
      label: 'AI Hustle Co-Pilot logo',
      image: true,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: markBackground,
          borderRadius: BorderRadius.circular(compact ? 10 : 12),
          border: Border.all(
            color: onDarkSurface
                ? AppColors.onPrimary.withValues(alpha: 0.28)
                : AppColors.primary.withValues(alpha: 0.12),
          ),
          boxShadow: onDarkSurface
              ? null
              : const [
                  BoxShadow(
                    color: Color(0x140D1B2A),
                    blurRadius: 8,
                    offset: Offset(0, 3),
                  ),
                ],
        ),
        child: Center(
          child: Text(
            'AI',
            style: TextStyle(
              color: markForeground,
              fontSize: compact ? 13 : 15,
              fontWeight: FontWeight.w900,
              letterSpacing: -1,
            ),
          ),
        ),
      ),
    );
  }
}
