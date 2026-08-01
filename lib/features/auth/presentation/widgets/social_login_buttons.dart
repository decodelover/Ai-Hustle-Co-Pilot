/// Compact provider action row used by the premium auth surfaces.
library;

import 'package:ai_hustle_copilot/core/design_system/components/common/brand_icons.dart';
import 'package:ai_hustle_copilot/core/theme/app_colors.dart';
import 'package:ai_hustle_copilot/core/theme/app_radius.dart';
import 'package:ai_hustle_copilot/core/theme/app_spacing.dart';
import 'package:flutter/material.dart';

/// Reusable social authentication buttons for supported provider surfaces.
class SocialLoginButtons extends StatelessWidget {
  /// Creates a [SocialLoginButtons].
  const SocialLoginButtons({
    super.key,
    this.onFacebookPressed,
    this.onGooglePressed,
    this.onApplePressed,
    this.onLinkedInPressed,
    this.onGitHubPressed,
    this.isLoading = false,
    this.compact = true,
  });

  /// Facebook sign in callback.
  final VoidCallback? onFacebookPressed;

  /// Google sign in callback.
  final VoidCallback? onGooglePressed;

  /// Apple sign in callback.
  final VoidCallback? onApplePressed;

  /// LinkedIn sign in callback.
  final VoidCallback? onLinkedInPressed;

  /// Legacy GitHub sign in callback.
  final VoidCallback? onGitHubPressed;

  /// Global loading state indicator.
  final bool isLoading;

  /// Uses the three compact icon buttons shown in the reference experience.
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final buttons = compact
        ? [
            _SocialProviderButton(
              icon: const GoogleBrandIcon(size: 21),
              label: 'Google',
              onPressed: onGooglePressed,
              isDisabled: isLoading,
            ),
            _SocialProviderButton(
              icon: const AppleBrandIcon(size: 21),
              label: 'Apple',
              onPressed: onApplePressed,
              isDisabled: isLoading,
            ),
            _SocialProviderButton(
              icon: const _LinkedInBrandIcon(),
              label: 'LinkedIn',
              onPressed: onLinkedInPressed,
              isDisabled: isLoading,
            ),
          ]
        : [
            _SocialProviderButton(
              icon: const GoogleBrandIcon(),
              label: 'Google',
              onPressed: onGooglePressed,
              isDisabled: isLoading || onGooglePressed == null,
            ),
            _SocialProviderButton(
              icon: const GitHubBrandIcon(),
              label: 'GitHub',
              onPressed: onGitHubPressed,
              isDisabled: isLoading || onGitHubPressed == null,
            ),
          ];

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (var index = 0; index < buttons.length; index++) ...[
          if (index > 0) const SizedBox(width: AppSpacing.space12),
          buttons[index],
        ],
      ],
    );
  }
}

class _SocialProviderButton extends StatelessWidget {
  const _SocialProviderButton({
    required this.icon,
    required this.label,
    required this.onPressed,
    required this.isDisabled,
  });

  final Widget icon;
  final String label;
  final VoidCallback? onPressed;
  final bool isDisabled;
  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: 'Continue with $label',
      enabled: !isDisabled,
      child: OutlinedButton(
        onPressed: isDisabled ? null : onPressed,
        style: OutlinedButton.styleFrom(
          minimumSize: const Size(52, 48),
          fixedSize: const Size(52, 48),
          padding: EdgeInsets.zero,
          backgroundColor: Theme.of(context).brightness == Brightness.dark
              ? AppColors.darkSurface
              : AppColors.surface,
          foregroundColor: AppColors.primary,
          disabledForegroundColor: AppColors.primary,
          side: BorderSide(
            color: Theme.of(context).brightness == Brightness.dark
                ? AppColors.darkOutlineVariant
                : AppColors.outline,
          ),
          shape: const RoundedRectangleBorder(
            borderRadius: AppRadius.borderSmall,
          ),
        ),
        child: icon,
      ),
    );
  }
}

class _LinkedInBrandIcon extends StatelessWidget {
  const _LinkedInBrandIcon();

  @override
  Widget build(BuildContext context) {
    return const Text(
      'in',
      style: TextStyle(
        color: Color(0xFF0A66C2),
        fontSize: 19,
        fontWeight: FontWeight.w900,
        letterSpacing: -1.2,
      ),
    );
  }
}
