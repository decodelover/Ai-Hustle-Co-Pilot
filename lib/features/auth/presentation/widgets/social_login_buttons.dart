/// Enterprise SocialLoginButtons component matching master reference design.
///
/// Features Facebook, Google, and Apple social authentication options in
/// rounded square buttons (Radius 14).
library;

import 'package:ai_hustle_copilot/core/design_system/components/common/brand_icons.dart';
import 'package:flutter/material.dart';

/// Reusable social authentication buttons (Facebook, Google, Apple).
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _SocialSquareButton(
          icon: const FacebookBrandIcon(),
          onPressed: onFacebookPressed,
          isDisabled: isLoading,
          semanticLabel: 'Sign in with Facebook',
        ),
        const SizedBox(width: 16.0),
        _SocialSquareButton(
          icon: const GoogleBrandIcon(),
          onPressed: onGooglePressed,
          isDisabled: isLoading,
          semanticLabel: 'Sign in with Google',
        ),
        const SizedBox(width: 16.0),
        _SocialSquareButton(
          icon: const AppleBrandIcon(color: Colors.black),
          onPressed: onApplePressed ?? onGitHubPressed,
          isDisabled: isLoading,
          semanticLabel: 'Sign in with Apple',
        ),
      ],
    );
  }
}

class _SocialSquareButton extends StatefulWidget {
  const _SocialSquareButton({
    required this.icon,
    required this.onPressed,
    required this.isDisabled,
    required this.semanticLabel,
  });

  final Widget icon;
  final VoidCallback? onPressed;
  final bool isDisabled;
  final String semanticLabel;

  @override
  State<_SocialSquareButton> createState() => _SocialSquareButtonState();
}

class _SocialSquareButtonState extends State<_SocialSquareButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: widget.semanticLabel,
      enabled: !widget.isDisabled,
      child: GestureDetector(
        onTapDown: (_) {
          if (!widget.isDisabled) setState(() => _isPressed = true);
        },
        onTapUp: (_) {
          if (!widget.isDisabled) setState(() => _isPressed = false);
        },
        onTapCancel: () {
          if (!widget.isDisabled) setState(() => _isPressed = false);
        },
        onTap: widget.isDisabled ? null : widget.onPressed,
        child: AnimatedScale(
          scale: _isPressed ? 0.94 : 1.0,
          duration: const Duration(milliseconds: 100),
          child: Container(
            width: 52.0,
            height: 52.0,
            decoration: BoxDecoration(
              color: const Color(0xFFF4F5F8),
              borderRadius: BorderRadius.circular(14.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.03),
                  blurRadius: 8.0,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Center(child: widget.icon),
          ),
        ),
      ),
    );
  }
}
