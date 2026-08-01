/// Premium Google and GitHub authentication action row.
library;

import 'package:ai_hustle_copilot/core/design_system/components/common/brand_icons.dart';
import 'package:flutter/material.dart';

/// Reusable social authentication buttons for supported provider surfaces.
class SocialLoginButtons extends StatelessWidget {
  /// Creates a [SocialLoginButtons].
  const SocialLoginButtons({
    super.key,
    this.onFacebookPressed,
    this.onGooglePressed,
    this.onApplePressed,
    this.onGitHubPressed,
    this.isLoading = false,
  });

  /// Facebook sign in callback.
  final VoidCallback? onFacebookPressed;

  /// Google sign in callback.
  final VoidCallback? onGooglePressed;

  /// Apple sign in callback.
  final VoidCallback? onApplePressed;

  /// Legacy GitHub sign in callback.
  final VoidCallback? onGitHubPressed;

  /// Global loading state indicator.
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final vertical = constraints.maxWidth < 380;
        final buttons = [
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
        if (vertical) {
          return Column(
            children: [buttons.first, const SizedBox(height: 12), buttons.last],
          );
        }
        return Row(
          children: [
            Expanded(child: buttons.first),
            const SizedBox(width: 12),
            Expanded(child: buttons.last),
          ],
        );
      },
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
      child: OutlinedButton.icon(
        onPressed: isDisabled ? null : onPressed,
        icon: icon,
        label: Text(label),
        style: OutlinedButton.styleFrom(
          minimumSize: const Size.fromHeight(52),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
    );
  }
}
