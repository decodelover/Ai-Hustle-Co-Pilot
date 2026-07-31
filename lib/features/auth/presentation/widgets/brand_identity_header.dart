/// Shared public brand identity row used by onboarding and authentication.
library;

import 'package:ai_hustle_copilot/core/theme/app_colors.dart';
import 'package:ai_hustle_copilot/core/theme/app_spacing.dart';
import 'package:flutter/material.dart';

/// Displays the AI Hustle Co-Pilot identity inside the navy hero surface.
class BrandIdentityHeader extends StatelessWidget {
  /// Creates a brand identity header.
  const BrandIdentityHeader({super.key, this.onBack, this.showTagline = true});

  /// Optional back action for account creation and nested auth screens.
  final VoidCallback? onBack;

  /// Whether to show the wider-screen product tagline.
  final bool showTagline;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final showWideTagline = showTagline && constraints.maxWidth >= 380;

        return Padding(
          padding: EdgeInsets.fromLTRB(
            onBack == null ? AppSpacing.space24 : AppSpacing.space8,
            AppSpacing.space12,
            AppSpacing.space24,
            AppSpacing.space16,
          ),
          child: Row(
            children: [
              if (onBack != null)
                IconButton(
                  tooltip: 'Back',
                  onPressed: onBack,
                  icon: const Icon(
                    Icons.arrow_back_rounded,
                    color: AppColors.onPrimary,
                  ),
                ),
              const _AiBrandMark(),
              const SizedBox(width: AppSpacing.space12),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'AI Hustle Co-Pilot',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: AppColors.onPrimary,
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        letterSpacing: -0.2,
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      '@aihustlecopilot',
                      style: TextStyle(
                        color: AppColors.onPrimary,
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
              if (showWideTagline) ...[
                const SizedBox(width: AppSpacing.space12),
                const Icon(
                  Icons.auto_awesome,
                  color: AppColors.onPrimary,
                  size: 18,
                ),
                const SizedBox(width: AppSpacing.space8),
                const Flexible(
                  child: Text(
                    'AI-powered freelance success',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: AppColors.onPrimary,
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ],
          ),
        );
      },
    );
  }
}

class _AiBrandMark extends StatelessWidget {
  const _AiBrandMark();

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'AI Hustle Co-Pilot logo',
      image: true,
      child: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: AppColors.onPrimary.withValues(alpha: 0.72),
            width: 1.4,
          ),
          color: AppColors.onPrimary.withValues(alpha: 0.08),
        ),
        child: const Center(
          child: Text(
            'AI',
            style: TextStyle(
              color: AppColors.onPrimary,
              fontSize: 18,
              fontWeight: FontWeight.w700,
              letterSpacing: -1,
            ),
          ),
        ),
      ),
    );
  }
}
