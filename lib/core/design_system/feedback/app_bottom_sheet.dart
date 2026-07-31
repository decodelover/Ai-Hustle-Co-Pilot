/// Reusable Material 3 AppBottomSheet component supporting title, handle bar,
/// scrollable content, and responsive layout constraints.
library;

import 'package:ai_hustle_copilot/core/design_system/utils/context_extensions.dart';
import 'package:ai_hustle_copilot/core/theme/app_colors.dart';
import 'package:ai_hustle_copilot/core/theme/app_radius.dart';
import 'package:ai_hustle_copilot/core/theme/app_shadows.dart';
import 'package:ai_hustle_copilot/core/theme/app_spacing.dart';
import 'package:flutter/material.dart';

/// Enterprise Material 3 Bottom Sheet component.
class AppBottomSheet extends StatelessWidget {
  /// Creates an [AppBottomSheet].
  const AppBottomSheet({
    required this.child,
    super.key,
    this.title,
    this.padding = const EdgeInsets.all(AppSpacing.space24),
  });

  /// Static helper to trigger an [AppBottomSheet].
  static Future<T?> show<T>({
    required BuildContext context,
    required Widget child,
    String? title,
    bool isScrollControlled = true,
  }) {
    return showModalBottomSheet<T>(
      context: context,
      isScrollControlled: isScrollControlled,
      backgroundColor: Colors.transparent,
      builder: (context) => AppBottomSheet(title: title, child: child),
    );
  }

  /// Optional header title string.
  final String? title;

  /// Inner body widget content.
  final Widget child;

  /// Content padding.
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final isDark = context.isDarkMode;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkSurface : AppColors.surface,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(AppRadius.xLarge),
        ),
        boxShadow: isDark ? AppShadows.darkLg : AppShadows.lightLg,
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: padding,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Drag Handle Bar
              Center(
                child: Container(
                  width: 36.0,
                  height: 4.0,
                  decoration: BoxDecoration(
                    color: isDark
                        ? AppColors.darkOutlineVariant
                        : AppColors.outlineVariant,
                    borderRadius: AppRadius.borderPill,
                  ),
                ),
              ),
              if (title != null) ...[
                const SizedBox(height: AppSpacing.space16),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        title!,
                        style: theme.textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: isDark
                              ? AppColors.darkOnSurface
                              : AppColors.onSurface,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close_rounded, size: 20.0),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ],
                ),
              ],
              const SizedBox(height: AppSpacing.space16),
              Flexible(child: SingleChildScrollView(child: child)),
            ],
          ),
        ),
      ),
    );
  }
}
