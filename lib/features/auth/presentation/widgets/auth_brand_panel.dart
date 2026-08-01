/// Cinematic brand narrative panel used by authentication screens.
library;

import 'package:ai_hustle_copilot/core/design_system/design_system.dart';
import 'package:ai_hustle_copilot/features/auth/presentation/widgets/brand_identity_header.dart';
import 'package:flutter/material.dart';

/// Displays product identity, contextual copy, and an atmospheric feature mark.
class AuthBrandPanel extends StatelessWidget {
  /// Creates an authentication brand panel.
  const AuthBrandPanel({
    required this.eyebrow,
    required this.headline,
    required this.description,
    required this.icon,
    required this.onBack,
    super.key,
    this.compact = false,
  });

  /// Short contextual label.
  final String eyebrow;

  /// Main narrative headline.
  final String headline;

  /// Supporting narrative copy.
  final String description;

  /// Feature symbol.
  final IconData icon;

  /// Optional back action.
  final VoidCallback? onBack;

  /// Uses the compact mobile composition when true.
  final bool compact;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.primaryDarkBlue, AppColors.primaryBlue],
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            right: compact ? 20 : 48,
            bottom: compact ? 20 : 64,
            child: _AtmosphericMark(icon: icon, compact: compact),
          ),
          Padding(
            padding: EdgeInsets.all(
              compact ? AppSpacing.space16 : AppSpacing.space40,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BrandIdentityHeader(onBack: onBack, showTagline: false),
                const Spacer(),
                Text(
                  eyebrow.toUpperCase(),
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: AppColors.accentCoral,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.5,
                  ),
                ),
                const SizedBox(height: AppSpacing.space8),
                ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: compact ? 270 : 520),
                  child: Text(
                    headline,
                    maxLines: compact ? 2 : 3,
                    style:
                        (compact
                                ? Theme.of(context).textTheme.headlineMedium
                                : Theme.of(context).textTheme.displaySmall)
                            ?.copyWith(
                              color: AppColors.onPrimary,
                              fontWeight: FontWeight.w800,
                              height: 1.05,
                            ),
                  ),
                ),
                if (!compact) ...[
                  const SizedBox(height: AppSpacing.space16),
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 480),
                    child: Text(
                      description,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: AppColors.onPrimary.withValues(alpha: 0.76),
                        height: 1.5,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _AtmosphericMark extends StatelessWidget {
  const _AtmosphericMark({required this.icon, required this.compact});

  final IconData icon;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final size = compact ? 76.0 : 160.0;
    return IgnorePointer(
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.onPrimary.withValues(alpha: 0.06),
          border: Border.all(
            color: AppColors.onPrimary.withValues(alpha: 0.14),
          ),
        ),
        child: Icon(
          icon,
          size: compact ? 28 : 56,
          color: AppColors.onPrimary.withValues(alpha: 0.34),
        ),
      ),
    );
  }
}
