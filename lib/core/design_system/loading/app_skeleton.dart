/// Shimmering Skeleton loader components for the 4-state UI loading lifecycle.
///
/// Provides SkeletonCard, SkeletonText, SkeletonAvatar, SkeletonList, and SkeletonDashboard.
library;

import 'package:ai_hustle_copilot/core/design_system/utils/context_extensions.dart';
import 'package:ai_hustle_copilot/core/theme/app_colors.dart';
import 'package:ai_hustle_copilot/core/theme/app_motion.dart';
import 'package:ai_hustle_copilot/core/theme/app_radius.dart';
import 'package:ai_hustle_copilot/core/theme/app_spacing.dart';
import 'package:flutter/material.dart';

/// Base Shimmer wrapper creating continuous pulse animations.
class AppShimmer extends StatefulWidget {
  /// Creates an [AppShimmer].
  const AppShimmer({required this.child, super.key});

  /// Child skeleton target.
  final Widget child;

  @override
  State<AppShimmer> createState() => _AppShimmerState();
}

class _AppShimmerState extends State<AppShimmer>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: 0.4, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: AppMotion.decelerateCurve),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(opacity: _animation, child: widget.child);
  }
}

/// Generic skeleton block shape.
class AppSkeletonBlock extends StatelessWidget {
  /// Creates an [AppSkeletonBlock].
  const AppSkeletonBlock({
    super.key,
    this.width,
    this.height = 16.0,
    this.borderRadius = AppRadius.borderMedium,
  });

  /// Block width constraint.
  final double? width;

  /// Block height constraint.
  final double height;

  /// Corner radius bounds.
  final BorderRadius borderRadius;

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;
    final color = isDark
        ? AppColors.darkSkeletonStart
        : AppColors.skeletonStart;

    return AppShimmer(
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(color: color, borderRadius: borderRadius),
      ),
    );
  }
}

/// Text line skeleton loader.
class SkeletonText extends StatelessWidget {
  /// Creates a [SkeletonText].
  const SkeletonText({
    super.key,
    this.width,
    this.height = 14.0,
    this.lines = 1,
  });

  /// Width constraint.
  final double? width;

  /// Line height.
  final double height;

  /// Number of text lines.
  final int lines;

  @override
  Widget build(BuildContext context) {
    if (lines == 1) {
      return AppSkeletonBlock(width: width, height: height);
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: List.generate(
        lines,
        (index) => Padding(
          padding: EdgeInsets.only(
            bottom: index == lines - 1 ? 0 : AppSpacing.space8,
          ),
          child: AppSkeletonBlock(
            width: index == lines - 1 && width == null ? 180.0 : width,
            height: height,
          ),
        ),
      ),
    );
  }
}

/// Avatar circle skeleton loader.
class SkeletonAvatar extends StatelessWidget {
  /// Creates a [SkeletonAvatar].
  const SkeletonAvatar({super.key, this.size = 40.0});

  /// Avatar circle dimension.
  final double size;

  @override
  Widget build(BuildContext context) {
    return AppSkeletonBlock(
      width: size,
      height: size,
      borderRadius: BorderRadius.circular(size / 2),
    );
  }
}

/// Card container skeleton loader.
class SkeletonCard extends StatelessWidget {
  /// Creates a [SkeletonCard].
  const SkeletonCard({
    super.key,
    this.height = 120.0,
    this.padding = const EdgeInsets.all(AppSpacing.space16),
  });

  /// Card height.
  final double height;

  /// Content padding.
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return AppSkeletonBlock(
      height: height,
      borderRadius: AppRadius.borderLarge,
    );
  }
}

/// List view skeleton loader.
class SkeletonList extends StatelessWidget {
  /// Creates a [SkeletonList].
  const SkeletonList({super.key, this.itemCount = 5, this.itemHeight = 72.0});

  /// Number of list items.
  final int itemCount;

  /// Item height.
  final double itemHeight;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
        itemCount,
        (index) => Padding(
          padding: EdgeInsets.only(
            bottom: index == itemCount - 1 ? 0 : AppSpacing.space12,
          ),
          child: const Row(
            children: [
              SkeletonAvatar(),
              SizedBox(width: AppSpacing.space16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SkeletonText(width: 140.0),
                    SizedBox(height: AppSpacing.space8),
                    SkeletonText(width: 200.0, height: 12.0),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Complete dashboard grid skeleton loader.
class SkeletonDashboard extends StatelessWidget {
  /// Creates a [SkeletonDashboard].
  const SkeletonDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SkeletonText(width: 200.0, height: 28.0),
        SizedBox(height: AppSpacing.space24),
        Row(
          children: [
            Expanded(child: SkeletonCard(height: 100.0)),
            SizedBox(width: AppSpacing.space16),
            Expanded(child: SkeletonCard(height: 100.0)),
          ],
        ),
        SizedBox(height: AppSpacing.space24),
        SkeletonCard(height: 220.0),
        SizedBox(height: AppSpacing.space24),
        SkeletonList(itemCount: 3),
      ],
    );
  }
}
