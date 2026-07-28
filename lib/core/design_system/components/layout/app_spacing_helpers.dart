/// Reusable spatial gap helpers for AI Hustle Co-Pilot design system.
library;

import 'package:ai_hustle_copilot/core/design_system/tokens/app_spacing.dart';
import 'package:flutter/material.dart';

/// Spatial gap helper widget using design tokens.
class AppGap extends StatelessWidget {
  const AppGap(this.size, {super.key});

  /// 4dp micro gap.
  const AppGap.xs({super.key}) : size = AppSpacing.xs;

  /// 8dp small gap.
  const AppGap.sm({super.key}) : size = AppSpacing.sm;

  /// 12dp medium gap.
  const AppGap.md({super.key}) : size = AppSpacing.md;

  /// 16dp large gap.
  const AppGap.lg({super.key}) : size = AppSpacing.lg;

  /// 20dp extra-large gap.
  const AppGap.xl({super.key}) : size = AppSpacing.xl;

  /// 24dp double-extra-large gap.
  const AppGap.xxl({super.key}) : size = AppSpacing.xxl;

  /// 32dp triple-extra-large gap.
  const AppGap.xxxl({super.key}) : size = AppSpacing.xxxl;

  final double size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: size, width: size);
  }
}

/// Vertical gap helper widget.
class VGap extends StatelessWidget {
  const VGap(this.height, {super.key});

  /// 4dp vertical gap.
  const VGap.xs({super.key}) : height = AppSpacing.xs;

  /// 8dp vertical gap.
  const VGap.sm({super.key}) : height = AppSpacing.sm;

  /// 12dp vertical gap.
  const VGap.md({super.key}) : height = AppSpacing.md;

  /// 16dp vertical gap.
  const VGap.lg({super.key}) : height = AppSpacing.lg;

  /// 20dp vertical gap.
  const VGap.xl({super.key}) : height = AppSpacing.xl;

  /// 24dp vertical gap.
  const VGap.xxl({super.key}) : height = AppSpacing.xxl;

  /// 32dp vertical gap.
  const VGap.xxxl({super.key}) : height = AppSpacing.xxxl;

  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: height);
  }
}

/// Horizontal gap helper widget.
class HGap extends StatelessWidget {
  const HGap(this.width, {super.key});

  /// 4dp horizontal gap.
  const HGap.xs({super.key}) : width = AppSpacing.xs;

  /// 8dp horizontal gap.
  const HGap.sm({super.key}) : width = AppSpacing.sm;

  /// 12dp horizontal gap.
  const HGap.md({super.key}) : width = AppSpacing.md;

  /// 16dp horizontal gap.
  const HGap.lg({super.key}) : width = AppSpacing.lg;

  /// 20dp horizontal gap.
  const HGap.xl({super.key}) : width = AppSpacing.xl;

  /// 24dp horizontal gap.
  const HGap.xxl({super.key}) : width = AppSpacing.xxl;

  final double width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(width: width);
  }
}
