/// Enterprise AppAvatar component supporting network images, initials, asset images,
/// size scales (XS, SM, MD, LG, XL), and online status indicators.
library;

import 'package:ai_hustle_copilot/core/design_system/utils/context_extensions.dart';
import 'package:ai_hustle_copilot/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

/// Preset size options for [AppAvatar].
enum AppAvatarSize {
  /// Extra small avatar (24dp).
  xs,

  /// Small avatar (32dp).
  sm,

  /// Medium standard avatar (40dp).
  md,

  /// Large avatar (56dp).
  lg,

  /// Extra large avatar (72dp).
  xl,
}

/// Enterprise Material 3 Avatar component.
class AppAvatar extends StatelessWidget {
  /// Creates an [AppAvatar].
  const AppAvatar({
    super.key,
    this.imageUrl,
    this.assetPath,
    this.initials,
    this.name,
    this.size = AppAvatarSize.md,
    this.isOnline,
    this.onTap,
  });

  /// Remote image URL.
  final String? imageUrl;

  /// Local asset image path.
  final String? assetPath;

  /// Direct user initials string (e.g. "JD").
  final String? initials;

  /// Full name used to compute initials if [initials] is null.
  final String? name;

  /// Avatar size preset.
  final AppAvatarSize size;

  /// Optional online presence indicator badge.
  final bool? isOnline;

  /// Optional tap callback.
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final isDark = context.isDarkMode;

    final dimension = _getDimension();
    final fontSize = _getFontSize();
    final computedInitials = initials ?? _computeInitials(name);

    Widget avatarContent = CircleAvatar(
      radius: dimension / 2,
      backgroundColor: isDark
          ? AppColors.darkSurfaceVariant
          : AppColors.surfaceVariant,
      foregroundColor: isDark ? AppColors.darkOnSurface : AppColors.onSurface,
      backgroundImage: imageUrl != null && imageUrl!.isNotEmpty
          ? NetworkImage(imageUrl!) as ImageProvider
          : (assetPath != null && assetPath!.isNotEmpty
              ? AssetImage(assetPath!)
              : null),
      child: (imageUrl == null || imageUrl!.isEmpty) &&
              (assetPath == null || assetPath!.isEmpty)
          ? (computedInitials.isNotEmpty
              ? Text(
                  computedInitials,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontSize: fontSize,
                    fontWeight: FontWeight.w600,
                    color: isDark
                        ? AppColors.darkPrimary
                        : AppColors.primary,
                  ),
                )
              : Icon(
                  Icons.person_rounded,
                  size: dimension * 0.5,
                  color: isDark
                      ? AppColors.darkOnSurfaceVariant
                      : AppColors.onSurfaceVariant,
                ))
          : null,
    );

    if (isOnline != null) {
      final badgeSize = (dimension * 0.28).clamp(8.0, 18.0);
      avatarContent = Stack(
        clipBehavior: Clip.none,
        children: [
          avatarContent,
          Positioned(
            right: 0,
            bottom: 0,
            child: Container(
              width: badgeSize,
              height: badgeSize,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isOnline!
                    ? (isDark ? AppColors.darkSuccess : AppColors.success)
                    : (isDark ? AppColors.darkOnSurfaceVariant : AppColors.onSurfaceVariant),
                border: Border.all(
                  color: isDark ? AppColors.darkSurface : AppColors.surface,
                  width: 2.0,
                ),
              ),
            ),
          ),
        ],
      );
    }

    if (onTap != null) {
      avatarContent = GestureDetector(
        onTap: onTap,
        child: avatarContent,
      );
    }

    return Semantics(
      label: name ?? 'User Avatar',
      child: avatarContent,
    );
  }

  double _getDimension() {
    switch (size) {
      case AppAvatarSize.xs:
        return 24.0;
      case AppAvatarSize.sm:
        return 32.0;
      case AppAvatarSize.md:
        return 40.0;
      case AppAvatarSize.lg:
        return 56.0;
      case AppAvatarSize.xl:
        return 72.0;
    }
  }

  double _getFontSize() {
    switch (size) {
      case AppAvatarSize.xs:
        return 10.0;
      case AppAvatarSize.sm:
        return 12.0;
      case AppAvatarSize.md:
        return 14.0;
      case AppAvatarSize.lg:
        return 20.0;
      case AppAvatarSize.xl:
        return 26.0;
    }
  }

  String _computeInitials(String? fullName) {
    if (fullName == null || fullName.trim().isEmpty) return '';
    final parts = fullName.trim().split(RegExp(r'\s+'));
    if (parts.length == 1) return parts.first[0].toUpperCase();
    return (parts.first[0] + parts.last[0]).toUpperCase();
  }
}
