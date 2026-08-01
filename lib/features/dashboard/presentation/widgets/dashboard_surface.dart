/// Shared premium dashboard surfaces and section headers.
library;

import 'package:ai_hustle_copilot/core/theme/app_colors.dart';
import 'package:ai_hustle_copilot/core/theme/app_motion.dart';
import 'package:ai_hustle_copilot/core/theme/app_radius.dart';
import 'package:ai_hustle_copilot/core/theme/app_shadows.dart';
import 'package:ai_hustle_copilot/core/theme/app_spacing.dart';
import 'package:flutter/material.dart';

/// Visual tone for a dashboard surface.
enum DashboardSurfaceTone { standard, subtle, navy }

/// Reusable layered surface with keyboard focus, hover, and press feedback.
class DashboardSurface extends StatefulWidget {
  /// Creates a dashboard surface.
  const DashboardSurface({
    required this.child,
    this.tone = DashboardSurfaceTone.standard,
    this.onTap,
    this.padding = const EdgeInsets.all(AppSpacing.space20),
    this.semanticLabel,
    super.key,
  });

  /// Content rendered inside the surface.
  final Widget child;

  /// Surface tone.
  final DashboardSurfaceTone tone;

  /// Optional interaction callback.
  final VoidCallback? onTap;

  /// Inner padding.
  final EdgeInsetsGeometry padding;

  /// Optional accessible name for interactive surfaces.
  final String? semanticLabel;

  @override
  State<DashboardSurface> createState() => _DashboardSurfaceState();
}

class _DashboardSurfaceState extends State<DashboardSurface> {
  bool _isHovered = false;
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isNavy = widget.tone == DashboardSurfaceTone.navy;
    final background = switch (widget.tone) {
      DashboardSurfaceTone.standard =>
        isDark ? AppColors.darkSurface : AppColors.surface,
      DashboardSurfaceTone.subtle =>
        isDark ? AppColors.darkSurfaceVariant : AppColors.surfaceVariant,
      DashboardSurfaceTone.navy => AppColors.primaryDarkBlue,
    };
    final border = isNavy
        ? AppColors.onPrimary.withValues(alpha: 0.14)
        : isDark
        ? AppColors.darkOutline
        : AppColors.outline;
    final radius = widget.tone == DashboardSurfaceTone.navy
        ? AppRadius.borderXLarge
        : AppRadius.borderLarge;
    final scale = _isPressed
        ? AppMotion.pressScale
        : _isHovered && widget.onTap != null
        ? 1.006
        : 1.0;

    return Semantics(
      label: widget.semanticLabel,
      button: widget.onTap != null,
      child: MouseRegion(
        cursor: widget.onTap == null
            ? MouseCursor.defer
            : SystemMouseCursors.click,
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        child: AnimatedScale(
          scale: scale,
          duration: AppMotion.fast,
          curve: AppMotion.standardCurve,
          child: AnimatedContainer(
            duration: AppMotion.medium,
            curve: AppMotion.standardCurve,
            decoration: BoxDecoration(
              color: background,
              borderRadius: radius,
              border: Border.all(color: border),
              boxShadow: _isHovered && widget.onTap != null
                  ? isDark
                        ? AppShadows.darkMd
                        : AppShadows.lightMd
                  : isDark
                  ? AppShadows.darkSm
                  : AppShadows.lightSm,
            ),
            child: Material(
              color: Colors.transparent,
              shape: RoundedRectangleBorder(borderRadius: radius),
              clipBehavior: Clip.antiAlias,
              child: InkWell(
                onTap: widget.onTap,
                onHighlightChanged: (value) {
                  if (widget.onTap != null) setState(() => _isPressed = value);
                },
                borderRadius: radius,
                overlayColor: WidgetStatePropertyAll(
                  isNavy ? AppColors.darkHoverOverlay : AppColors.hoverOverlay,
                ),
                child: Padding(padding: widget.padding, child: widget.child),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Consistent title row for dashboard content groups.
class DashboardSectionHeader extends StatelessWidget {
  /// Creates a dashboard section header.
  const DashboardSectionHeader({
    required this.title,
    this.subtitle,
    this.eyebrow,
    this.actionLabel,
    this.onAction,
    super.key,
  });

  final String title;
  final String? subtitle;
  final String? eyebrow;
  final String? actionLabel;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (eyebrow != null) ...[
                Text(
                  eyebrow!,
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: theme.colorScheme.secondary,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.2,
                  ),
                ),
                const SizedBox(height: AppSpacing.space4),
              ],
              Text(
                title,
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                  letterSpacing: -0.2,
                ),
              ),
              if (subtitle != null) ...[
                const SizedBox(height: AppSpacing.space4),
                Text(
                  subtitle!,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                    height: 1.45,
                  ),
                ),
              ],
            ],
          ),
        ),
        if (actionLabel != null)
          TextButton(onPressed: onAction, child: Text(actionLabel!)),
      ],
    );
  }
}
